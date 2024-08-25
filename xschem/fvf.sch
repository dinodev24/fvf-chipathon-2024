v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 0 30 0 70 {
lab=Vout}
N 40 100 140 100 {
lab=#net1}
N 140 -40 140 100 {
lab=#net1}
N -0 -40 140 -40 {
lab=#net1}
N 40 0 50 0 {
lab=Vin}
N 0 50 10 50 {
lab=Vout}
N -120 -90 -40 -90 {
lab=Ib}
N -160 -140 -160 -120 {
lab=Vdd}
N -160 -130 0 -130 {
lab=Vdd}
N 0 -130 0 -120 {
lab=Vdd}
N 0 -60 0 -30 {
lab=#net1}
N -160 -60 -100 -60 {
lab=Ib}
N -100 -90 -100 -60 {
lab=Ib}
C {devices/ipin.sym} 50 0 2 0 {name=p2 lab=Vin}
C {devices/ipin.sym} -160 -60 3 0 {name=p4 lab=Ib}
C {devices/opin.sym} 10 50 0 0 {name=p3 lab=Vout}
C {devices/iopin.sym} -160 -140 3 0 {name=p1 lab=Vdd}
C {devices/iopin.sym} 0 130 1 0 {name=p5 lab=Vss}
C {sky130_fd_pr/nfet3_01v8.sym} 20 0 0 1 {name=M1
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
C {sky130_fd_pr/nfet3_01v8.sym} 20 100 0 1 {name=M2
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
C {sky130_fd_pr/pfet3_01v8_lvt.sym} -140 -90 0 1 {name=M3
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
C {sky130_fd_pr/pfet3_01v8_lvt.sym} -20 -90 0 0 {name=M4
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
