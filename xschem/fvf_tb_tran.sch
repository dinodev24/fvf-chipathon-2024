v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
C {sky130_fd_pr/corner.sym} 110 -150 0 0 {name=CORNER only_toplevel=false corner=tt}
C {devices/gnd.sym} 0 60 0 0 {name=l2 lab=GND}
C {devices/vdd.sym} 0 -60 0 0 {name=l3 lab=VCC}
C {devices/gnd.sym} -350 30 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} -470 0 0 0 {name=Vin value=1.8 savecurrent=false}
C {devices/gnd.sym} -470 30 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} -350 -30 1 0 {name=p1 sig_type=std_logic lab=VIN}
C {devices/code_shown.sym} 0 120 0 0 {name=SPICE
only_toplevel=false
value=".control
    tran 0.1n 1u
    save all

    set wr_vecnames
    wrdata transient_vin.txt v(vin)
    wrdata transient_vout.txt v(vout)
.endc"}
C {devices/isource.sym} -410 0 0 0 {name=I0 value=3u}
C {devices/vsource.sym} -350 0 0 0 {name=Vin1
value="pulse(0 1.8 10ns 10ns 10ns 40ns 100ns)"
savecurrent=false}
C {devices/gnd.sym} -410 30 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} -410 -30 1 0 {name=p5 sig_type=std_logic lab=IBIAS}
C {devices/lab_pin.sym} 60 0 0 1 {name=p3 sig_type=std_logic lab=Vout}
C {devices/lab_pin.sym} -60 20 0 0 {name=p4 sig_type=std_logic lab=IBIAS}
C {devices/lab_pin.sym} -60 -20 0 0 {name=p6 sig_type=std_logic lab=VIN}
C {devices/vdd.sym} -470 -30 0 0 {name=l1 lab=VCC}
C {/foss/designs/fvf-chipathon-2024/xschem/n_fvf_cell.sym} 0 0 0 0 {name=X1}
