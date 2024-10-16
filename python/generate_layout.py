import fvf
from glayout.flow.pdk.sky130_mapped import sky130_mapped_pdk

fvf.flipped_voltage_follower(sky130_mapped_pdk).write_gds("gds/fvf-chipathon-2024.gds")