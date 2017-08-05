*****MOVIES DO FILE*******

*** LOADING DATA SLIDES ***
*** Exercise (2) ***

import excel movie_metadata.xls, clear firstrow 

drop if duration <= 45

keep duration gross movie_title country budget imdb_score

//keep if country == "USA"

save movies, replace


*** VARIABLES SLIDES***
*** Exercise (2) ***

use movies, clear

encode(country), gen(country_code)

codebook country_code
tabulate country_code

drop if missing(country_code)

generate cheap = 0 if budget > 1000000 & !missing(budget)
replace cheap = 1 if budget <= 1000000

rename cheap expensive
recode expensive (0 = 1) (1 = 0)
 
notes country_code: Cale Basaraba 07/26/2017
notes expensive: Cale Basaraba 07/26/2017

notes

save movies, replace

*** COMMANDS SLIDES ***
*** Exercise (2) ***

use movies, clear

tabstat duration gross budget imdb_score, statistics(mean count p25 p75 range)

pwcorr duration gross budget imdb_score, sig
 

bysort expensive: tabstat duration gross budget imdb_score, ///
		statistics(mean count p25 p75 range) 
		
*** GRAPHS SLIDES***
*** Exercise (1) ***

use movies, clear

graph twoway scatter gross budget, xscale(log) yscale(log) name(gross_budget_log)

graph box imdb_score, over(expensive) name(imdb_expensive) 

graph bar, over(country_code, label(angle(vertical))) name(movies_country) 

graph combine gross_budget_log imdb_expensive movies_country, cols(1) 
graph save movies_col, replace

graph combine gross_budget_log imdb_expensive movies_country, rows(1)
graph save movies_row, replace

