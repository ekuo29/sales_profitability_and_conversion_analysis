clear all

* Sales and Marketing Analysis
*
* The licensed source workbook is not included in this repository.
* Save an authorized local copy beside this file as WSES-sales-leads.xlsx.

local data_file "WSES-sales-leads.xlsx"
capture confirm file "`data_file'"
if _rc {
    display as error "Data file not found: `data_file'"
    display as error "See README.md for setup instructions."
    exit 601
}

import excel using "`data_file'", ///
    sheet("Sample Data on Past Sales Leads") firstrow clear


* ==============================
*Question 1
* ==============================

*Generate Profit Dollar Amount
gen ProfitValueinMillion = (Profit/100) * SalesValueinMillion

* Summary Stats by Sales
tabstat ProfitValueinMillion if SalesOutcome == 1, by(Product) ///
 stat(sum mean median sd min max count) columns(statistics) format(%9.2f)


* ==============================
*Question 2
* ==============================

preserve
keep if SalesOutcome == 1

collapse (sum) ProfitValueinMillion, by(Region Product)

separate ProfitValueinMillion, by(Product) veryshortlabel
local yvars `r(varlist)'
drop ProfitValueinMillion

levelsof Product, local(plist)
local i = 1
local legspec
foreach p of local plist {
    local legspec `legspec' label(`i' "`p'")
    local ++i
}

graph bar `yvars', over(Region, label(angle(45))) stack ///
    ytitle("Total Profit (Value in Million)", margin(0 10 0 0)) ///
    title("Total Profit by Market and Product") ///
    ylabel(, format(%9.0fc) grid) ///
    legend(rows(2) position(6) region(lstyle(none)) `legspec') ///
    graphregion(color(white)) plotregion(margin(small))
restore


* ==============================
*Question 3
* ==============================
misstable summarize

* Summary Stats by Sales
tabstat SalesValueinMillion, by(Region) stat(mean median sd min max count) ///
columns(statistics) format(%9.2f)

* Summary Stats by Profit
tabstat ProfitValueinMillion, by(Region) stat(mean median sd min max count) ///
columns(statistics) format(%9.2f)

* Summary Stats by Sales, only successful deal included
tabstat SalesValueinMillion if SalesOutcome == 1, by(Region) ///
    stat(mean median sd min max count) columns(statistics) format(%9.2f)

* Summary Stats by Profit, only successful deal included
tabstat ProfitValueinMillion if SalesOutcome == 1, by(Region) ///
stat(mean median sd min max count) columns(statistics) format(%9.2f)

* ==============================
* Question 4
* ==============================

* Sales Outcome by each Region
tabstat SalesOutcome, by(Region) stat(mean count) ///
columns(statistics) format(%9.2f)


graph bar (mean) SalesOutcome, over(Region, label(angle(45))) ///
    title("Probability of Conversion by Market") ///
    ytitle("Conversion Rate") ///
    blabel(bar, format(%4.2f))

*graph export "MFin604 Case 1 Conversion Probability.png", replace


* ==============================
* Question 5: Scatter Plot
* ==============================

* Summary Statistics for Profit of Customer
summarize ProfitofCustomer SalesValue

* Scatterplot of SalesValue (y-axis) against ProfitofCustomer (x-axis)
twoway (scatter SalesValue ProfitofCustomer), ///
xtitle("Customer profit(millions)") ytitle("Deal sales value(USD)")

* Pairwise Correlation between SalesValue and ProfitofCustomer
pwcorr SalesValue ProfitofCustomer, sig


* ==============================
* Question 6: India vs UK analysis
* ==============================

* Compare SalesValue between India and UK
ttest SalesValue if inlist(Region, "India", "UK"), by(Region) unequal

* Compare For successful deals only
ttest Profit if inlist(Region, "India", "UK") & SalesOutcome == 1, by(Region) unequal

* Compare ProfitofCustomer between India and UK
ttest ProfitofCustomer if inlist(Region, "India", "UK"), by(Region) unequal

* Compare SalesOutcome between India and UK
ttest SalesOutcome if inlist(Region, "India", "UK"), by(Region) unequal

* ==============================
* Question 7: India vs UK analysis
* ==============================

* Appendix 7.1 - Chi-square Test of Sales Outcome by Region
tabulate Region SalesOutcome, chi2

* Appendix 7.2 - ANOVA Test of Sales Value across Regions
oneway SalesValueinMillion Region, tabulate

* Appendix 7.3 - Summary of Sales Conversion, Value, and Sample Size by Region
preserve
collapse (mean) Conversion = SalesOutcome SalesValue (count) N = SalesOutcome, by(Region)
gsort -Conversion
list Region Conversion SalesValue N, noobs
restore

* Appendix 7.4 - Chi-square Test of Independence between Product and Sales Outcome
tabulate Product SalesOutcome, chi2

* Appendix 7.5 - Win Rates by Product and Region
preserve
gen strL prod_region = Product + "_" + Region
collapse (sum) wins=SalesOutcome (count) total=SalesOutcome, by(prod_region)
gen winrate = wins/total
list prod_region wins total winrate, sep(0)
restore

* Appendix 8.1 - Z-test of conversion rate
gen wses_gt50 = WSESProportioninJointBid > 50
label define gt50 0 "WSES <= 50%" 1 "WSES > 50%"
label values wses_gt50 gt50
set linesize 120
prtest SalesOutcome, by(wses_gt50)
