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
from glayout.flow.primitives.guardring import tapring
from glayout.flow.pdk.util.port_utils import add_ports_perimeter
from glayout.flow.spice.netlist import Netlist
from glayout.flow.primitives.via_gen import via_stack


def input_pair_netlist(
        pdk: MappedPDK,
        width: float,
        length: float,
        fingers: int,
        multipliers: int
        ) -> Netlist:

         netlist = Netlist(circuit_name='Differential_Input_Pair', nodes=['A_D', 'A_S', 'Vin+', 'A_Bulk','B_D', 'B_S', 'Vin-', 'B_Bulk'])
         fet_A = nmos(pdk, width=width, fingers=fingers, multipliers=2*multipliers, with_dummy=(False,False), with_dnwell=False, with_tie=True, with_substrate_tap=False, length=length)
         fet_B = nmos(pdk, width=width, fingers=fingers, multipliers=2*multipliers, with_dummy=(False,True), with_dnwell=False, with_tie=True, with_substrate_tap=False, length=length)
         netlist.connect_netlist(fet_B.info['netlist'], [('D', 'B_D'), ('G', 'Vin-'), ('S', 'B_S'), ('B', 'B_Bulk')]) 
         netlist.connect_netlist(fet_A.info['netlist'], [('D', 'A_D'), ('G', 'Vin+'), ('S', 'A_S'), ('B', 'A_Bulk')]) 

         return netlist                  


