import delimited "C:\Users\mariu\Downloads\DOT_03-06-2019 15-15-09-27_timeSeries.csv", clear

sort countrycode counterpartcountryname indicatorname

**** Do exports first **
drop if strpos(indicatorname, "Balance")!=0
drop if strpos(indicatorname, "Import") !=0
drop if strpos(attribute, "Status") !=0

rename ïcountryname countryname

sort countryname counterpartcountryname

gen id = _n

drop v26

reshape long v, i(id) j(year)

by id: gen time = _n

**** Now we have all exports in the right shape *****
*** Drop aggregates and other continents / On partner side only aggregates *****
sort countrycode time

drop if countrycode < 611
drop if countrycode > 800

sort counterpartcountrycode
drop if counterpartcountrycode < 111
drop if counterpartcountrycode == 163
drop if counterpartcountrycode == 200
drop if counterpartcountrycode == 205
drop if counterpartcountrycode == 399
drop if counterpartcountrycode == 405
drop if counterpartcountrycode == 440
drop if counterpartcountrycode == 489
drop if counterpartcountrycode == 505
drop if counterpartcountrycode == 598
drop if counterpartcountrycode == 603
drop if counterpartcountrycode == 605
drop if counterpartcountrycode == 884
drop if counterpartcountrycode == 898
drop if counterpartcountrycode == 899
drop if counterpartcountrycode == 901
drop if counterpartcountrycode == 903
drop if counterpartcountrycode == 910
drop if counterpartcountrycode == 998
drop if counterpartcountrycode == 799
sort id year

**** Drop too-rich African countries ****
foreach i in 611 612 616 624 646 672 684 686 718 728 734 744{
drop if countrycode == `i'
}

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Exports_DOT.dta", replace


***** Next, tackle balance *****

import delimited "C:\Users\mariu\Downloads\DOT_03-06-2019 15-15-09-27_timeSeries.csv", clear

sort countrycode counterpartcountryname indicatorname

**** Drop exports first **
drop if strpos(indicatorname, "Import")!=0
drop if strpos(indicatorname, "Export") !=0
drop if strpos(attribute, "Status") !=0

rename ïcountryname countryname

sort countryname counterpartcountryname

gen id = _n

drop v26

reshape long v, i(id) j(year)

by id: gen time = _n

rename v trade_balance

**** Now we have all exports in the right shape *****
*** Drop aggregates and other continents / On partner side only aggregates *****
sort countrycode time

drop if countrycode < 611
drop if countrycode > 800
drop if counterpartcountrycode < 111

foreach i in 163 200 205 399 405 440 489 505 598 603 605 884 898 899 901 903 910 998{
	drop if counterpartcountrycode == `i'
}

drop if counterpartcountrycode == 799

sort id year

**** Drop too-rich African countries ****
foreach i in 611 612 616 624 646 672 684 686 718 728 734 744{
drop if countrycode == `i'
}

sort time id

drop id

merge 1:1 countryname counterpartcountryname time using "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Exports_DOT.dta"

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta", replace

drop if counterpartcountrycode == 799

rename v exports

drop _merge

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta", replace


******************** Generating imports variable ********************
// 1 means is available, 0 not

import delimited "C:\Users\mariu\Downloads\DOT_03-06-2019 15-15-09-27_timeSeries.csv", clear 

keep if strpos(indicatorname, "Exports")!=0
drop if strpos(attribute, "Status") != 0
sort counterpartcountryname

foreach i in 163 200 205 399 405 440 489 505 598 603 605 884 898 899 901 903 910 998{
	drop if counterpartcountrycode == `i'
}

drop if counterpartcountrycode == 799

foreach i in 611 612 616 624 646 672 684 686 718 728 734 744{
drop if countrycode == `i'
}

gen id = _n
drop v26
reshape long v, i(id) j(year)

drop attribute
drop indicatorcode
rename v imports

rename counterpartcountryname country_name
rename ïcountryname counterpart
rename countrycode counterpart_code
rename counterpartcountrycode countrycode
sort country_name year

drop if countrycode < 611
drop if countrycode > 800

drop if counterpart_code < 111

foreach i in 163 200 205 399 405 440 489 505 598 603 605 884 898 899 901 903 910 998{
	drop if counterpart_code == `i'
}
drop if counterpart_code == 799
drop if countrycode == 799

foreach i in 611 612 616 624 646 672 684 686 718 728 734 744{
drop if countrycode == `i'
}

drop id
sort year country_name counterpart

sort country_name year counterpart
by country_name: gen time = _n

drop indicatorname year

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\imports.dta", replace

********************************************************************************
*************************** Still to add: Ebola, WHO and WDI *******************

use "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta", clear

// Ebola - 0/1

gen ebola = 0
foreach i in 656 668 724{
	foreach j in 15 16 17{
		recode ebola 0=1 if countrycode == `i' & time == `j'
	}
}

