import delimited https://calebasaraba.github.io/gm-workshop/strings.csv, clear rowrange(2:)

generate id = real(word(v1, 1))
generate breath_before = real(word(v1,2))
generate breath_after = real(word(v1,3))
generate color_group = word(v1,4)
generate gender = word(v1, 5)
generate treatment_group = word(v1, 6)
generate birth_date = word(v1, 7)
generate end_date = word(v1, 8)

encode(color_group), generate(color_code)
codebook color_code
encode(treatment_group), generate(treatment_code)
codebook treatment_code
encode(gender), generate(gender_code)
codebook gender_code
drop color_group treatment_group gender

generate birth_date_sif = date(birth_date, "YMD")
generate end_date_sif = date(end_date, "YMD")

generate age = round((end_date_sif - birth_date_sif)/365)

format birth_date_sif end_date_sif %td

drop v1 birth_date end_date

label variable id "ID Number"
label variable breath_before "Breath Value Before Drug"
label variable breath_after "Breath Value After Drug"
label variable color_code "Group Color Code"
label variable treatment_code "Treatment or Control Group"
label variable gender_code "Reported Gender"
label variable birth_date_sif "Patient Birth Date"
label variable end_date_sif "End of Study Date"
label variable age "Patient Age at End of Study (Years)"


save drug.dta, replace
