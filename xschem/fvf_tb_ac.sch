v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -70 -20 -60 -20 {
lab=Vin}
N -70 20 -60 20 {
lab=Ib}
N 0 -60 0 -50 {
lab=VDD}
N -0 50 0 60 {
lab=GND}
N 60 -0 110 0 {
lab=Vout}
C {sky130_fd_pr/corner.sym} 110 -150 0 0 {name=CORNER only_toplevel=false corner=tt}
C {devices/vdd.sym} 0 -60 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} 0 60 0 0 {name=l2 lab=GND}
C {devices/vdd.sym} -340 -30 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} -340 160 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} -340 0 0 0 {name=Vin value=1.8 savecurrent=false}
C {devices/gnd.sym} -340 30 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} -340 100 1 0 {name=p1 sig_type=std_logic lab=Vin}
C {devices/lab_pin.sym} -70 -20 0 0 {name=p2 sig_type=std_logic lab=Vin}
C {devices/code_shown.sym} 0 120 0 0 {name=SPICE
only_toplevel=false
value=".ac dec 20 1 1e8
.save all"}
C {devices/isource.sym} -280 0 0 0 {name=I0 value=1u}
C {/foss/designs/fvf-chipathon-2024/xschem/fvf.sym} 0 0 0 0 {name=X1}
C {devices/vsource.sym} -340 130 0 0 {name=Vin1
value="1.8 AC 1"
savecurrent=false}
C {devices/gnd.sym} -280 30 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} -70 20 0 0 {name=p4 sig_type=std_logic lab=Ib}
C {devices/lab_pin.sym} -280 -30 1 0 {name=p5 sig_type=std_logic lab=Ib}
C {devices/lab_pin.sym} 110 0 0 1 {name=p3 sig_type=std_logic lab=Vout}
