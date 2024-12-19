* ota_perf_eval.sp
** OpenFASOC Team, Ryan Wans 2023
.param mc_mm_switch=0

** IMPORTANT:   Temperature setting is added automatically in the reading
**              of this file on line 6 as 25. DO NOT OVERRIDE.
.temp {@@TEMP}

*.save all
** Define global parameters for altering
.param b1 = 10u
.param b2 = 10u

** Define netlist
Vsupply VDD GND 1.8
**V0 AVSS GND 0
Vindc net1 GND 0.9
V2_ac net2 net1 DC 0 AC -0.5
V3_ac net3 net1 DC 0 AC 0.5
V2_tran net4 net1 pulse(0.9 -0.9 50us 100ns 100ns 50us 100us)
V3_tran net5 net1 pulse(-0.9 0.9 50us 100ns 100ns 50us 100us)

R_ac1 vin net2 10M
R_ac2 vip net3 10M
R_tran1 vin net4 10M
R_tran2 vip net5 10M
*.save i(vindc)
*.save i(vsupply)
*.save i(v2)
*.save i(v3)

* bias currents
Ibias1 VDD bias1  {b1}
Ibias2 VDD bias2  {b2}

** Import SKY130 libs (this should be replaced with a path relative to some env variable)
* the ones with double * will not be used. The one with only 1 * will be used

** example not used
**@@stp .include /home/rw/work/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/spice/sky130_fd_sc_hvl.spice

** GCP machine
.lib @@PDK_ROOT/sky130A/libs.tech/ngspice/sky130.lib.spice tt
*@@stp .include @@PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hvl/spice/sky130_fd_sc_hvl.spice


** Import cryo libs (these are stored in the sky130A folder)
*@@cryo .include ./sky130A/cryo_models/nshort.spice
*@@cryo .include ./sky130A/cryo_models/nshortlvth.spice
*@@cryo .include ./sky130A/cryo_models/pmos.spice

** Import ota subcircuit
.include ota_pex.spice
XDUT GND vin vip vo VDD bias1 bias2 ota
* parameter sweep
** Run initial analysis
*.save all
*.options savecurrents
*.ac dec 10 10 10G
.control
** Set initial values
set filetype = ascii
let maxFOM = -1
let maxBi1 = -1
let maxBi2 = -1
let savedriseslew = -1
let savedfallslew = -1

* dp and cs bias log step
*let linear_step_until = 0u
*let linear_step_default = 1.1u
*let bias_dp_Min  = 25u
*let bias_dp_Max  = 200u
*let bias_dp_logStep = 1.15
*let bias_cs_Min  = 30u
*let bias_cs_Max  = 1m
*let bias_cs_logStep = 1.18

* dp and cs bias log step
let linear_step = 1u
let bias_Min  = 5u
let bias_Max  = 15u

let bias = bias_Min

let absolute_counter = 0

*let ac_v2 = "DC 0 AC -0.5"
*let ac_v3 = "DC 0 AC 0.5"
*let tran_v2 = "pulse(0 -0.9 50us 100ns 100ns 50us 100us)"
*let tran_v3 = "pulse(0 0.9 50us 100ns 100ns 50us 100us)"

** Sweep bias voltages
while bias le bias_Max
    *reset
    alter ibias1 = $&bias
    alter ibias2 = $&bias
	echo  "-- Run # $&absolute_counter -- "
    echo "1: $&bias"
    echo "2: $&bias"
    
    
	alter R_tran1 = 10M
	alter R_tran2 = 10M
	alter R_ac1 = 1000G
	alter R_ac2 = 1000G
	
	tran 25n 150u
	** Find slew rate
	let rise_slew = maximum(deriv(v(vo))) * 1e-6
	let fall_slew = abs(minimum(deriv(v(vo)))) * 1e-6
    echo "rise_slew: $&rise_slew"
    echo "fall_slew: $&fall_slew"
	
	** if FOM is better than previous max save results
	let slew_FOM_factor = 0.0000001
    if ( rise_slew ge 3.5 )
		if ( fall_slew ge 2.5 )
			let slew_FOM_factor = (((rise_slew - 3.5 ) ^ 2) + ((fall_slew - 2.5 ) ^ 2)) / 2
		end
	end
	let FOM = ((0.2 * (absolute_counter + 5)) - (0.01 * ((absolute_counter + 5) ^ 2))) * slew_FOM_factor 
    *
    * debug outputs
    echo "finished computations, and calculated the following"
   	echo "slew factor:"
    print slew_FOM_factor
	echo "FOM"
    print FOM
    echo "max FOM"
    print maxFOM
    * end debug outputs
    *
    if ( FOM ge maxFOM )
		echo "now setting a new maxFOM"
        let maxFOM = FOM
        let maxBi1 = bias
        let maxBi2 = bias
        let savedriseslew = rise_slew
		let savedfallslew = fall_slew
    end
	
	alter R_ac1 = 10M
	alter R_ac2 = 10M

    let absolute_counter = absolute_counter + 1
	let bias = bias + linear_step
end
** Export global maxima
echo "the final saved slew rates are:"
print savedriseslew
print savedfallslew
wrdata result_slew.txt savedriseslew savedfallslew

** Export power usage of correctly biased ota
alterparam b1 = $&maxBi1
alterparam b2 = $&maxBi2

reset
alter R_tran1 = 1000G 
alter R_tran2 = 1000G
save vo
ac dec 10 10 1G
** Find unity-gain bw point
meas ac ugb_f when vdb(vo)=0
** Measure phase margin
let phase_margin = 180+(180/PI)*vp(vo)
meas ac pm find phase_margin when vdb(vo)=0
** Measure DC(ish) gain
meas ac dcg find vdb(vo) at=10
** Measure 3db BW
let threedbabsgain = dcg - 3
meas ac threedb when vdb(vo)=threedbabsgain FALL=1
wrdata result_ac.txt ugb_f maxBi1 maxBi2 pm dcg threedb

reset
alter R_tran1 = 1000G 
alter R_tran2 = 1000G
op
let ptotal_exact = -i(vsupply)*1.8
wrdata result_power.txt ptotal_exact 

** Run noise analysis on ota w/ best gain
reset
alter R_tran1 = 1000G 
alter R_tran2 = 1000G
noise V(vo) V2_ac dec 100 1k 1G
setplot previous
let integ = integ(onoise_spectrum)
let totalNoise = sqrt(integ[length(integ)-1])
wrdata result_noise.txt totalNoise

quit
.endc
.GLOBAL GND
.GLOBAL VDD
.end

