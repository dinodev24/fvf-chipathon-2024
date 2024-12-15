from glayout.flow.pdk.mappedpdk import MappedPDK
from glayout.flow.pdk.sky130_mapped import sky130_mapped_pdk
from gdsfactory import Component

from glayout.flow.pdk.util.comp_utils import evaluate_bbox, prec_ref_center, prec_center, align_comp_to_port
from glayout.flow.pdk.util.port_utils import rename_ports_by_orientation
from glayout.flow.pdk.util.snap_to_grid import component_snap_to_grid
from gdsfactory.components import text_freetype, rectangle


from glayout.flow.routing.straight_route import straight_route
from c_route import c_route
from glayout.flow.routing.L_route import L_route
from fvf import fvf_netlist, flipped_voltage_follower
from cm import current_mirror, current_mirror_netlist
from glayout.flow.primitives.via_gen import via_stack, via_array
from glayout.flow.primitives.fet import nmos, pmos, multiplier
from transmission_gate import transmission_gate
from p_block import p_block
from n_block import n_block
#from lvt_cmirror import low_voltage_cmirror

def sky130_add_ota_labels(ota_in: Component) -> Component:
	
    ota_in.unlock()
    # define layers
    met1_pin = (68,16)
    met1_label = (68,5)
    met2_pin = (69,16)
    met2_label = (69,5)
    met3_pin = (70,16)
    met3_label = (70,5)
    # list that will contain all port/comp info
    move_info = list()
    # create labels and append to info list
    # gnd
    gndlabel = rectangle(layer=met2_pin,size=(0.5,0.5),centered=True).copy()
    gndlabel.add_label(text="AVSS",layer=met2_label)
    move_info.append((gndlabel,ota_in.ports["VSS_top_met_N"],None))
    
    #currentbias
    ibias1label = rectangle(layer=met3_pin,size=(0.5,0.5),centered=True).copy()
    ibias1label.add_label(text="NB_10U",layer=met3_label)
    move_info.append((ibias1label,ota_in.ports["IBIAS1_top_met_N"],None))
    ibias2label = rectangle(layer=met3_pin,size=(0.5,0.5),centered=True).copy()
    ibias2label.add_label(text="NBC_10U",layer=met3_label)
    move_info.append((ibias2label,ota_in.ports["IBIAS2_top_met_N"],None))
    
    #vcc
    vcclabel = rectangle(layer=met2_pin,size=(0.5,0.5),centered=True).copy()
    vcclabel.add_label(text="AVDD",layer=met2_label)
    move_info.append((vcclabel,ota_in.ports["VCC_top_met_N"],None))
    
    # output (3rd stage)
    outputlabel = rectangle(layer=met3_pin,size=(0.5,0.5),centered=True).copy()
    outputlabel.add_label(text="VOUT",layer=met3_label)
    move_info.append((outputlabel,ota_in.ports["DIFFOUT_top_met_N"],None))
    
    # input
    p_inputlabel = rectangle(layer=met3_pin,size=(0.5,0.5),centered=True).copy()
    p_inputlabel.add_label(text="INP",layer=met3_label)
    move_info.append((p_inputlabel,ota_in.ports["PLUS_top_met_N"], None))   
    m_inputlabel = rectangle(layer=met3_pin,size=(0.5,0.5),centered=True).copy()
    m_inputlabel.add_label(text="INM",layer=met3_label)
    move_info.append((m_inputlabel,ota_in.ports["MINUS_top_met_N"], None))
    
    # move everything to position
    for comp, prt, alignment in move_info:
        alignment = ('c','b') if alignment is None else alignment
        compref = align_comp_to_port(comp, prt, alignment=alignment)
        ota_in.add(compref)
    return ota_in.flatten() 

