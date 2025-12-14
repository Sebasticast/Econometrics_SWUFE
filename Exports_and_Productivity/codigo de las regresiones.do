clear all

use data.dta, replace

*/drop Employed Gross_fixed_capital_formation Exports exp_diff xr ln_xr d_ln_xr exrate in_Country_Code in_emplo in_exrate in_GDP_growth in_exports pre_inexp ln_inv ln_in_exports CountryorArea Item value_added

*/NOTE FOR THE TEACHER: TO BUILD THIS BASE I USED MANY OTHER DATABASES, IF YOU NEED ME TO SEND YOU THE OTHER BASES JUST CONTACT ME

encode Country_Code, gen(Country_Code_num)
xtset  Country_Code_num Year

bysort Country_Code: summarize

quietly xtreg lab_prod ln_exports human_capital LBExp reas_and_develop capital_to_labor GDP_growth, fe
estimates store FE
quietly xtreg lab_prod ln_exports human_capital LBExp reas_and_develop capital_to_labor GDP_growth, re
estimates store RE
hausman FE RE, constant sigmamore

xtreg lab_prod ln_exports human_capital LBExp reas_and_develop capital_to_labor GDP_growth, re
xttest0

xtreg lab_prod ln_exports human_capital LBExp reas_and_develop capital_to_labor GDP_growth, re r


