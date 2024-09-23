v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -40 0 40 0 {
lab=IIN}
N -80 -50 -80 -30 {
lab=VCC}
N -80 -40 80 -40 {
lab=VCC}
N 80 -40 80 -30 {
lab=VCC}
N 0 0 0 30 {
lab=IIN}
N -80 30 -0 30 {
lab=IIN}
C {devices/ipin.sym} -80 30 3 0 {name=p4 lab=IIN}
C {devices/iopin.sym} -80 -50 3 0 {name=p1 lab=VCC}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} -60 0 0 1 {name=M1
L=1
W=2
body=VCC
nf=1
mult=2
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 60 0 0 0 {name=M2
L=1
W=2
body=VCC
nf=1
mult=2
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {devices/opin.sym} 80 30 1 0 {name=p3 lab=IOUT}
