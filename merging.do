*** MERGING EXAMPLE ***


webuse overlap1, clear
list, sepby(id)
webuse overlap2, clear
list

webuse overlap1, clear
merge m:1 id using overlap2, update

webuse overlap1, clear
merge m:1 id using overlap2, update replace