// Ebola Cases

gen ebola_cases = 0
recode ebola_cases 0= 2707 if strpos(countryname, "Guinea")!=0
recode ebola_cases 2707=0 if year != 2014
recode ebola_cases 0= 3804 if strpos(countryname, "Guinea")!=0 
recode ebola_cases 3804=0 if time != 16
recode ebola_cases 0= 3814 if strpos(countryname, "Guinea")!=0 
recode ebola_cases 3814=0 if time != 17
recode ebola_cases 2707 = 0 if strpos(countryname, "Bissau")!=0
recode ebola_cases 3804 = 0 if strpos(countryname, "Bissau")!=0
recode ebola_cases 3814 = 0 if strpos(countryname, "Bissau")!=0

recode ebola_cases 3424 = 0 if year < 2014

recode ebola_cases 0= 8018 if strpos(countryname, "Liberia")!=0
recode ebola_cases 8018=0 if year != 2014
recode ebola_cases 0= 10675 if strpos(countryname, "Liberia")!=0 
recode ebola_cases 10675=0 if time != 16
recode ebola_cases 0= 10678 if strpos(countryname, "Liberia")!=0 
recode ebola_cases 10678=0 if time != 17

recode ebola_cases 0= 9446 if strpos(countryname, "Sierra Leone")!=0
recode ebola_cases 9446=0 if year != 2014
recode ebola_cases 0= 14122 if strpos(countryname, "Sierra Leone")!=0 
recode ebola_cases 14122=0 if time != 16
recode ebola_cases 0= 14124 if strpos(countryname, "Sierra Leone")!=0 & time == 17


// Ebola Deaths

gen ebola_deaths = 0
recode ebola_deaths 0= 1708 if strpos(countryname, "Guinea")!=0
recode ebola_deaths 1708=0 if year != 2014
recode ebola_deaths 0= 2536 if strpos(countryname, "Guinea")!=0 
recode ebola_deaths 2536=0 if time != 16
recode ebola_deaths 1708 = 0 if strpos(countryname, "Bissau")!=0
recode ebola_deaths 2536 = 0 if strpos(countryname, "Bissau")!=0

recode ebola_deaths 4809= 3424 if strpos(countryname, "Liberia")!=0
recode ebola_deaths 0= 3424 if strpos(countryname, "Liberia")!=0
recode ebola_deaths 3424=0 if time < 15
recode ebola_deaths 3424 = 4809 if strpos(countryname, "Liberia")!=0 & time == 16
recode ebola_deaths 4809=0 if time != 16
recode ebola_deaths 4809 = 0 if time == 17

recode ebola_deaths 0= 2758 if strpos(countryname, "Sierra Leone")!=0
recode ebola_deaths 2758=0 if year != 2014
recode ebola_deaths 0= 3955 if strpos(countryname, "Sierra Leone")!=0 
recode ebola_deaths 3955=0 if time != 16

// Ebola Articles

gen ebola_articles = 0
recode ebola_articles 0= 362 if strpos(countryname, "Guinea")!=0
recode ebola_articles 362=0 if time != 15
recode ebola_articles 0= 132 if strpos(countryname, "Guinea")!=0 
recode ebola_articles 132=0 if time != 16
recode ebola_articles 362 = 0 if strpos(countryname, "Bissau")!=0
recode ebola_articles 132 = 0 if strpos(countryname, "Bissau")!=0

recode ebola_articles 0= 527 if strpos(countryname, "Liberia")!=0
recode ebola_articles 527=0 if time != 15
recode ebola_articles 0= 174 if strpos(countryname, "Liberia")!=0 
recode ebola_articles 174=0 if time != 16

recode ebola_articles 0= 439 if strpos(countryname, "Sierra Leone")!=0
recode ebola_articles 439=0 if time != 15
recode ebola_articles 0= 169 if strpos(countryname, "Sierra Leone")!=0 
recode ebola_articles 169=0 if time != 16

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta", replace

********************************************************************************
*************************** Still to add: WHO and WDI **************************

import excel "C:\Users\mariu\Downloads\Data_Extract_From_World_Development_Indicators (3).xlsx", sheet("Data") firstrow clear

rename CountryName countryname
rename Time year
sort countryname year
keep if countryname != ""

