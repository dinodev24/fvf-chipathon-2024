import n_fvf_cell
from glayout.flow.pdk.sky130_mapped import sky130_mapped_pdk

n_fvf_cell.n_fvf_cell(sky130_mapped_pdk).write_gds("gds/n_fvf_cell.gds")