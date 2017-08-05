*****TITANIC DO FILE*******

*** LOADING DATA SLIDES ***
*** Exercise (1) ***

clear 
import delimited titanic.csv

keep name age sex survived fare

//keep if age > 20 & survived == 1 

label variable survived "Disaster Survival"
label variable name "Passenger Name"
label variable sex "Passenger Sex"
label variable fare "Ticket Price"
label variable age "Passenger Age"

save titanic, replace

*** COMMANDS SLIDES ***
*** Exercise (1) ***

generate over_30 = 1 if age > 30 & !missing(age)
replace over_30 = 0 if age <= 30

label variable over_30 "Over Age 30"
label define yesno 0 "30 or under" 1 "Over 30" 
label values over_30 yesno

tabulate over_30 survived
notes over_30: 179 Passengers Over Age 30 Survived

bysort survived: summarize age
notes survived: Mean age of survivors is 28.9, mean age of non-survivors is 30.5

codebook sex 
encode sex, gen(sex_code)
tabulate sex_code survived

notes sex_code: 339 Females survived

notes

save titanic, replace

*** STORED RESULTS ***
*** Exercises 1 ***

use titanic, clear

ttest age == 32

notes age: T-test performed; failed to reject the null hypothesis that  ///
			mean age on the titanic is equal to 32 years, with a test statistic ///
			of `r(t)' and a p-value of `r(p)'
			
ttest age, by(survived)

notes survived: T-test performed on age; failed to reject the null hypothesis ///
				that mean ages were equal across survival groups, with a test ///
				statistic of `r(t)' and a p-value of `r(p)'

notes
