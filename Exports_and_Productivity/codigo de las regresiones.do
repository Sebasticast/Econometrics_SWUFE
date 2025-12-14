clear all
* Clears all data, stored results, and value labels from memory

use data.dta, replace
* Loads the dataset "data.dta" into memory
* "replace" allows overwriting any dataset currently in memory

*/drop Employed Gross_fixed_capital_formation Exports exp_diff xr ln_xr d_ln_xr exrate in_Country_Code in_emplo in_exrate in_GDP_growth in_exports pre_inexp ln_inv ln_in_exports CountryorArea Item value_added
* Commented-out line (not executed)
* Would drop the listed variables if uncommented

encode Country_Code, gen(Country_Code_num)
* Converts the string variable Country_Code into a numeric variable
* Creates Country_Code_num with value labels

xtset Country_Code_num Year
* Declares the data as panel data
* Panel identifier: Country_Code_num
* Time variable: Year

bysort Country_Code: summarize
* Sorts data by Country_Code and produces summary statistics
* Useful for checking within-country distributions

quietly xtreg lab_prod ln_exports human_capital LBExp reas_and_develop capital_to_labor GDP_growth, fe
* Estimates a fixed-effects (within) panel regression
* Dependent variable: lab_prod
* Suppresses output with "quietly"

estimates store FE
* Stores the fixed-effects model results as "FE"

quietly xtreg lab_prod ln_exports human_capital LBExp reas_and_develop capital_to_labor GDP_growth, re
* Estimates a random-effects panel regression
* Output suppressed

estimates store RE
* Stores the random-effects model results as "RE"

hausman FE RE, constant sigmamore
* Performs Hausman test to compare FE vs RE
* Tests whether RE estimates are consistent
* "sigmamore" adjusts the covariance matrix
* "constant" includes the constant term in the test

xtreg lab_prod ln_exports human_capital LBExp reas_and_develop capital_to_labor GDP_growth, re
* Re-estimates the random-effects model (for diagnostics)

xttest0
* Breusch–Pagan Lagrange Multiplier test
* Tests whether random effects are present
* H0: No panel effect (pooled OLS preferred)

xtreg lab_prod ln_exports human_capital LBExp reas_and_develop capital_to_labor GDP_growth, re r
* Random-effects regression with robust standard errors
* "r" makes standard errors robust to heteroskedasticity




