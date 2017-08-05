*****AUTO FILE SOLUTIONS*******

*** VARIABLES SLIDES ***
*** Exercise (1) ***
clear

sysuse auto

generate price_cat = 0 if price < 4000
replace price_cat = 1 if price >= 4000 & price <= 6000
replace price_cat = 2 if price > 6000

label variable price_cat "Car Price Category"
label define price_levels 0 "Cheap" 1 "Moderate" 2 "Expensive"
label values price_cat price_levels

codebook price_cat

label define price_levels 2 "Fancy", modify

codebook price_cat

notes: Cale Basaraba 07/26/2017

notes

*** SAVING / MERGING SLIDES ***
*** Exercise (1) ***

use auto, clear

drop rep78 foreign price_cat

save auto_cont.dta, replace

use auto, clear

keep make rep78 foreign price_cat

save auto_other.dta, replace

use auto_cont, clear

merge 1:1 make using auto_other

drop _merge

save auto_merged, replace

use auto, clear 

replace headroom = weight

merge 1:1 make using auto

* Q: What happens to the headroom variable?
* A: The headroom values from the "master" dataset supersede those from
* 		the "using" dataset. Read help merge for more details about this
* 		type of behavior



*** GRAPHS SLIDES ***
*** Exercises (2) ***

use auto, clear

foreach var of varlist mpg headroom trunk { //A
	graph twoway scatter price `var', title("Price vs. `var'")
	graph save price_`var', replace
	}
	
	
graph box mpg, over(price_cat) by(foreign) name(mpg_price_cat)

graph box headroom, over(price_cat) by(foreign) name(headroom_price_cat)

graph combine mpg_price_cat headroom_price_cat

graph export auto_boxplots.tif


*** FOR LOOPS SLIDES ***
*** Exercises (1) ***

use auto, clear

foreach var of varlist * {
	if "`var'" != "make" {
		summarize `var'
	}
}

foreach myvar in mpg weight turn {
	graph twoway scatter price `myvar'
}

codebook price_cat

forvalues v = 0/2 {
	use auto, clear
	keep if price_cat == `v'
	save auto`v', replace
	clear
}



*** STORED RESULTS SLIDES ***
*** Exercises (2) ***

use auto, clear

foreach var of varlist mpg price headroom {
	summarize `var'
	gen `var'_standard = (`var' - r(mean))/r(sd)
}

regress price_standard mpg_standard headroom_standard

generate beta_mpg = _b[mpg_standard]
generate beta_headroom = _b[headroom_standard]

regress price mpg headroom, beta

* There is no way to pull these standardized coefficients out when using the 
* beta option in regress. If you want them as stored results you should
* standardize from scratch!


**** LOCAL MACROS SLIDES ****
*** Exercises (1) ***

local cheap_foreign_car price < 5000 & foreign == 1

summarize mpg if `cheap_foreign_car'

summarize price if foreign == 1
local min_foreign_price = r(min)

summarize price if foreign == 0
local min_domestic_price = r(min)

display `min_foreign_price'
display `min_domestic_price'

if `min_foreign_price' < `min_domestic_price' {
	display as red "Minimum price is less for foreign cars"
}
else {
	display as red "Minimum price is less for domestic cars"
	}


*** Exercises (2) ***

foreach var of varlist mpg weight {
	correlate price `var'
	local `var'_corr = r(rho)
}

display `mpg_corr'
display `weight_corr'

if abs(`mpg_corr') > abs(`weight_corr') {
	graph twoway scatter price mpg
}

if abs(`weight_corr') > abs(`mpg_corr') {
	graph twoway scatter price weight
}





