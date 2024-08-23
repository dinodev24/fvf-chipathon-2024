v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 0 30 0 70 {
lab=Vout}
N 0 -50 -0 -30 {
lab=Vdd}
N 40 100 140 100 {
lab=Vdd}
N 140 -40 140 100 {
lab=Vdd}
N -0 -40 140 -40 {
lab=Vdd}
N 40 0 50 0 {
lab=Vin}
N 0 50 10 50 {
lab=Vout}
N 0 130 0 190 {
lab=#net1}
N -120 220 -40 220 {
lab=Ib}
N -160 170 -160 190 {
lab=Ib}
N -160 180 -110 180 {
lab=Ib}
N -110 180 -110 220 {
lab=Ib}
N -160 250 -160 270 {
lab=#net2}
N -180 270 0 270 {
lab=#net2}
N -0 250 0 270 {
lab=#net2}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 20 0 0 1 {name=M1
L=1
W=15
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
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 20 100 0 1 {name=M2
L=1
W=15
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
C {devices/ipin.sym} 50 0 2 0 {name=p2 lab=Vin}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} -20 220 0 0 {name=M3
L=1
W=2
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
C {sky130_fd_pr/nfet3_01v8_lvt.sym} -140 220 0 1 {name=M4
L=1
W=2
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
C {devices/ipin.sym} -160 170 1 0 {name=p4 lab=Ib}
C {devices/opin.sym} 10 50 0 0 {name=p3 lab=Vout}
C {devices/iopin.sym} 0 -50 3 0 {name=p1 lab=Vdd}
C {devices/iopin.sym} -180 270 2 0 {name=p5 lab=Vss}
