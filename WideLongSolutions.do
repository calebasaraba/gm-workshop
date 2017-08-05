*** Code to download cale / lizard data

import excel ///
	https://calebasaraba.github.io/gm-workshop/cale_lizard.xlsx, ///
	clear firstrow
	
*** Moving from Wide to Long

reshape long Temp, i(Name) j(Visit)	
	
reshape wide 

reshape long

*** Exercises (1) ***

webuse reshape1, clear

// Stub - inc
// identifier = id
// new time variable = Year
reshape long inc ue, i(id) j(Year)


*** Exercises (2) ***
webuse bplong, clear

reshape wide bp, i(patient) j(when)
