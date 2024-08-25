v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 0 240 0 280 {
lab=Vout}
N 0 340 0 380 {
lab=#net1}
N -120 410 -40 410 {
lab=Ib}
N -160 340 -160 380 {
lab=Ib}
N -160 360 -100 360 {
lab=Ib}
N -100 360 -100 410 {
lab=Ib}
N 0 160 0 180 {
lab=VDD}
N 0 260 10 260 {
lab=Vout}
C {sky130_fd_pr/corner.sym} 110 -150 0 0 {name=CORNER only_toplevel=false corner=tt}
C {devices/vdd.sym} -370 -30 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} -370 160 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} -370 0 0 0 {name=Vin value=1.8 savecurrent=false}
C {devices/gnd.sym} -370 30 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} -370 100 1 0 {name=p1 sig_type=std_logic lab=Vin}
C {devices/code_shown.sym} 250 40 0 0 {name=SPICE
only_toplevel=false
value=".ac dec 20 1 1e8
.save all"}
C {devices/vsource.sym} -370 130 0 0 {name=Vin1
value="1.8 AC 1"
savecurrent=false}
C {devices/isource.sym} -280 130 0 0 {name=I1 value=1u}
C {devices/gnd.sym} -280 160 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} -280 100 1 0 {name=p6 sig_type=std_logic lab=Ib}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 20 210 0 1 {name=M1
L=0.15
W=1
nf=1
mult=1
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 20 310 0 1 {name=M2
L=0.15
W=1
nf=1
mult=1
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} -20 410 0 0 {name=M3
L=0.15
W=1
nf=1
mult=1
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} -140 410 0 1 {name=M4
L=0.15
W=1
nf=1
mult=1
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {devices/lab_pin.sym} -160 340 0 0 {name=p7 sig_type=std_logic lab=Ib}
C {devices/gnd.sym} -160 440 0 0 {name=l8 lab=GND}
C {devices/gnd.sym} 0 440 0 0 {name=l9 lab=GND}
C {devices/vdd.sym} 0 160 0 0 {name=l10 lab=VDD}
C {devices/lab_pin.sym} 40 310 2 0 {name=p8 sig_type=std_logic lab=Vin}
C {devices/lab_pin.sym} 10 260 0 1 {name=p9 sig_type=std_logic lab=Vout}
C {devices/gnd.sym} 40 210 0 0 {name=l1 lab=GND}
