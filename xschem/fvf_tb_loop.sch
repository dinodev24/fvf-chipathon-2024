v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 130 80 140 80 {
lab=Vin}
N -30 0 50 0 {
lab=Ib}
N -70 -50 -70 -30 {
lab=VDD}
N -70 -40 90 -40 {
lab=VDD}
N 90 -40 90 -30 {
lab=VDD}
N 90 110 90 150 {
lab=#net1}
N 90 30 90 50 {
lab=Vout}
N 130 180 140 180 {
lab=#net2}
N 140 180 140 200 {
lab=#net2}
N 90 210 90 260 {
lab=GND}
N 140 180 200 180 {
lab=#net2}
N 260 180 280 180 {
lab=Vout}
N 280 180 280 200 {
lab=Vout}
N 90 40 280 40 {
lab=Vout}
N 280 40 280 180 {
lab=Vout}
N -70 30 -70 60 {
lab=Ib}
N -70 40 -20 40 {
lab=Ib}
N -20 0 -20 40 {
lab=Ib}
C {sky130_fd_pr/corner.sym} 620 -160 0 0 {name=CORNER only_toplevel=false corner=tt}
C {devices/vdd.sym} -370 -30 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} -250 30 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} -370 0 0 0 {name=Vin value=1.8 savecurrent=false}
C {devices/gnd.sym} -370 30 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} -250 -30 1 0 {name=p1 sig_type=std_logic lab=Vin}
C {devices/code_shown.sym} 310 -40 0 0 {name=SPICE
only_toplevel=false
value=".ac dec 20 1 1e8
.save all"}
C {devices/vsource.sym} -250 0 0 0 {name=Vin1
value="1.8 AC 1"
savecurrent=false}
C {devices/isource.sym} -310 0 0 0 {name=I1 value=1u}
C {devices/gnd.sym} -310 30 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} -310 -30 1 0 {name=p6 sig_type=std_logic lab=Ib}
C {devices/opin.sym} 90 40 2 0 {name=p3 lab=Vout}
C {sky130_fd_pr/nfet3_01v8.sym} 110 80 0 1 {name=M1
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
C {sky130_fd_pr/nfet3_01v8.sym} 110 180 0 1 {name=M2
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
C {sky130_fd_pr/pfet3_01v8_lvt.sym} -50 0 0 1 {name=M3
L=1
W=2
body=VDD
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
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 70 0 0 0 {name=M4
L=1
W=2
body=VDD
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
C {devices/ind.sym} 230 180 1 0 {name=L1
m=1
value=1T
footprint=1206
device=inductor}
C {devices/capa.sym} 140 230 0 0 {name=C1
m=1
value=1T
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 90 260 0 1 {name=l2 lab=GND}
C {devices/gnd.sym} 140 260 0 1 {name=l5 lab=GND}
C {devices/lab_pin.sym} -70 60 3 0 {name=p4 sig_type=std_logic lab=Ib}
C {devices/vdd.sym} -70 -50 0 0 {name=l8 lab=VDD}
C {devices/lab_pin.sym} 140 80 2 0 {name=p2 sig_type=std_logic lab=Vin}
C {devices/capa.sym} 280 230 0 0 {name=C2
m=1
value=71.72f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 280 260 0 1 {name=l9 lab=GND}
