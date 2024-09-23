v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 70 110 80 110 {
lab=VIN}
N 30 140 30 180 {
lab=#net1}
N 30 60 30 80 {
lab=Vout}
N 70 210 80 210 {
lab=#net2}
N 80 210 80 230 {
lab=#net2}
N 30 240 30 290 {
lab=GND}
N 80 210 140 210 {
lab=#net2}
N 200 210 220 210 {
lab=Vout}
N 220 210 220 230 {
lab=Vout}
N 30 70 220 70 {
lab=Vout}
N 220 70 220 210 {
lab=Vout}
N 20 110 30 110 {
lab=#net1}
N 20 110 20 160 {
lab=#net1}
N 20 160 30 160 {
lab=#net1}
C {sky130_fd_pr/corner.sym} 620 -160 0 0 {name=CORNER only_toplevel=false corner=tt}
C {devices/vdd.sym} -370 -30 0 0 {name=l3 lab=VCC}
C {devices/gnd.sym} -250 30 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} -370 0 0 0 {name=Vin value=1.8 savecurrent=false}
C {devices/gnd.sym} -370 30 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} -250 -30 1 0 {name=p1 sig_type=std_logic lab=VIN
}
C {devices/code_shown.sym} 310 -40 0 0 {name=SPICE
only_toplevel=false
value=".control
    ac dec 20 1 1e8
    save all

    set wr_vecnames
    wrdata loop_vout.txt v(vout)
    exit
.endc"}
C {devices/vsource.sym} -250 0 0 0 {name=Vin1
value="1.8 AC 1"
savecurrent=false}
C {devices/isource.sym} -310 0 0 0 {name=I1 value=2.5u}
C {devices/gnd.sym} -310 30 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} -310 -30 1 0 {name=p6 sig_type=std_logic lab=IBIAS}
C {devices/opin.sym} 220 70 3 0 {name=p3 lab=Vout}
C {sky130_fd_pr/nfet3_01v8.sym} 50 210 0 1 {name=M2
L=1
W=15
body=GND
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/ind.sym} 170 210 1 0 {name=L1
m=1
value=1T
footprint=1206
device=inductor}
C {devices/capa.sym} 80 260 0 0 {name=C1
m=1
value=1T
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 30 290 0 1 {name=l2 lab=GND}
C {devices/gnd.sym} 80 290 0 1 {name=l5 lab=GND}
C {devices/lab_pin.sym} 80 110 2 0 {name=p2 sig_type=std_logic lab=VIN}
C {devices/capa.sym} 220 260 0 0 {name=C2
m=1
value=71.72f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 220 290 0 1 {name=l9 lab=GND}
C {/foss/designs/fvf-chipathon-2024/xschem/cmirror.sym} 0 0 0 0 {}
C {devices/vdd.sym} 0 -60 0 0 {name=l8 lab=VCC}
C {devices/lab_pin.sym} -30 60 0 0 {name=p4 sig_type=std_logic lab=IBIAS}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 50 110 0 1 {name=M1
L=1
W=15
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
