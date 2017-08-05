**** LOOP PRACTICE ***

foreach file in auto titanic movies { //A
	use `file', clear
	notes
	clear
}

forvalues i = 1/8 { //B
	display `i'* 8
}

forvalues i = 1/5 { //C
	if `i' != 3 {
		use titanic, clear
		save titanic`i'
	}
	clear
}
