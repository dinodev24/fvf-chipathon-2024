v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 220 0 220 10 {
lab=#net1}
N 220 -10 220 0 {
lab=#net1}
N 160 -40 180 -40 {
lab=#net2}
N 120 -10 170 -10 {
lab=#net2}
N 170 -40 170 -10 {
lab=#net2}
N 120 -70 220 -70 {
lab=VCC}
N -180 -40 -160 -40 {
lab=#net3}
N -220 -70 -120 -70 {
lab=VCC}
N -170 -40 -170 -10 {
lab=#net3}
N -170 -10 -120 -10 {
lab=#net3}
N -220 70 -220 90 {
lab=#net4}
N -220 -10 -220 10 {
lab=#net5}
N -320 0 -220 0 {
lab=#net5}
N -320 0 -320 120 {
lab=#net5}
N -320 120 -260 120 {
lab=#net5}
N 220 70 220 90 {
lab=#net6}
N -310 40 -260 40 {
lab=VINP}
N -310 -160 -310 40 {
lab=VINP}
N -310 -160 -260 -160 {
lab=VINP}
N 260 120 320 120 {
lab=#net1}
N 220 0 320 0 {
lab=#net1}
N 320 0 320 120 {
lab=#net1}
N 260 40 310 40 {
lab=VINN}
N 310 -160 310 40 {
lab=VINN}
N 260 -160 310 -160 {
lab=VINN}
N -220 80 -40 80 {
lab=#net4}
N -40 80 40 -130 {
lab=#net4}
N 40 -130 220 -130 {
lab=#net4}
N -220 -130 -40 -130 {
lab=#net6}
N -40 -130 40 80 {
lab=#net6}
N 40 80 220 80 {
lab=#net6}
N 140 -220 220 -220 {
lab=#net7}
N -220 -220 -140 -220 {
lab=#net8}
N -80 -220 80 -220 {
lab=#net9}
N -180 -280 180 -280 {
lab=#net9}
N 220 -250 220 -190 {
lab=#net7}
N -220 -250 -220 -190 {
lab=#net8}
N 0 -280 0 -220 {
lab=#net9}
N -380 -320 380 -320 {
lab=VCC}
N 220 -220 320 -220 {
lab=#net7}
N 320 -280 320 -220 {
lab=#net7}
N 320 -280 340 -280 {
lab=#net7}
N -340 -280 -320 -280 {
lab=#net8}
N -320 -280 -320 -220 {
lab=#net8}
N -320 -220 -220 -220 {
lab=#net8}
N -340 200 340 200 {
lab=#net10}
N -380 -250 -380 170 {
lab=#net10}
N -380 160 -320 160 {
lab=#net10}
N -320 160 -320 200 {
lab=#net10}
N 380 -250 380 170 {
lab=VOUT}
N -730 -20 -690 -20 {
lab=#net11}
N -910 -70 -910 90 {
lab=#net11}
N -910 -70 -730 -70 {
lab=#net11}
N -910 150 -910 170 {
lab=GND}
N -730 150 -730 170 {
lab=GND}
N -730 70 -650 70 {
lab=#net12}
N -730 70 -730 90 {
lab=#net12}
N -730 20 -690 20 {
lab=GND}
N -730 20 -730 40 {
lab=GND}
N -810 30 -810 70 {
lab=#net12}
N -650 30 -650 70 {
lab=#net12}
N -730 -70 -730 -20 {
lab=#net11}
N -650 -110 -650 -30 {
lab=VINN}
N -810 -110 -810 -30 {
lab=VINP}
N -810 70 -730 70 {
lab=#net12}
N -770 20 -730 20 {
lab=GND}
N -770 -20 -730 -20 {
lab=#net11}
N -380 -320 -380 -310 {
lab=VCC}
N -220 -320 -220 -310 {
lab=VCC}
N 220 -320 220 -310 {
lab=VCC}
N 380 -320 380 -310 {
lab=VCC}
N 380 -0 440 0 {
lab=VOUT}
N -220 -160 -210 -160 {
lab=#net6}
N -210 -160 -210 -130 {
lab=#net6}
N 210 -160 220 -160 {
lab=#net4}
N 210 -160 210 -130 {
lab=#net4}
C {sky130_fd_pr/nfet3_01v8.sym} 240 120 0 1 {name=M1B
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
C {sky130_fd_pr/nfet3_01v8.sym} 240 40 0 1 {name=M2B
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
C {devices/gnd.sym} 220 150 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} 120 -70 0 0 {name=l7 lab=VCC}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 140 -40 0 1 {name=CM3
L=3
W=3.8
nf=1
mult=1
body=VCC
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 200 -40 0 0 {name=CM4
L=3
W=3.8
nf=1
mult=1
body=VCC
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {devices/lab_pin.sym} 310 -160 2 0 {name=p1 sig_type=std_logic lab=VINN}
C {sky130_fd_pr/nfet3_01v8.sym} -240 120 0 0 {name=M1A
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
C {sky130_fd_pr/nfet3_01v8.sym} -240 40 0 0 {name=M2A
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
C {devices/gnd.sym} -220 150 0 1 {name=l2 lab=GND}
C {devices/vdd.sym} -220 -70 0 0 {name=l3 lab=VCC}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} -200 -40 0 1 {name=CM1
L=3
W=3.8
nf=1
mult=1
body=VCC
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} -140 -40 0 0 {name=CM2
L=3
W=3.8
nf=1
mult=1
body=VCC
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {devices/lab_pin.sym} -310 -160 2 1 {name=p6 sig_type=std_logic lab=VINP
}
C {devices/isource.sym} -120 20 0 0 {name=I0 value=CACE\{IBIAS\}}
C {devices/isource.sym} 120 20 0 1 {name=I1 value=CACE\{IBIAS\}}
C {devices/gnd.sym} -120 50 0 0 {name=l4 lab=GND}
C {devices/gnd.sym} 120 50 0 1 {name=l5 lab=GND}
C {devices/res.sym} -110 -220 1 0 {name=R1
value=40k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 110 -220 1 0 {name=R2
value=40k
footprint=1206
device=resistor
m=1}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 200 -280 0 0 {name=M3B
L=3
W=3.8
nf=1
mult=1
body=VCC
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} -200 -280 0 1 {name=M3A
L=3
W=3.8
nf=1
mult=1
body=VCC
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {devices/vdd.sym} 0 -320 0 0 {name=l6 lab=VCC}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 360 -280 0 0 {name=M4B
L=3
W=3.8
nf=1
mult=1
body=VCC
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} -360 -280 0 1 {name=M4A
L=3
W=3.8
nf=1
mult=1
body=VCC
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {devices/gnd.sym} -380 230 0 1 {name=l8 lab=GND}
C {devices/gnd.sym} 380 230 0 1 {name=l9 lab=GND}
C {devices/lab_pin.sym} 440 0 2 0 {name=p2 sig_type=std_logic lab=VOUT}
C {devices/vsource.sym} -470 0 0 0 {name=vin value=CACE\{vcc\} savecurrent=false}
C {devices/gnd.sym} -470 30 0 0 {name=l10 lab=GND}
C {devices/vdd.sym} -470 -30 0 0 {name=l11 lab=VCC}
C {devices/vcvs.sym} -810 0 0 1 {name=E1 value=0.5}
C {devices/vcvs.sym} -650 0 0 0 {name=E2 value=-0.5}
C {devices/vsource.sym} -910 120 0 0 {name=Vdm value="ac 1" savecurrent=false}
C {devices/vsource.sym} -730 120 0 0 {name=Vcm value=CACE\{vcm\} savecurrent=false}
C {devices/gnd.sym} -910 170 0 0 {name=l13 lab=GND}
C {devices/gnd.sym} -730 170 0 0 {name=l14 lab=GND}
C {devices/gnd.sym} -730 40 0 0 {name=l15 lab=GND}
C {devices/lab_pin.sym} -810 -110 2 1 {name=p4 sig_type=std_logic lab=VINP
}
C {devices/lab_pin.sym} -650 -110 0 0 {name=p5 sig_type=std_logic lab=VINN}
C {devices/capa.sym} 410 30 0 0 {name=C1
m=1
value=CACE\{cl\}
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 410 60 0 0 {name=l12 lab=GND}
C {sky130_fd_pr/nfet3_01v8.sym} -360 200 0 1 {name=M5A
L=0.15
W=1
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
C {sky130_fd_pr/nfet3_01v8.sym} 360 200 0 0 {name=M5B
L=0.15
W=1
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
C {sky130_fd_pr/nfet_01v8.sym} -240 -160 0 0 {name=MinA
L=0.15
W=1
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
C {sky130_fd_pr/nfet_01v8.sym} 240 -160 0 1 {name=MinB
L=0.15
W=1
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
C {devices/code_shown.sym} 540 -250 0 0 {name=SETUP
simulator=ngspice
only_toplevel=false
value="
.lib CACE\{PDK_ROOT\}/CACE\{PDK\}/libs.tech/combined/sky130.lib.spice CACE\{corner\}

.include CACE\{DUT_path\}

.temp CACE\{temperature\}

.option SEED=CACE[CACE\{seed=12345\} + CACE\{iterations=0\}]

* Flag unsafe operating conditions (exceeds models' specified limits)
.option warn=1
"}
C {devices/code_shown.sym} 540 0 0 0 {name=CONTROL
simulator=ngspice
only_toplevel=false
value="
.control
    * run ac simulation
    ac dec 20 1k 1e12

    * measure parameters
    let vout_mag = abs(v(Vout))
    let vout_phase_margin = phase(v(Vout)) * 180/pi + 180
    meas ac A0 find vout_mag at=1k
    meas ac UGF when vout_mag=1 fall=1
    meas ac PM find vout_phase_margin when vout_mag=1

    echo $&A0 $&ugf $&PM > CACE\{simpath\}/CACE\{filename\}_CACE\{N\}.data
.endc
"}
