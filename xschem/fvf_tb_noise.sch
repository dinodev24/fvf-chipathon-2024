v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -0 50 0 60 {
lab=GND}
N 60 -0 110 0 {
lab=Vout}
C {sky130_fd_pr/corner.sym} 110 -150 0 0 {name=CORNER only_toplevel=false corner=tt}
C {devices/gnd.sym} 0 60 0 0 {name=l2 lab=GND}
C {devices/vdd.sym} -340 -30 0 0 {name=l3 lab=VCC}
C {devices/gnd.sym} -220 30 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} -340 0 0 0 {name=V1 value=1.8 savecurrent=false}
C {devices/gnd.sym} -340 30 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} -220 -30 1 0 {name=p1 sig_type=std_logic lab=VIN}
C {devices/lab_pin.sym} -60 0 0 0 {name=p2 sig_type=std_logic lab=VIN}
C {devices/code_shown.sym} 0 120 0 0 {name=SPICE
only_toplevel=false
value=".control
    noise v(Vout) V2 dec 20 1000 100e9
    save all

    set wr_vecnames
    setplot noise1
    wrdata noise_inoise_spectrum.txt inoise_spectrum
    wrdata noise_onoise_spectrum.txt onoise_spectrum
    exit
.endc"}
C {devices/isource.sym} -280 0 0 0 {name=I0 value=1u}
C {/foss/designs/fvf-chipathon-2024/xschem/fvf.sym} 0 0 0 0 {name=X1}
C {devices/vsource.sym} -220 0 0 0 {name=V2
value="1.8 AC 1"
savecurrent=false}
C {devices/gnd.sym} -280 30 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} -60 -50 0 0 {name=p4 sig_type=std_logic lab=IBIAS}
C {devices/lab_pin.sym} -280 -30 1 0 {name=p5 sig_type=std_logic lab=IBIAS}
C {devices/lab_pin.sym} 110 0 0 1 {name=p3 sig_type=std_logic lab=Vout}
C {/foss/designs/fvf-chipathon-2024/xschem/cmirror.sym} -30 -110 0 0 {}
C {devices/vdd.sym} -30 -170 0 0 {name=l1 lab=VCC}