foreach i in year countryname{
	destring `i', replace
}

by countryname: gen time = _n
sort time countryname
by time: gen country_no = _n

drop CountryCode TimeCode
sort country_no time

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\WDI.dta", replace

use "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta"

sort countryname time

gen country_no = 1
recode country_no 1 = 2 if strpos(countryname, "Benin") != 0
recode country_no 1 = 3 if strpos(countryname, "Burkina Faso") != 0
recode country_no 1 = 4 if strpos(countryname, "Burundi") != 0
recode country_no 1 = 5 if strpos(countryname, "Cameroon") != 0
recode country_no 1 = 6 if strpos(countryname, "Central") != 0
recode country_no 1 = 6 if strpos(countryname, "Chad") != 0
recode country_no 1 = 7 if strpos(countryname, "Comoros") != 0
recode country_no 1 = 8 if strpos(countryname, "Congo, Democratic") != 0
recode country_no 1 = 9 if strpos(countryname, "Congo, Republic of") != 0
recode country_no 1 = 10 if strpos(countryname, "Ivoire") != 0
recode country_no 1 = 11 if strpos(countryname, "Equatorial") != 0
recode country_no 1 = 12 if strpos(countryname, "Eritrea") != 0
recode country_no 1 = 13 if strpos(countryname, "Ethiopia") != 0
recode country_no 1 = 14 if strpos(countryname, "Gambia") != 0
recode country_no 1 = 15 if strpos(countryname, "Ghana") != 0
recode country_no 1 = 16 if strpos(countryname, "Guinea") != 0
recode country_no 16 = 17 if strpos(countryname, "Bissau") != 0
recode country_no 1 = 18 if strpos(countryname, "Kenya") != 0
recode country_no 1 = 19 if strpos(countryname, "Lesotho") != 0
recode country_no 1 = 20 if strpos(countryname, "Liberia") != 0
recode country_no 1 = 21 if strpos(countryname, "Madagascar") != 0
recode country_no 1 = 22 if strpos(countryname, "Malawi") != 0
recode country_no 1 = 23 if strpos(countryname, "Mali") != 0
recode country_no 1 = 24 if strpos(countryname, "Mauritania") != 0
recode country_no 1 = 25 if strpos(countryname, "Mozambique") != 0
recode country_no 1 = 26 if strpos(countryname, "Niger") != 0
recode country_no 26 = 27 if strpos(countryname, "Nigeria") != 0
recode country_no 1 = 28 if strpos(countryname, "Rwanda") != 0
recode country_no 1 = 29 if strpos(countryname, "Senegal") != 0
recode country_no 1 = 30 if strpos(countryname, "Sierra") != 0
recode country_no 1 = 31 if strpos(countryname, "Somalia") != 0
recode country_no 1 = 32 if strpos(countryname, "South") != 0
recode country_no 1 = 33 if strpos(countryname, "South") != 0
recode country_no 1 = 34 if countrycode == 716
recode country_no 1 = 35 if strpos(countryname, "Tanzania") != 0
recode country_no 1 = 36 if strpos(countryname, "Togo") != 0
recode country_no 1 = 37 if strpos(countryname, "Uganda") != 0
recode country_no 1 = 38 if strpos(countryname, "Zambia") != 0
recode country_no 1 = 39 if strpos(countryname, "Zimbabwe") != 0

merge m:1 country_no time using "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\WDI.dta"

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta", replace

********************************************************************************
********************* Still to add: WHO ****************************************

import delimited "C:\Users\mariu\Downloads\data (3).csv", clear 

rename v1 countryname
rename v2 year
rename v3 life_exp
rename v4 life_exp_male
rename v5 life_exp_female
rename v6 life_60
rename v7 life_60_male
rename v8 life_60_female

drop if year == "" | year == "Year"

foreach i in 9 10 11 12 13 14{
drop v`i'
}

sort year countryname
by year: gen country_no = _n
sort country_no year
foreach i in 1 2 3 5 6 7 8 9 10 11 12 13 14 15 16 17 19 20 21 22 23 24 25 28 29 31 34{
	drop if country_no == `i'
}
foreach i in 35 36 39 40 41 42 43 45 47 48 49 50 51 52 55 56 58 59 60 61 63 64 66 67{
	drop if country_no == `i'
}
foreach i in 68 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 88 89 90 91 92 93 96{
	drop if country_no == `i'
}
foreach i in 97 98 101 102 104 106 107 108 109 110 111 113 114 115 116 117 118 121 122{
	drop if country_no == `i'
}
foreach i in 123 124 125 126 127 128 129 130 131 132 133 134 135 136 138 139 140 142{
	drop if country_no == `i'
}

foreach i in 144 145 147 148 149 150 152 154 155 157 158 159 160 161 162 163 165 166 167{
	drop if country_no == `i'
}
foreach i in 168 169 171 172 173 175 176 177 178 179 180 181 {
	drop if country_no == `i'
}
foreach i in 630/646{
replace countryname = "Tanzania" in `i'
}

sort countryname year
drop country_no
by countryname: gen time = _n
sort year countryname
by year: gen country_no = _n
sort countryname year

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Life_exp.dta", replace