def input_pair_baab( 
        pdk: MappedPDK,
        width: float=3,
        length:float=None,
        fingers: int=1,
        multipliers: int=1,
        with_substrate_tap: bool=True,
        tie_layers: tuple[str,str]=('met2','met1')  
        ) -> Component:
    
    top_level = Component("Differential_Input_Pair")
    
    fet_A = nmos(pdk, width=width, fingers=fingers, multipliers=multipliers, with_dummy=(False,False), with_dnwell=False, with_tie=True, with_substrate_tap=False, length=length)
    fet_B = nmos(pdk, width=width, fingers=fingers, multipliers=multipliers, with_dummy=(False,True), with_dnwell=False, with_tie=True, with_substrate_tap=False, length=length)
       
    fet_A_1 = top_level << fet_A
    fet_A_2 = top_level << fet_A
    fet_A_2 = rename_ports_by_orientation(fet_A_2.mirror_x())
    fet_B_1 = top_level << fet_B
    fet_B_2 = top_level << fet_B
    fet_B_1 = rename_ports_by_orientation(fet_B_1.mirror_x())

    ref_dimensions_1 = evaluate_bbox(fet_A_1)
    ref_dimensions_2 = evaluate_bbox(fet_B_2)
    fet_A_2.movex(ref_dimensions_1[0])
    fet_B_2.movex(ref_dimensions_2[0] + ref_dimensions_1[0]/2 + 2 * pdk.util_max_metal_seperation())
    fet_B_1.movex(-ref_dimensions_2[0] + ref_dimensions_1[0]/2 - 2 * pdk.util_max_metal_seperation())

    viam2m3 = via_stack(pdk,"met2","met3",centered=True)
    
    source_B1_via = top_level << viam2m3
    source_B2_via = top_level << viam2m3
    source_B1_via.move(fet_B_1.ports["multiplier_0_source_W"].center).movex(-3)
    source_B2_via.move(fet_B_2.ports["multiplier_0_source_E"].center).movex(2)
    
    drain_B1_via = top_level << viam2m3
    drain_B2_via = top_level << viam2m3
    drain_B1_via.move(fet_B_1.ports["multiplier_0_drain_W"].center).movex(-2)
    drain_B2_via.move(fet_B_2.ports["multiplier_0_drain_E"].center).movex(1)

    top_level << straight_route(pdk, fet_B_1.ports["multiplier_0_source_W"], source_B1_via.ports["bottom_met_E"])
    top_level << straight_route(pdk, fet_B_2.ports["multiplier_0_source_E"], source_B2_via.ports["bottom_met_W"])
    top_level << c_route(pdk, source_B1_via.ports["top_met_N"], source_B2_via.ports["top_met_N"], extension=1.6, cglayer='met2')

    top_level << straight_route(pdk, fet_B_1.ports["multiplier_0_drain_W"], drain_B1_via.ports["bottom_met_E"])
    top_level << straight_route(pdk, fet_B_2.ports["multiplier_0_drain_E"], drain_B2_via.ports["bottom_met_W"])
    top_level << c_route(pdk, drain_B1_via.ports["top_met_N"], drain_B2_via.ports["top_met_N"], extension=2.6, cglayer='met2')

    top_level << c_route(pdk, fet_B_1.ports["multiplier_0_gate_S"], fet_B_2.ports["multiplier_0_gate_S"], extension=1.5, e1glayer='met1', e2glayer='met1', cglayer='met2')

    top_level << straight_route(pdk, fet_A_1.ports["multiplier_0_source_E"], fet_A_2.ports["multiplier_0_source_W"])
    top_level << straight_route(pdk, fet_A_1.ports["multiplier_0_drain_E"], fet_A_2.ports["multiplier_0_drain_W"])
    top_level << c_route(pdk, fet_A_1.ports["multiplier_0_gate_S"], fet_A_2.ports["multiplier_0_gate_S"], e1glayer='met1', e2glayer='met1', cglayer='met2')

    top_level << straight_route(pdk, fet_A_1.ports["multiplier_0_source_W"], fet_A_1.ports["tie_W_top_met_W"], glayer2=tie_layers[0])
    top_level << straight_route(pdk, fet_A_2.ports["multiplier_0_source_W"], fet_A_2.ports["tie_W_top_met_W"], glayer2=tie_layers[0])
    top_level << straight_route(pdk, fet_B_1.ports["multiplier_0_source_W"], fet_B_1.ports["tie_W_top_met_W"], glayer2=tie_layers[0])
    top_level << straight_route(pdk, fet_B_2.ports["multiplier_0_source_W"], fet_B_2.ports["tie_W_top_met_W"], glayer2=tie_layers[0])
    
    top_level.add_ports(fet_A_1.get_ports_list(), prefix='A_1_')
    top_level.add_ports(fet_A_2.get_ports_list(),prefix="A_2_")
    top_level.add_ports(fet_B_1.get_ports_list(),prefix="B_1_")
    top_level.add_ports(fet_B_2.get_ports_list(),prefix="B_2_")
    top_level.add_ports(source_B1_via.get_ports_list(), prefix="source_B_1_")
    top_level.add_ports(source_B2_via.get_ports_list(), prefix="source_B_2_")
    top_level.add_ports(drain_B1_via.get_ports_list(), prefix="drain_B_1_")
    top_level.add_ports(drain_B2_via.get_ports_list(), prefix="drain_B_2_")
    


    if with_substrate_tap:
      substrate_tap_separation = pdk.get_grule("dnwell", "active_tap")["min_separation"]
      substrate_tap_encloses =(2 * (substrate_tap_separation + top_level.xmax), 2 * (substrate_tap_separation + top_level.ymax))
      guardring_ref = top_level << tapring(
            pdk,
            enclosed_rectangle=substrate_tap_encloses,
            sdlayer="n+s/d",
            horizontal_glayer='met2',
            vertical_glayer='met1',
        )
      guardring_ref.movex(ref_dimensions_1[0]/2)
    
    top_level.add_padding(
            layers=(pdk.get_glayer("pwell"),),
            default=pdk.get_grule("active_tap", "pwell")["min_enclosure"],
            )


    component = component_snap_to_grid(rename_ports_by_orientation(top_level))

    component.info['netlist'] = input_pair_netlist(pdk, width, length, fingers, multipliers)

    print(component.info['netlist'].generate_netlist(only_subcircuits=True))

    return component