def super_class_AB_OTA(
        pdk: MappedPDK,
        input_pair_params: tuple[float,float]=(4,2),
        fvf_shunt_params: tuple[float,float]=(2.75,1),
        local_current_bias_params: tuple[float,float]=(3.76,3.0),
        diff_pair_load_params: tuple[float,float]=(9,1),
        ratio: int=1,
        current_mirror_params: tuple[float,float]=(2.25,1),
        resistor_params: tuple[tuple[float,float],tuple[float,float]]=((0.5,3),(4,4)),
        global_current_bias_params: tuple[tuple[float,float],float]=((8.3,1.42),2)
        ) -> Component:
    """
    creates a super class AB OTA using flipped voltage follower at biasing stage and local common mode feedback to give dynamic current and gain boost much less dependent on biasing current
    NB:- This block can only support device dimensions which achieve our design goal. In future steps will be taken to make it more flexible.
    pdk: pdk to use
    input_pair_params: differential input pair(N-type) - (width,length), input nmoses of the fvf get the same dimensions
    fvf_shunt_params: feedback fet of fvf - (width,length)
    local_current_bias_params: local currrent mirror which directly biases each fvf - (width,length)
    diff_pair_load_params: creates a p_block consisting of both input stage pmos loads and output stage pmoses - (width,length) 
    ratio: current mirroring ratio from input stage to output stage, currently suports only identical mirroring
    current_mirror_params: output stage N-type currrent mirrors - (width, length)
    resistor_params: passgates are used as resistors for LCMFB - ((width of nmos, width of pmos),(length of nmos, length of pmos))
    global_current_bias_params: A low voltage current mirror for biasing - consists of 5 nmoses of (W/L) and one nmos of (W'/L) - ((W,W'),L)
    """ 
    # Create a top level component
    top_level = Component("Super_class_AB_OTA")
    
    #input differential pair
    nb = n_block(pdk, input_pair_params=input_pair_params, fvf_shunt_params=fvf_shunt_params, current_mirror_params=current_mirror_params, global_current_bias_params=global_current_bias_params)
    n_block_ref = prec_ref_center(nb)
    top_level.add(n_block_ref)
    top_level.add_ports(n_block_ref.get_ports_list())

    #local current mirrors
    local_c_bias = current_mirror(pdk, numcols=2, device='pfet', width=local_current_bias_params[0]/2, length=local_current_bias_params[1], fingers=1)
    local_c_bias_2_ref = prec_ref_center(local_c_bias)
    local_c_bias_1_ref = prec_ref_center(local_c_bias)
    local_c_bias_1_ref.movex(n_block_ref.xmax + evaluate_bbox(local_c_bias)[0]/2 + 10).movey(n_block_ref.ymax+evaluate_bbox(local_c_bias)[1]/2 + 2)
    local_c_bias_2_ref.movex(n_block_ref.xmax + evaluate_bbox(local_c_bias)[0]/2 + 10).movey(n_block_ref.ymax+evaluate_bbox(local_c_bias)[1]/2 + 2)
    local_c_bias_1_ref = rename_ports_by_orientation(local_c_bias_1_ref.mirror((0,100),(0,-100)))

    top_level.add(local_c_bias_1_ref)
    top_level.add(local_c_bias_2_ref)
    
    #adding lvt layer
    
    
    
    #biasing fvfs
    top_level << c_route(pdk, n_block_ref.ports["fvf_1_B_gate_bottom_met_E"], local_c_bias_1_ref.ports["fet_B_drain_E"], extension=5,width1=0.29, width2=0.29, cwidth=0.29, cglayer="met3")
    top_level << c_route(pdk, n_block_ref.ports["fvf_2_B_gate_bottom_met_E"], local_c_bias_2_ref.ports["fet_B_drain_E"], extension=5,width1=0.29, width2=0.29, cwidth=0.29, cglayer="met3")
    
    top_level << straight_route(pdk, local_c_bias_1_ref.ports["fet_A_source_W"], local_c_bias_1_ref.ports["welltie_W_top_met_W"],glayer1='met1', width=0.22)
    top_level << straight_route(pdk, local_c_bias_1_ref.ports["fet_A_0_dummy_L_gsdcon_top_met_W"], local_c_bias_1_ref.ports["welltie_W_top_met_W"],glayer1="met1")
    top_level << straight_route(pdk, local_c_bias_1_ref.ports["fet_B_1_dummy_R_gsdcon_top_met_E"], local_c_bias_1_ref.ports["welltie_E_top_met_E"],glayer1="met1") 

    top_level << straight_route(pdk, local_c_bias_2_ref.ports["fet_A_source_W"], local_c_bias_2_ref.ports["welltie_W_top_met_W"], glayer1='met1', width=0.22)
    top_level << straight_route(pdk, local_c_bias_2_ref.ports["fet_A_0_dummy_L_gsdcon_top_met_W"], local_c_bias_2_ref.ports["welltie_W_top_met_W"],glayer1="met1", width=0.2)
    top_level << straight_route(pdk, local_c_bias_2_ref.ports["fet_B_1_dummy_R_gsdcon_top_met_E"], local_c_bias_2_ref.ports["welltie_E_top_met_E"],glayer1="met1", width=0.2) 
    
    top_level << c_route(pdk, local_c_bias_1_ref.ports["fet_A_drain_E"], n_block_ref.ports["cbias_M_3_A_multiplier_0_drain_W"], viaoffset=False)
    top_level << c_route(pdk, local_c_bias_2_ref.ports["fet_A_drain_E"], n_block_ref.ports["cbias_M_4_A_multiplier_0_drain_E"], viaoffset=False)


    top_level.add_ports(local_c_bias_1_ref.get_ports_list(), prefix="cmirr_1_")
    top_level.add_ports(local_c_bias_2_ref.get_ports_list(), prefix="cmirr_2_")

    #LCMFB resistors
    resistor = transmission_gate(pdk, width=resistor_params[0], length=resistor_params[1], sd_rmult=3)
    res_1_ref = prec_ref_center(resistor)
    res_2_ref = prec_ref_center(resistor)
    res_1_ref.movey(n_block_ref.ymax + evaluate_bbox(resistor)[1]/2 + 1).movex(-evaluate_bbox(resistor)[0]/2 - 5)
    res_2_ref.movey(n_block_ref.ymax + evaluate_bbox(resistor)[1]/2 + 1).movex(-evaluate_bbox(resistor)[0]/2 - 5)
    res_2_ref = rename_ports_by_orientation(res_2_ref.mirror((0,-100),(0,100)))
    
    top_level.add(res_1_ref)
    top_level.add(res_2_ref)
    
    top_level << c_route(pdk, n_block_ref.ports["Min_1_multiplier_0_drain_E"], res_1_ref.ports["N_multiplier_0_source_E"], cwidth=0.6)
    top_level << c_route(pdk, n_block_ref.ports["Min_2_multiplier_0_drain_W"], res_2_ref.ports["N_multiplier_0_source_E"], cwidth=0.6)
    
    
    top_level.add_ports(res_1_ref.get_ports_list(), prefix="res_1_")
    top_level.add_ports(res_2_ref.get_ports_list(), prefix="res_2_")

    
    #output stage N-type current mirrors
    
    
    #adding the p_block
    pblock = p_block(pdk, width=diff_pair_load_params[0]/2, length=diff_pair_load_params[1], fingers=1, ratio=ratio)
    p_block_ref = prec_ref_center(pblock)
    p_block_ref.movey(res_1_ref.ymax + evaluate_bbox(pblock)[1]/2 + 8)
    top_level.add(p_block_ref)
    
    top_level << c_route(pdk, res_1_ref.ports["P_multiplier_0_drain_E"], p_block_ref.ports["bottom_A_0_gate_E"], e1glayer='met2', width2=0.29*2)
    top_level << c_route(pdk, res_2_ref.ports["P_multiplier_0_drain_E"], p_block_ref.ports["bottom_B_1_gate_W"], e1glayer='met2', width2=0.29*2)

    top_level << c_route(pdk, p_block_ref.ports["top_A_0_drain_W"], n_block_ref.ports["op_cmirr_fet_A_drain_W"], extension=-local_c_bias_1_ref.xmax-8-2*diff_pair_load_params[1] , cwidth=3, viaoffset=(True,True))
    top_level << c_route(pdk, p_block_ref.ports["top_B_1_drain_E"], n_block_ref.ports["op_cmirr_fet_B_drain_E"], extension=local_c_bias_2_ref.xmin-8-2*diff_pair_load_params[1] , cwidth=3, viaoffset=(True,True))

    top_level << c_route(pdk, p_block_ref.ports["bottom_A_0_drain_W"], res_1_ref.ports["P_multiplier_0_source_W"], cwidth=0.9, width2=0.29*3)
    top_level << c_route(pdk, p_block_ref.ports["bottom_B_1_drain_E"], res_2_ref.ports["P_multiplier_0_source_W"], cwidth=0.9, width2=0.29*3)
        
    top_level.add_ports(p_block_ref.get_ports_list(), prefix="pblock_")
    #adding lvt layer
    lvt_layer=(125,44)
    dimensions = (evaluate_bbox(top_level)[0], (p_block_ref.ymax - res_1_ref.ymin))

    lvt_rectangle = rectangle(layer=lvt_layer, size=(dimensions[0], dimensions[1]))
    lvt_rectangle_ref = prec_ref_center(lvt_rectangle)
    lvt_rectangle_ref.movey(n_block_ref.ymax + dimensions[1]/2)
    top_level.add(lvt_rectangle_ref)
    """
    #adding a pwell    
    pwell_rectangle = rectangle(layer=(pdk.get_glayer("pwell")), size=(85,30.25))
    pwell_rectangle_ref = prec_ref_center(pwell_rectangle,(0,-8.825))
    top_level.add(pwell_rectangle_ref)
    """
    #adding output pin
    viam2m3 = via_stack(pdk, "met2", "met3", centered=True, fulltop=True)
    viam3m4 = via_stack(pdk, "met3", "met4", centered=True, fulltop=True)
    op_int_via = top_level << viam2m3
    op_via = prec_ref_center(viam3m4)
    op_via.movex(min(n_block_ref.xmin,local_c_bias_1_ref.xmax)-8).movey(n_block_ref.ymin)
    top_level.add(op_via)
    op_int_via.move(n_block_ref.ports["op_cmirr_fet_B_drain_W"].center).movex(-1.5)
    top_level << straight_route(pdk, op_int_via.ports["bottom_met_E"], n_block_ref.ports["op_cmirr_fet_B_drain_W"], glayer1='met2', width=0.58)
    top_level << c_route(pdk, op_int_via.ports["top_met_N"], op_via.ports["bottom_met_N"], e1glayer='met3', e2glayer='met3', cglayer='met4', width1=0.6, width2=2, cwidth=2, extension=1.5, fullbottom=True)
    top_level.add_ports(op_via.get_ports_list(), prefix="DIFFOUT_")


    #adding IBIAS pins 
    IBIAS1_via = prec_ref_center(viam3m4)
    IBIAS1_via.move(n_block_ref.ports["cbias_M_2_A_drain_bottom_met_W"].center).movex(-4).movey(-evaluate_bbox(nb)[1]/2)
    top_level.add(IBIAS1_via)
    top_level << L_route(pdk, n_block_ref.ports["cbias_M_1_A_drain_bottom_met_W"], IBIAS1_via.ports["bottom_met_N"], hwidth=2, vwidth=0.8)
    top_level.add_ports(IBIAS1_via.get_ports_list(), prefix="IBIAS1_")
    

    IBIAS2_via = prec_ref_center(viam3m4)
    IBIAS2_via.movex(n_block_ref.xmax+5).movey(n_block_ref.ymin)
    top_level.add(IBIAS2_via)
    top_level << c_route(pdk, n_block_ref.ports["cbias_M_2_A_drain_top_met_N"], IBIAS2_via.ports["bottom_met_N"], e1glayer='met3', e2glayer='met3', cglayer='met4', width1=0.4, width2=1, cwidth=0.6, extension=1.5, fullbottom=True)
    top_level.add_ports(IBIAS2_via.get_ports_list(), prefix="IBIAS2_")

    #adding differential input pins
    MINUS_via = top_level << viam3m4
    MINUS_via.move(n_block_ref.ports["gate_inA_top_met_W"].center).movex(local_c_bias_1_ref.xmin+3*input_pair_params[1])
    top_level << straight_route(pdk, n_block_ref.ports["gate_inA_top_met_W"], MINUS_via.ports["top_met_E"], width=0.6, glayer1='met4')
    top_level.add_ports(MINUS_via.get_ports_list(), prefix="MINUS_")
    
    PLUS_via = top_level << viam3m4
    PLUS_via.move(n_block_ref.ports["gate_inB_top_met_E"].center).movex(local_c_bias_2_ref.xmax-3*input_pair_params[1])
    top_level << straight_route(pdk, n_block_ref.ports["gate_inB_top_met_E"], PLUS_via.ports["top_met_W"], width=0.6, glayer1='met4')
    top_level.add_ports(PLUS_via.get_ports_list(), prefix="PLUS_")
    
    #adding VCC pin
    arrm2m3_1 = via_array(
        pdk,
        "met2",
        "met3",
        size=(6,0.6),
        fullbottom=True
    )
    VCC_via = prec_ref_center(arrm2m3_1)
    VCC_via.movey(p_block_ref.ymax+5)
    top_level.add(VCC_via)
    top_level << straight_route(pdk, p_block_ref.ports["top_welltie_N_top_met_N"], VCC_via.ports["bottom_lay_S"], glayer1='met2', width=6, fullbottom=True)
    top_level.add_ports(VCC_via.get_ports_list(), prefix="VCC_")
    
    arrm2m3_2 = via_array(
        pdk,
        "met2",
        "met3",
        num_vias=(2,2),
        fullbottom=True
    )
    VCC_int_via = prec_ref_center(arrm2m3_2)
    VCC_int_via.movey(p_block_ref.ymin-4)
    top_level.add(VCC_int_via)
    top_level << straight_route(pdk, p_block_ref.ports["bottom_welltie_S_top_met_S"], VCC_int_via.ports["top_met_N"], glayer1='met3', width=0.5)
    top_level << L_route(pdk, VCC_int_via.ports["bottom_lay_W"], res_1_ref.ports["P_tie_S_top_met_S"], hglayer='met2', vglayer='met2', hwidth=2, vwidth=2, fullbottom=True)
    top_level << L_route(pdk, VCC_int_via.ports["bottom_lay_E"], res_2_ref.ports["P_tie_S_top_met_S"], hglayer='met2', vglayer='met2', hwidth=2, vwidth=2, fullbottom=True)
    top_level << L_route(pdk, VCC_int_via.ports["bottom_lay_W"], local_c_bias_1_ref.ports["welltie_N_top_met_N"], hglayer='met2', vglayer='met2', hwidth=2, vwidth=2, fullbottom=True)
    top_level << L_route(pdk, VCC_int_via.ports["bottom_lay_E"], local_c_bias_2_ref.ports["welltie_N_top_met_N"], hglayer='met2', vglayer='met2', hwidth=2, vwidth=2, fullbottom=True)  
    top_level << L_route(pdk, res_1_ref.ports["N_multiplier_0_gate_E"], VCC_int_via.ports["top_met_S"], hglayer='met2', vglayer='met3', hwidth=0.5, vwidth=0.3, fullbottom=True)
    top_level << L_route(pdk, res_2_ref.ports["N_multiplier_0_gate_W"], VCC_int_via.ports["top_met_S"], hglayer='met2', vglayer='met3', hwidth=0.5, vwidth=0.3, fullbottom=True)

    #adding GND pin
    top_level << L_route(pdk, res_1_ref.ports["N_tie_W_top_met_W"], n_block_ref.ports["fvf_1_B_tie_N_top_met_N"], hglayer='met1', vglayer='met2', vwidth=4, hwidth=0.8, fullbottom=True)
    top_level << L_route(pdk, res_2_ref.ports["N_tie_W_top_met_W"], n_block_ref.ports["fvf_2_B_tie_N_top_met_N"], hglayer='met1', vglayer='met2', vwidth=4, hwidth=0.8, fullbottom=True)
    top_level << L_route(pdk, res_1_ref.ports["P_multiplier_0_gate_W"], n_block_ref.ports["fvf_1_B_tie_N_top_met_N"], hglayer='met2', vglayer='met2', vwidth=0.3, hwidth=1.2, fullbottom=True)
    top_level << L_route(pdk, res_2_ref.ports["P_multiplier_0_gate_E"], n_block_ref.ports["fvf_2_B_tie_N_top_met_N"], hglayer='met2', vglayer='met2', vwidth=0.3, hwidth=1.2, fullbottom=True)
    
    top_level << L_route(pdk, n_block_ref.ports["op_cmirr_welltie_N_top_met_N"], n_block_ref.ports["Min_1_tie_E_top_met_E"], hwidth=0.6, vwidth=1, hglayer='met1')
    top_level << L_route(pdk, n_block_ref.ports["op_cmirr_welltie_N_top_met_N"], n_block_ref.ports["Min_2_tie_W_top_met_W"], hwidth=0.6, vwidth=1, hglayer='met1')
    
    GND_via = top_level << arrm2m3_2
    GND_via.move(n_block_ref.ports["op_cmirr_welltie_S_top_met_S"].center).movey(-2).movex(local_c_bias_2_ref.xmax)
    top_level << L_route(pdk, n_block_ref.ports["op_cmirr_welltie_S_top_met_S"], GND_via.ports["bottom_lay_W"], vglayer='met2', hglayer='met2', vwidth=1.5, hwidth=1.5)
    top_level.add_ports(GND_via.get_ports_list(), prefix="VSS_")

    component = component_snap_to_grid(rename_ports_by_orientation(top_level))
    
    return component

OTA = sky130_add_ota_labels(super_class_AB_OTA(sky130_mapped_pdk))
OTA.show()
OTA.name = "ota"
OTA.write_gds("./ota.gds")
magic_drc_result = sky130_mapped_pdk.drc_magic(OTA, OTA.name)
#netgen_lvs_result = sky130_mapped_pdk.lvs_netgen(OTA, design_name="ota", netlist="ota.spice")