/// Import Mortality Table

import delimited "C:\Users\mariu\Downloads\data (1).csv", clear

rename v1 countryname
rename v2 year
rename v3 adult_mort_adjust
rename v4 adult_mort_adjust_male
rename v5 adult_mort_adjust_female

drop if year == "" | year == "Year"

sort year countryname
by year: gen country_no = _n
sort country_no year
foreach i in 1 2 3 5 6 7 8 9 10 11 12 13 14 15 16 17 19 20 21 22 23 24 25 28 29 31 34{
	drop if country_no == `i'
}
foreach i in 35 36 39 40 41 42 43 45 47 48 49 50 51 52 55 56 58 59 60 61 63 64 66 67{
	drop if country_no == `i'
}
foreach i in 68 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 88 89 90 91 92 93 96{
	drop if country_no == `i'
}
foreach i in 97 98 101 102 104 106 107 108 109 110 111 113 114 115 116 117 118 121 122{
	drop if country_no == `i'
}
foreach i in 123 124 125 126 127 128 129 130 131 132 133 134 135 136 138 139 140 142{
	drop if country_no == `i'
}

foreach i in 144 145 147 148 149 150 152 154 155 157 158 159 160 161 162 163 165 166 167{
	drop if country_no == `i'
}
foreach i in 168 169 171 172 173 175 176 177 178 179 180 181 {
	drop if country_no == `i'
}
foreach i in 630/646{
replace countryname = "Tanzania" in `i'
}

sort countryname year
drop country_no
by countryname: gen time = _n
sort year countryname
by year: gen country_no = _n
sort countryname year

merge m:1 countryname time using "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Life_exp.dta"

drop _merge
sort countryname time

destring year, replace

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\WHO.dta", replace

use "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta", clear

drop _merge

replace countryname = "Sao Tome and Principe" if countrycode == 716
replace countryname = "Congo" if countrycode == 634
replace countryname = "CÃ´te d'Ivoire" if countrycode == 662
replace countryname = "Democratic Republic of the Congo" if countrycode == 636
replace countryname = "Gambia" if countrycode == 648

merge m:1 countryname time using "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\WHO.dta"

drop if _merge != 3
drop _merge



************** Now we have a complete and neatly looking dataset ! *************
********************************************************************************
******** Next step to get our data regressionable - destring and rename ********

sort id time
drop indicatorname

gen pop_total = real(PopulationtotalSPPOPTOTL)
drop PopulationtotalSPPOPTOTL
gen percent_internet = real(IndividualsusingtheInternet)
drop IndividualsusingtheInternet
gen percent_migrants = real(Internationalmigrantstocko)
drop Internationalmigrantstocko
gen pop_dens_sq_km = real(Populationdensitypeoplepers)
drop Populationdensitypeoplepers
gen pop_over_1_mil = real(Populationinurbanagglomeratio)
drop Populationinurbanagglomeratio

gen percent_rural = real(Ruralpopulationoftotalpop)
drop Ruralpopulationoftotalpop
gen percent_urban = real(UrbanpopulationoftotalS)
drop UrbanpopulationoftotalS
gen health_exp = real(Currenthealthexpenditureof)
drop Currenthealthexpenditureof
gen percent_curr_acc = real(CurrentaccountbalanceofGD)
drop CurrentaccountbalanceofGD
gen gdp = real(GDPconstant2010USNYGDP)
drop GDPconstant2010USNYGDP

gen gdp_growth = real(GDPgrowthannualNYGDPMK)
drop GDPgrowthannualNYGDPMK
gen gdp_p_c = real(GDPpercapitaconstant2010US)
drop GDPpercapitaconstant2010US
gen gdp_p_c_growth = real(GDPpercapitagrowthannual)
drop GDPpercapitagrowthannual
gen net_fdi = real(Foreigndirectinvestmentnet)
drop Foreigndirectinvestmentnet
gen net_inflow_fdi_percent = real(Foreigndirectinvestmentneti)
drop Foreigndirectinvestmentneti
gen price_index = real(Consumerpriceindex2010100)
drop Consumerpriceindex2010100

gen real_ex_rate = real(Realeffectiveexchangerateind)
drop Realeffectiveexchangerateind
gen infant_mort = real(Mortalityrateinfantper100)
drop Mortalityrateinfantper100
gen neonatal_mort = real(Mortalityrateneonatalper1)
drop Mortalityrateneonatalper1
gen under_5_mort = real(Mortalityrateunder5per10)
drop Mortalityrateunder5per10
gen prev_anemia_women = real(Prevalenceofanemiaamongwomen)
drop Prevalenceofanemiaamongwomen
drop Prevalenceofanemiaamongnonp

