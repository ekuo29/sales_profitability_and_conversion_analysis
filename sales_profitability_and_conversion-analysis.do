clear all
set more off

* Sales Profitability and Conversion Analysis
* MFin 604 | Group 4
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

* Construct the monetary measures used throughout the analysis.
gen double ProfitValueinMillion = (Profit / 100) * SalesValueinMillion
gen double MarketingExpenseinMillion = 0.06 * SalesValueinMillion
label variable ProfitValueinMillion "Profit value (USD millions)"
label variable MarketingExpenseinMillion "Marketing expense proxy (USD millions)"


* -----------------------------------------------------------------------------
* 1. Product profitability and conversion
* -----------------------------------------------------------------------------

tabstat ProfitValueinMillion if SalesOutcome == 1, by(Product) ///
    statistics(sum mean median sd min max count) ///
    columns(statistics) format(%9.2f)

preserve
collapse (count) opportunities=SalesOutcome ///
    (sum) wins=SalesOutcome ///
    (mean) conversion=SalesOutcome, by(Product)
gsort -wins
list Product opportunities wins conversion, noobs sep(0)
restore


* -----------------------------------------------------------------------------
* 2. Won-deal profit by region and product
* -----------------------------------------------------------------------------

preserve
keep if SalesOutcome == 1
collapse (sum) ProfitValueinMillion, by(Region Product)
separate ProfitValueinMillion, by(Product) veryshortlabel
local yvars `r(varlist)'
drop ProfitValueinMillion

levelsof Product, local(product_list)
local i = 1
local legend_spec
foreach product of local product_list {
    local legend_spec `legend_spec' label(`i' "`product'")
    local ++i
}

graph bar `yvars', over(Region, label(angle(45))) stack ///
    ytitle("Won-deal profit value (USD millions)") ///
    title("Won-Deal Profit Value by Region and Product") ///
    ylabel(, format(%9.0fc) grid) ///
    legend(rows(2) position(6) region(lstyle(none)) `legend_spec') ///
    graphregion(color(white)) plotregion(margin(small))
restore


* -----------------------------------------------------------------------------
* 3. Regional scale, profitability, and conversion
* -----------------------------------------------------------------------------

misstable summarize

tabstat SalesValueinMillion, by(Region) ///
    statistics(mean median sd min max count) ///
    columns(statistics) format(%9.2f)

tabstat ProfitValueinMillion, by(Region) ///
    statistics(mean median sd min max count) ///
    columns(statistics) format(%9.2f)

tabstat SalesValueinMillion if SalesOutcome == 1, by(Region) ///
    statistics(mean median sd min max count) ///
    columns(statistics) format(%9.2f)

tabstat ProfitValueinMillion if SalesOutcome == 1, by(Region) ///
    statistics(sum mean median sd min max count) ///
    columns(statistics) format(%9.2f)

tabstat SalesOutcome, by(Region) statistics(mean count) ///
    columns(statistics) format(%9.3f)

graph bar (mean) SalesOutcome, over(Region, label(angle(45))) ///
    title("Observed Conversion Rate by Region") ///
    ytitle("Conversion rate") ///
    blabel(bar, format(%4.2f)) ///
    graphregion(color(white))


* -----------------------------------------------------------------------------
* 4. Customer profitability and deal value
* -----------------------------------------------------------------------------

summarize ProfitofCustomerinMillion SalesValueinMillion
pwcorr ProfitofCustomerinMillion SalesValueinMillion, sig

twoway ///
    (scatter SalesValueinMillion ProfitofCustomerinMillion) ///
    (lfit SalesValueinMillion ProfitofCustomerinMillion), ///
    xtitle("Customer profit (millions)") ///
    ytitle("Sales value (USD millions)") ///
    title("Customer Profit versus Deal Value") ///
    legend(off) graphregion(color(white))


* -----------------------------------------------------------------------------
* 5. India versus UK mean comparisons
* -----------------------------------------------------------------------------

ttest SalesValueinMillion if inlist(Region, "India", "UK"), ///
    by(Region) unequal

ttest Profit if inlist(Region, "India", "UK") & SalesOutcome == 1, ///
    by(Region) unequal

ttest ProfitofCustomerinMillion if inlist(Region, "India", "UK"), ///
    by(Region) unequal

ttest SalesOutcome if inlist(Region, "India", "UK"), ///
    by(Region) unequal


* -----------------------------------------------------------------------------
* 6. Region and product hypothesis tests
* -----------------------------------------------------------------------------

tabulate Region SalesOutcome, chi2
oneway SalesValueinMillion Region, tabulate
tabulate Product SalesOutcome, chi2

preserve
collapse (mean) conversion=SalesOutcome ///
    sales_value=SalesValueinMillion ///
    (count) opportunities=SalesOutcome, by(Region)
gsort -opportunities
list Region opportunities conversion sales_value, noobs sep(0)
restore

preserve
gen strL product_region = Product + "_" + Region
collapse (sum) wins=SalesOutcome (count) total=SalesOutcome, by(product_region)
gen double conversion = wins / total
list product_region wins total conversion, noobs sep(0)
restore


* -----------------------------------------------------------------------------
* 7. Majority WSES ownership and conversion
* -----------------------------------------------------------------------------

gen byte wses_majority = WSESProportioninJointBid > 50
label define majority_label 0 "WSES <= 50%" 1 "WSES > 50%"
label values wses_majority majority_label
prtest SalesOutcome, by(wses_majority)


* -----------------------------------------------------------------------------
* 8. Sales-confidence class and observed outcome
* -----------------------------------------------------------------------------

gen byte high_confidence = inlist(LeadsConversionClass, "E", "V")
label define confidence_label 0 "F/L class" 1 "E/V class"
label values high_confidence confidence_label
tabulate high_confidence SalesOutcome, chi2 row


* -----------------------------------------------------------------------------
* 9. Marketing-expense proxy and won-deal profitability
* -----------------------------------------------------------------------------

pwcorr MarketingExpenseinMillion ProfitValueinMillion ///
    if SalesOutcome == 1, sig

twoway ///
    (scatter ProfitValueinMillion MarketingExpenseinMillion ///
        if SalesOutcome == 1) ///
    (lfit ProfitValueinMillion MarketingExpenseinMillion ///
        if SalesOutcome == 1), ///
    xtitle("Marketing expense proxy (USD millions)") ///
    ytitle("Won-deal profit value (USD millions)") ///
    title("Marketing Proxy versus Won-Deal Profit") ///
    legend(off) graphregion(color(white))

display as text "Caution: both measures contain SalesValueinMillion; " ///
    "the correlation is partly mechanical and does not estimate causal ROI."
