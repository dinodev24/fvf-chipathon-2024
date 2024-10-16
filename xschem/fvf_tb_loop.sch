v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 170 80 180 80 {
lab=VIN}
N 130 110 130 150 {
lab=#net1}
N 170 180 180 180 {
lab=#net2}
N 180 180 180 200 {
lab=#net2}
N 130 210 130 260 {
lab=GND}
N 180 180 240 180 {
lab=#net2}
N 300 180 320 180 {
lab=VOUT}
N 320 180 320 200 {
lab=VOUT}
N 320 40 320 180 {
lab=VOUT}
N 120 80 130 80 {
lab=#net1}
N 120 80 120 130 {
lab=#net1}
N 120 130 130 130 {
lab=#net1}
N 130 40 320 40 {
lab=VOUT}
N 130 30 130 40 {
lab=VOUT}
N 130 40 130 50 {
lab=VOUT}
N 10 0 90 0 {
lab=IBIAS}
N -30 -40 130 -40 {
lab=VCC}
N 130 -40 130 -30 {
lab=VCC}
N 50 0 50 30 {
lab=IBIAS}
N -30 30 50 30 {
lab=IBIAS}
N -40 0 -30 0 {
lab=VCC}
N -40 -40 -40 0 {
lab=VCC}
N -40 -40 -30 -40 {
lab=VCC}
N -30 -40 -30 -30 {
lab=VCC}
N 130 -40 140 -40 {
lab=VCC}
N 140 -40 140 0 {
lab=VCC}
N 130 0 140 0 {
lab=VCC}
C {sky130_fd_pr/corner.sym} 620 -160 0 0 {name=CORNER only_toplevel=false corner=tt}
C {devices/vdd.sym} -370 -30 0 0 {name=l3 lab=VCC}
C {devices/gnd.sym} -250 30 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} -370 0 0 0 {name=Vin value=1.8 savecurrent=false}
C {devices/gnd.sym} -370 30 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} -250 -30 1 0 {name=p1 sig_type=std_logic lab=VIN
}
C {devices/code_shown.sym} 310 -160 0 0 {name=SPICE
only_toplevel=false
value=".control
    ac dec 20 1 1e12
    save all

    set wr_vecnames
    wrdata loop_vout.txt v(vout)
.endc"}
C {devices/vsource.sym} -250 0 0 0 {name=Vin1
value="1.8"
savecurrent=false}
C {devices/isource.sym} -310 0 0 0 {name=I1 value=10u}
C {devices/gnd.sym} -310 30 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} -310 -30 1 0 {name=p6 sig_type=std_logic lab=IBIAS}
C {devices/ind.sym} 270 180 1 0 {name=L1
m=1
value=1T
footprint=1206
device=inductor}
C {devices/capa.sym} 180 230 0 0 {name=C1
m=1
value=1T
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 130 260 0 1 {name=l2 lab=GND}
C {devices/lab_pin.sym} 180 80 2 0 {name=p2 sig_type=std_logic lab=VIN}
C {devices/capa.sym} 320 230 0 0 {name=C2
m=1
value=6f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 320 260 0 1 {name=l9 lab=GND}
C {devices/vdd.sym} -30 -40 0 0 {name=l8 lab=VCC}
C {devices/lab_pin.sym} -30 30 3 0 {name=p4 sig_type=std_logic lab=IBIAS}
C {sky130_fd_pr/pfet_01v8_lvt.sym} -10 0 0 1 {name=M3
L=3
W=3.8
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 110 0 0 0 {name=M4
L=3
W=3.8
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {devices/lab_pin.sym} 320 40 2 0 {name=p3 sig_type=std_logic lab=VOUT}
C {devices/gnd.sym} 180 320 0 0 {name=l10 lab=GND}
C {devices/vsource.sym} 180 290 0 0 {name=Vin2
value="0.77 AC 1"
savecurrent=false}
C {sky130_fd_pr/nfet3_01v8.sym} 150 180 0 1 {name=M1
L=0.8	
W=1.29
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
C {sky130_fd_pr/nfet_01v8.sym} 150 80 0 1 {name=M2
L=0.3
W=0.59
body=VOUT
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