gen crude_birth = real(Birthratecrudeper1000peo)
drop Birthratecrudeper1000peo
gen crude_death = real(Deathratecrudeper1000peo)
drop Deathratecrudeper1000peo
destring adult_mort_adjust, replace
destring adult_mort_adjust_male, replace
destring adult_mort_adjust_female, replace
gen life_both = real(life_exp)
drop life_exp

gen life_m = real(life_exp_male)
drop life_exp_male
gen life_f = real(life_exp_female)
drop life_exp_female
gen life_60_b = real(life_60)
drop life_60
gen life_60_m = real(life_60_male)
drop life_60_male
gen life_60_f = real(life_60_female)
drop life_60_female


********************************************************************************
*************************** Generating Ebola prevalence rate *******************
drop prev_*
gen prev_ebola_cases = ebola_cases / pop_total
gen prev_ebola_death = ebola_deaths / pop_total

replace ebola_cases = 0 if strpos(countryname, "Equatorial") == 1
replace ebola_deaths = 0 if strpos(countryname, "Equatorial") == 1
replace ebola_articles = 0 if strpos(countryname, "Equatorial") == 1
replace ebola_cases = 0 if strpos(counterpartcountryname, "Equatorial" ) == 1 & ///

sort id time
drop avg
egen avg = mean(prev_ebola_cases) if time == 15 & prev_ebola_cases != 0, by(countryname)
recode avg .=0
gen log_prev_avg = log(avg)
recode log_prev_avg .=0

sort countryname time
drop *pre_avg_*

gen pre_avg_1 = avg[_n+1]
gen pre_avg_2 = avg[_n+2]
gen pre_avg_3 = avg[_n+3]
gen pre_avg_4 = avg[_n+4]
gen pre_avg_5 = avg[_n+5]
gen pre_avg_6 = avg[_n+6]
gen pre_avg_7 = avg[_n+7] // Starting here things become an issue!
gen pre_avg_8 = avg[_n+8]
gen pre_avg_9 = avg[_n+9]
gen pre_avg_10 = avg[_n+10]
gen pre_avg_11 = avg[_n+11] // Dropped b/c of collinearity
gen pre_avg_12 = avg[_n+12] // --"--
gen pre_avg_13 = avg[_n+13] // --"--

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta", replace

********************************************************************************
**************************** Adding some forgotten controls ********************

import excel "C:\Users\mariu\Downloads\Data_Extract_From_World_Development_Indicators (4).xlsx", sheet("Data") firstrow clear

rename CountryName countryname
rename Time year
rename CountryCode countrycode
sort countryname year
keep if countryname != ""

