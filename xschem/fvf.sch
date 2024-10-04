v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 0 30 0 70 {
lab=VOUT}
N 40 100 140 100 {
lab=Ib}
N 140 -40 140 100 {
lab=Ib}
N -0 -40 140 -40 {
lab=Ib}
N 40 0 50 0 {
lab=VIN}
N 0 50 10 50 {
lab=VOUT}
N 0 -40 -0 -30 {
lab=Ib}
N 0 -50 0 -40 {
lab=Ib}
C {devices/ipin.sym} 50 0 2 0 {name=p2 lab=VIN}
C {devices/opin.sym} 10 50 0 0 {name=p3 lab=VOUT}
C {devices/iopin.sym} 0 130 1 0 {name=p5 lab=GND}
C {sky130_fd_pr/nfet3_01v8.sym} 20 0 0 1 {name=M1
L=2.5
W=1.117691
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
C {sky130_fd_pr/nfet3_01v8.sym} 20 100 0 1 {name=M2
L=0.6
W=1.174662
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
C {devices/ipin.sym} 0 -50 1 0 {name=p1 lab=Ib}
