from glayout.flow.pdk.mappedpdk import MappedPDK
from gdsfactory.component import Component
from glayout.flow.primitives.fet import nmos, pmos, multiplier
from glayout.flow.pdk.util.comp_utils import evaluate_bbox, prec_center
from glayout.flow.routing.L_route import L_route
from glayout.flow.routing.c_route import c_route
from glayout.flow.primitives.guardring import tapring


def  flipped_voltage_follower(
        pdk: MappedPDK,
        device_type: str = "nmos",
        wid: tuple[float,float] = (3,3),
        len: tuple[float,float] = (None,None),
        finger: tuple[int,int] = (1,1),
        multiplier: tuple[int,int] = (1,1),
        dummy_1: tuple[bool,bool] = (True,False),
        dummy_2: tuple[bool,bool] = (False,True),
        substrate_tap: bool = False,
        with_tie: bool = True,
        tie_layers: tuple[str,str] = ("met2","met1"),
        ):
         """
         Args:
              pdk: PDK to use
              device_type: either "nmos"(default) or "pmos"
              wid: width of the input mos([0]) and feedback mos([1])
              len: length of the input mos([0]) and feedback mos([1]), default to minimum length
              finger: no. of fingers for input mos([0]) and feedback mos([1])
              multiplier: no. of multipliers for input mos([0]) and feedback mos([1])
              dummy_1: dummy structure for input mos
              dummy_2: dummy structure for feedback mos
         """
    #top level component
    top_level = Component()

    #two fets
    if device_type == "nmos":
        fet_1 = nmos(pdk, width=wid[0], fingers=finger[0], multipliers=multiplier[0], with_dummy=dummy_1, with_substrate_tap=substrate_tap, length=len[0])
        fet_2 = nmos(pdk, width=wid[1], fingers=finger[1], multipliers=multiplier[1], with_dummy=dummy_2, with_substrate_tap=substrate_tap, length=len[1])
    elif device_type == "pmos":
        fet_1 = pmos(pdk, width=wid[0], fingers=finger[0], multipliers=multiplier[0], with_dummy=dummy_1, with_substrate_tap=substrate_tap, length=len[0])
        fet_2 = pmos(pdk, width=wid[1], fingers=finger[1], multipliers=multiplier[1], with_dummy=dummy_2, with_substrate_tap=substrate_tap, length=len[1])
    fet_1_ref = top_level << fet_1
    fet_2_ref = top_level << fet_2

    #Relative move
    ref_dimensions = evaluate_bbox(fet_1)
    fet_2_ref.movex(ref_dimensions[0] + pdk.util_max_metal_seperation())
    
    #Routing
    top_level << L_route(pdk, fet_1_ref.ports["multiplier_0_source_E"], fet_2_ref.ports["multiplier_0_drain_N"])
    top_level << c_route(pdk, fet_2_ref.ports["multiplier_0_gate_E"], fet_1_ref.ports["multiplier_0_drain_E"])

    #Renaming Ports
    top_level.add_ports(fet_1_ref.get_ports_list(), prefix="A_")
    top_level.add_ports(fet_2_ref.get_ports_list(), prefix="B_")

    #tie
    if with_tie:
        tap_separation = max(
            pdk.util_max_metal_seperation(),
            pdk.get_grule("active_diff", "active_tap")["min_separation"],
        )
        tap_separation += pdk.get_grule("n+s/d", "active_tap")["min_enclosure"]
        tap_encloses = (
            1.4 * (tap_separation + top_level.xmax),
            2 * (tap_separation + top_level.ymax),
        )
        shift_amount = prec_center(top_level.flatten())[0]
        tiering_ref = top_level << tapring(
            pdk,
            enclosed_rectangle=tap_encloses,
            sdlayer="n+s/d",
            horizontal_glayer=tie_layers[0],
            vertical_glayer=tie_layers[1],
        )
        tiering_ref.movex(-shift_amount)
        top_level.add_ports(tiering_ref.get_ports_list(), prefix="welltie_")
     
    #substrate tap
    if substrate_tap:
        substrate_tap_separation = pdk.get_grule("dnwell", "active_tap")[
            "min_separation"
        ]
        substrate_tap_encloses = (
            1.4 * (substrate_tap_separation + top_level.xmax),
            2 * (substrate_tap_separation + top_level.ymax),
        )
        ringtoadd = tapring(
            pdk,
            enclosed_rectangle=substrate_tap_encloses,
            sdlayer="p+s/d",
            horizontal_glayer="met2",
            vertical_glayer="met1",
        )
        shift_amount = prec_center(top_level.flatten())[0]
        tapring_ref = top_level << ringtoadd
        tapring_ref.movex(-shift_amount)
        top_level.add_ports(tapring_ref.get_ports_list(),prefix="substratetap_")
      
    return top_level
