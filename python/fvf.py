from glayout.flow.pdk.mappedpdk import MappedPDK
from gdsfactory.component import Component
from gdsfactory import Component
from glayout.flow.primitives.fet import nmos, pmos, multiplier
from pmos_lvt import pmos_lvt
from glayout.flow.pdk.util.comp_utils import evaluate_bbox, prec_center
from glayout.flow.pdk.util.snap_to_grid import component_snap_to_grid
from glayout.flow.pdk.util.port_utils import rename_ports_by_orientation
from glayout.flow.routing.straight_route import straight_route
from glayout.flow.routing.c_route import c_route
from glayout.flow.routing.L_route import L_route
from glayout.flow.primitives.guardring import tapring
from glayout.flow.pdk.util.port_utils import add_ports_perimeter
from glayout.flow.spice.netlist import Netlist
from glayout.flow.primitives.via_gen import via_stack

def fvf_netlist(fet_1: Component, fet_2: Component) -> Netlist:

         netlist = Netlist(circuit_name='FLIPPED_VOLTAGE_FOLLOWER', nodes=['VIN', 'AC_GND', 'VOUT', 'Ib'])
         netlist.connect_netlist(fet_1.info['netlist'], [('D', 'Ib'), ('G', 'VIN'), ('S', 'VOUT'), ('B', 'VOUT')])
         netlist.connect_netlist(fet_2.info['netlist'], [('D', 'VOUT'), ('G', 'Ib'), ('S', 'AC_GND'), ('B', 'AC_GND')])

         return netlist

def  flipped_voltage_follower(
        pdk: MappedPDK,
        device_type: str = "nmos",
        width: tuple[float,float,float] = (3,3),
        length: tuple[float,float,float] = (None,None),
        fingers: tuple[int,int,int] = (1,1),
        multipliers: tuple[int,int,int] = (1,1),
        dummy_1: tuple[bool,bool] = (True,True),
        dummy_2: tuple[bool,bool] = (True,True),
        substrate_tap: bool = False,
        tie_layers: tuple[str,str] = ("met2","met1"),
        ) -> Component:
   
    #top level component
    top_level = Component("flipped voltage follower")

    #two fets
    if device_type == "nmos":
        fet_1 = nmos(pdk, width=width[0], fingers=fingers[0], multipliers=multipliers[0], with_dummy=dummy_1, with_dnwell=False,  with_substrate_tap=False, length=length[0])
        fet_2 = nmos(pdk, width=width[1], fingers=fingers[1], multipliers=multipliers[1], with_dummy=dummy_2, with_dnwell=False,  with_substrate_tap=False, length=length[1])
        well = "pwell"
    elif device_type == "pmos":
        fet_1 = pmos(pdk, width=width[0], fingers=fingers[0], multipliers=multipliers[0], with_dummy=dummy_1, with_substrate_tap=False, length=length[0])
        fet_2 = pmos(pdk, width=width[1], fingers=fingers[1], multipliers=multipliers[1], with_dummy=dummy_2, with_substrate_tap=False, length=length[1])
        well = "nwell"
    fet_1_ref = top_level << fet_1
    fet_2_ref = top_level << fet_2 

    #Relative move
    ref_dimensions = evaluate_bbox(fet_1)
    fet_2_ref.movex(ref_dimensions[0] + pdk.util_max_metal_seperation())
    
    #Routing
    viam2m3 = via_stack(pdk, "met1", "met2", centered=True)
    gate_2_via = top_level << viam2m3
    gate_2_via.move(fet_2_ref.ports["multiplier_0_gate_S"].center).movey(-2)

    top_level << c_route(pdk, fet_1_ref.ports["multiplier_0_source_N"], fet_2_ref.ports["multiplier_0_drain_N"], extension=1.2, width1=0.32, width2=0.32, cwidth=0.32, e1glayer="met3", e2glayer="met3", cglayer="met2")
    top_level << straight_route(pdk, fet_2_ref.ports["multiplier_0_gate_S"], gate_2_via.ports["bottom_met_N"], glayer1="met1")
    top_level << c_route(pdk, gate_2_via.ports["top_met_W"], fet_1_ref.ports["multiplier_0_drain_W"])
    top_level << straight_route(pdk, fet_1_ref.ports["multiplier_0_source_W"], fet_1_ref.ports["tie_W_top_met_W"], glayer2=tie_layers[0])
    top_level << straight_route(pdk, fet_2_ref.ports["multiplier_0_source_W"], fet_2_ref.ports["tie_W_top_met_W"], glayer2=tie_layers[0])
    
    #Renaming Ports
    top_level.add_ports(fet_1_ref.get_ports_list(), prefix="A_")
    top_level.add_ports(fet_2_ref.get_ports_list(), prefix="B_")
    top_level.add_ports(gate_2_via.get_ports_list(), prefix="B_gate_")

    #add dnwell
    top_level.add_padding(layers=(pdk.get_glayer("dnwell"),),default=pdk.get_grule("pwell", "dnwell")["min_enclosure"]+1, )
    
    #substrate tap
    if substrate_tap:
            if well == "pwell":
                tapref = top_level << tapring(pdk,evaluate_bbox(top_level,padding=1),sdlayer="n+s/d", horizontal_glayer="met1")
            else:
                tapref = top_level << tapring(pdk,evaluate_bbox(top_level,padding=1),sdlayer="p+s/d", horizontal_glayer="met1")
            tapref.movex(ref_dimensions[0]/2)
            top_level.add_ports(tapref.get_ports_list(),prefix="tap_")
            try:
                top_level<<straight_route(pdk,fet_1_ref.ports["multiplier_0_dummy_A_gsdcon_top_met_W"],top_level.ports["tap_W_top_met_W"],glayer2="met1")
            except KeyError:
                pass
            try:     
                top_level<<straight_route(pdk,fet_2_ref.ports["multiplier_0_dummy_B_gsdcon_top_met_W"],top_level.ports["tap_E_top_met_E"],glayer2="met1")
            except KeyError:
                pass
    
    
    component = component_snap_to_grid(rename_ports_by_orientation(top_level))

    component.info['netlist'] = fvf_netlist(fet_1, fet_2)

    #print(component.info['netlist'].generate_netlist(only_subcircuits=True))

    return component