foreach i in year countryname{
	destring `i', replace
}

by countryname: gen time = _n
sort time countryname

replace countryname = "Sao Tome and Principe" if countrycode == "STP"
replace countryname = "Congo" if countrycode == "COG"
replace countryname = "CÃ´te d'Ivoire" if countrycode == "CIV"
replace countryname = "Democratic Republic of the Congo" if countrycode == "COD"
replace countryname = "Gambia" if countrycode == "GMB"

drop countrycode TimeCode
sort countryname time

gen prev_anemia_child = real(Prevalenceofanemiaamongchild)
drop Prevalenceofanemiaamongchild
gen prev_anemia_women = real(Prevalenceofanemiaamongwomen)
drop Prevalenceofanemiaamongwomen
gen tariff = real(Tariffrateappliedsimplemea)
drop Tariffrateappliedsimplemea
gen education_exp = real(Governmentexpenditureoneducat)
drop Governmentexpenditureoneducat
gen percent_primary = real(Educationalattainmentatleast)
drop Educationalattainmentatleast
gen savings = real(GrossdomesticsavingsofGDP)
drop GrossdomesticsavingsofGDP

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Control_add.dta", replace

merge 1:m countryname time using "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta"

drop if _merge == 1

drop _merge

sort countryname time counterpartcountryname

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta", replace

drop imports


use "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\imports.dta", clear

rename country_name countryname
rename counterpart counterpartcountryname

replace countryname = "Sao Tome and Principe" if countrycode == 716
replace countryname = "Congo" if countrycode == 634
replace countryname = "CÃ´te d'Ivoire" if countrycode == 662
replace countryname = "Democratic Republic of the Congo" if countrycode == 636
replace countryname = "Gambia" if countrycode == 648



sort countryname counterpartcountryname 
drop time
by countryname counterpartcountryname: gen time = _n

merge 1:1 countryname time counterpartcountryname using "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta"

drop if time == 18
drop if counterpartcountryname == ""

drop _merge

destring imports, replace

drop counterpart_code

sort countryname counterpartcountryname time
egen group_1 = group(countryname)
egen group_2 = group(counterpartcountryname)

tostring group_1, replace
tostring group_2, replace

gen id_string = group_1 + "_" + group_2
encode id_string, gen(id)

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta", replace

import excel "C:\Users\mariu\Documents\Master_Thesis\Other_diseases.xlsx", sheet("Data") firstrow clear

drop if CountryName == ""
drop YearCode
rename L diarrhea_treatment

replace CountryName = "Congo" if CountryCode == "COG"
replace CountryName = "CÃ´te d'Ivoire" if CountryCode == "CIV"
replace CountryName = "Democratic Republic of the Congo" if CountryCode == "COD"
replace CountryName = "Gambia" if CountryCode == "GMB"

destring Year, replace
encode PrevalenceofHIVtotalofp, gen(prev_HIV)
drop PrevalenceofHIVtotalofp
encode Incidenceoftuberculosisper1, gen(tuberculosis_cases)
drop Incidenceoftuberculosisper1
encode Incidenceofmalariaper1000, gen(malaria_p1000)
drop Incidenceofmalariaper1000
encode MalariacasesreportedSHSTAM, gen(malaria_cases)
drop MalariacasesreportedSHSTAM
drop Diabetesprevalenceofpopula
encode Diarrheatreatmentofchildre, gen(diarrhea_treat)
drop Diarrheatreatmentofchildre
encode MortalityfromCVDcancerdiab, gen(CVD_cancer_diab)
drop MortalityfromCVDcancerdiab
encode diarrhea_treatment, gen(diarrhea_treat_percent)
drop diarrhea_treatment

rename CountryName countryname
rename Year year
sort countryname year
by countryname: gen time = _n
merge 1:m countryname time using "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta"

********************************************************************************
**************************** Conflict data *************************************
********************************************************************************

import delimited C:\Users\mariu\Downloads\2000-01-01-2017-12-31-Eastern_Africa-Middle_Africa-Southern_Africa-Western_Africa.csv, clear

keep country year event_type sub_event_type fatalities

drop if country == "South Africa"
drop if country == "Botswana"
drop if country == "Djibouti"
drop if country == "eSwatini"

sort country year event_type sub_event_type fatalities

foreach i in "Battles" "Explosions" "Protests" "Strategic" "Violence" "Riots"{
	gen id_`i' = 1 if strpos(event_type,"`i'")!= 0
	recode id_`i' .=0
}

foreach i in "Armed" "Government" "Non" "landmine" "Arrests" "artillery" "Peaceful" "intervention" ///
"demonstration" "Mob" "Agreement" "Change" "Headquarters" "Excessive" "Other" "Disrupted" "Looting" ///
"Violent" "transfer" "Abduction" "Attack" "Sexual"{
	gen sub_id_`i' = 1 if strpos(sub_event_type,"`i'")!= 0
	recode sub_id_`i' .=0
}

collapse (sum) fatalities *id_*, by(country year event_type sub_event_type)
collapse (sum) fatalities *id_*, by(country year)

drop if year == 2017
drop if country == "Namibia"

sort country year

replace country = "CÃ´te d'Ivoire" if strpos(country, "Ivory Coast") != 0
replace country = "Congo" if strpos(country, "Republic of Congo") != 0 & strpos(country, "Democratic") == 0

drop sub_id_*

rename country countryname

merge 1:m countryname year using "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta"

drop _merge

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta", replace


********************************************************************************
***************************** Event Study **************************************
********************************************************************************

gen post_avg_1 = avg[_n-1]
gen post_avg_2 = avg[_n-2]
gen post_avg_3 = avg[_n-3]
gen log_adult_mort = log(adult_mort_adjust)
gen log_ebola_articles = log(ebola_articles)
recode log_ebola_articles .=0
sort countryname time


*** a variable containing prev new cases
by id: gen prev_ebola_new_cases = prev_ebola_cases - prev_ebola_cases[_n-1]
recode prev_ebola_new_cases .=0 

egen new_avg = mean(prev_ebola_new_cases) if time == 15 & prev_ebola_new_cases != 0, by(countryname)
recode new_avg .=0

gen new_post_avg_1 = new_avg[_n-1]
gen new_post_avg_2 = new_avg[_n-2]
gen new_post_avg_3 = new_avg[_n-3]
gen new_pre_avg_1 = new_avg[_n+1]
gen new_pre_avg_2 = new_avg[_n+2]
gen new_pre_avg_3 = new_avg[_n+3]
gen new_pre_avg_4 = new_avg[_n+4]
gen new_pre_avg_5 = new_avg[_n+5]
gen new_pre_avg_6 = new_avg[_n+6]
gen new_pre_avg_7 = new_avg[_n+7] // Starting here things become an issue!
gen new_pre_avg_8 = new_avg[_n+8]
gen new_pre_avg_9 = new_avg[_n+9]
gen new_pre_avg_10 = new_avg[_n+10]
gen new_pre_avg_11 = new_avg[_n+11] // Dropped b/c of collinearity
gen new_pre_avg_12 = new_avg[_n+12] // --"--
gen new_pre_avg_13 = new_avg[_n+13]


by id: gen percent_exports = exports / gdp
by id: gen percent_imports = imports / gdp
by id: gen percent_trade_balance = trade_balance / gdp

gen exports_mil = exports / 1000000
gen imports_mil = imports / 1000000
gen trade_balance_mil = trade_balance / 1000000
gen net_fdi_mil = net_fdi / 1000000

xtset id time

xtreg log_adult_mort pre_avg_13 pre_avg_12 pre_avg_11 pre_avg_10 pre_avg_9 pre_avg_8 pre_avg_7 pre_avg_6 ///
pre_avg_5 pre_avg_4 pre_avg_3 pre_avg_2 avg post_avg_1 post_avg_2 time, fe vce(cluster countryname)
est store Event_Study

xtreg log_adult_mort new_pre_avg_10 ///
new_pre_avg_9 new_pre_avg_8 new_pre_avg_7 new_pre_avg_6 new_pre_avg_5 new_pre_avg_4 ///
new_pre_avg_3 new_pre_avg_2 new_pre_avg_1 new_avg new_post_avg_1 new_post_avg_2 ///
time, fe vce(cluster countryname)
est store Event_Study

outreg2 [Event_Study] using "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Event_results", ///
tex(pretty) ctitle("Event Study") lab(proper) nocons seeout replace

coefplot (Event_Study), xline(0) horizontal drop(_cons time) xtitle(Coefficient) ytitle(Years to outbreak) title(Event Study) legend(off) replace


********************************************************************************
***************** All in all, the event study seems fine ***********************
********************************************************************************
********************************************************************************
**************************** Summarize data ************************************
********************************************************************************

sutex adult_mort_adjust life_both infant_mort, lab nobs minmax key(descstat) file(HealthMeasures.tex) title("Main_Health_Measures") replace

sutex ebola_cases ebola_deaths ebola_articles, lab nobs minmax key(descstat) file(EbolaMeasures.tex) title("Ebola_Measures") replace

sutex percent_imports percent_exports percent_trade_balance, lab nobs minmax key(descstat) replace ///
file(SummaryOutput.tex) title("Health_Measures")

sutex percent_internet percent_migrants pop_dens_sq_km percent_rural percent_urban health_exp net_fdi_mil price_index ///
tariff education_exp percent_primary savings percent_curr_acc real_ex_rate gdp_p_c fatalitites ///
adult_mort_adjust_male adult_mort_adjust_female life_m life_f neonatal_mort under_5_mort ///
crude_death prev_anemia_child prev_anemia_women, lab nobs minmax key(descstat) replace file(SummaryControl.tex) title("Summary_other_variables")

save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta", replace


********************************************************************************
************************** Baseline regression *********************************
********************************************************************************

xtset id time
gen log_ebola_articles = log(ebola_articles)
recode log_ebola_articles .=0 // log(0) not defined

*** a) 
xtreg log_adult_mort prev_ebola_new_cases time, fe vce(cluster countryname)
est store Baseline_1

*** b)
xtreg log_adult_mort log_ebola_articles time, fe vce(cluster countryname)
est store Baseline_2

outreg2 [Baseline_1 Baseline_2] using "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Baseline_results", ///
tex(pretty) ctitle("Baseline") addtext(State and year FE, Yes) adds(F-test, e(F)) lab(proper) nocons seeout replace


// Plus control variables

gen log_fatalities = log(fatalities)
gen log_gdp_p_c = log(gdp_p_c)
gen log_health = log(health_exp)
gen log_educ = log(education_exp)
gen log_anemia = log(prev_anemia_child)

*** a) - Only "environmental" variables
xtreg log_adult_mort log_ebola_articles percent_urban log_health percent_internet ///
log_gdp_p_c gdp_p_c_growth log_fatalities time, fe vce(cluster countryname)
est store Control_1

xtreg log_adult_mort prev_ebola_new_cases percent_urban log_health percent_internet ///
log_gdp_p_c gdp_p_c_growth log_fatalities time, fe vce(cluster countryname)
est store Control_2

*** b) - Add confounding diseases
xtreg log_adult_mort log_ebola_articles percent_urban log_health percent_internet ///
log_gdp_p_c gdp_p_c_growth log_fatalities time prev_HIV tuberculosis_cases log_anemia ///
malaria_p1000, fe vce(cluster countryname)
est store Control_3

xtreg log_adult_mort prev_ebola_new_cases percent_urban log_health percent_internet ///
log_gdp_p_c gdp_p_c_growth log_fatalities time prev_HIV tuberculosis_cases log_anemia ///
malaria_p1000, fe vce(cluster countryname)
est store Control_4

*** c) - Add more controls w/ cost of losing observations
xtreg log_adult_mort log_ebola_articles percent_urban log_health percent_internet ///
log_gdp_p_c gdp_p_c_growth log_fatalities time prev_HIV tuberculosis_cases log_anemia ///
malaria_p1000 CVD_cancer_diab diarrhea_treat_percent, fe vce(cluster countryname)
est store Control_5

xtreg log_adult_mort prev_ebola_new_cases percent_urban log_health percent_internet ///
log_gdp_p_c gdp_p_c_growth log_fatalities time prev_HIV tuberculosis_cases log_anemia ///
malaria_p1000 CVD_cancer_diab diarrhea_treat_percent, fe vce(cluster countryname)
est store Control_6

outreg2 [Control_2 Control_1 Control_4 Control_3 Control_6 Control_5] using "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Control_results", ///
tex(pretty) ctitle("Control") addtext(State and year FE, Yes) adds(F-test, e(F)) lab(proper) nocons seeout replace


********************************************************************************
**************************** Impulse response function *************************
********************************************************************************

*** a) - w/out controls and prev_ebola_cases

use "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta", replace

rename log_adult_mort log_mort_1
gen log_mort_2 = log_mort_1[_n-1]
gen log_mort_3 = log_mort_1[_n-2]

** I)
foreach i in 1 2 3{
	qui: xtreg log_mort_`i' prev_ebola_new_cases time, fe vce(cluster countryname)
	parmest, label list(parm label estimate min* max* p) saving(results_`i', replace)
}
append using results_1 results_2 results_3
keep if parm == "prev_ebola_new_cases"
save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\IRF.dta", replace
encode parm, generate(parm2)
drop parm
rename parm2 parm
gen time_irf = _n
label variable estimate "regression coefficient"
gen estimate_2 = (estimate / 97.159538)
label variable min95 "lower 95% CI "
gen min95_2 = (min95 / 97.159538)
label variable max95 " upper 95% CI"
gen max95_2 = (max95 / 97.159538)

twoway (line estimate_2 time_irf, mcolor(red) msymbol(square) msize(small)) ///
(rcap min95_2 max95_2 time_irf, lcolor(black)) , ///
xlabel(, valuelabels angle(0) labsize(vsmall)) xtitle("")

graph export "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Pics_graphs\IRF_no_controls_prev_cases.png", as(png) replace

** II)
foreach i in 1 2 3{
	qui: xtreg log_mort_`i' log_ebola_articles time, fe vce(cluster countryname)
	parmest, label list(parm label estimate min* max* p) saving(results_`i', replace)
}
append using results_1 results_2 results_3
keep if parm == "log_ebola_articles"
save "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\IRF_2.dta", replace
encode parm, generate(parm2)
drop parm
rename parm2 parm
gen time_irf = _n
label variable estimate "regression coefficient"
gen estimate_2 = (estimate / 97.159538)
label variable min95 "lower 95% CI "
gen min95_2 = (min95 / 97.159538)
label variable max95 " upper 95% CI"
gen max95_2 = (max95 / 97.159538)

twoway (line estimate_2 time_irf, mcolor(red) msymbol(square) msize(small)) ///
(rcap min95_2 max95_2 time_irf, lcolor(black)) , ///
xlabel(, valuelabels angle(0) labsize(vsmall)) xtitle("")

graph export "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Pics_graphs\IRF_no_controls_ebola_articles.png", as(png) replace



********************************************************************************
************************** Wild clustered bootstrapping ************************
********************************************************************************
************** Unrestricted should overreject -> p-value too small *************
************** Restrcited should underreject -> p-value too large **************
********************************************************************************
******* Follow MacKinnon and Webb (2018) -> Do both on a sub-cluster level *****
********************************************************************************

use "C:\Users\mariu\Documents\Master_Thesis\Master_thesis\Trade_merged.dta", replace

rename log_mort_1 log_adult_mort
set seed 12345

** a)
xtreg log_adult_mort prev_ebola_new_cases time, fe vce(cluster countryname)
boottest prev_ebola_new_cases, reps(999) // Unrestricted
boottest prev_ebola_new_cases, reps(999) nonull // Restricted
boottest prev_ebola_new_cases, reps(999) bootcluster(id)
boottest prev_ebola_new_cases, reps(999) nonull bootcluster(id)

** b)
xtreg log_adult_mort log_ebola_articles time, fe vce(cluster countryname)
boottest log_ebola_articles, reps(999)
boottest log_ebola_articles, reps(999) nonull
boottest log_ebola_articles, reps(999) bootcluster(id)
boottest log_ebola_articles, reps(999) nonull bootcluster(id)
