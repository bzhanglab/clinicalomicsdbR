
<!-- README.md is generated from README.Rmd. Please edit that file -->

# clinicalomicsdbR

<!-- badges: start -->
<!-- badges: end -->

R package to interface with the ClinicalOmicsDB API. Designed with the
structure from <https://r-pkgs.org/>.

## Installation

You can install the development version of clinicalomicsdbR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("bzhanglab/clinicalomicsdbR")
```

## Functions

- `new()` - Create new clinicalomicsdbR object. Needed before any other
  function
- `filter(drugs, cancers)` - filters studies matching provided
  arugments. `drugs` is a list and can be individual drugs or
  combinations. See the ClinicalOmicsDB website for all options.
  `cancers` can contain multiple cancers.
- `download(output_dir)` - downloads all studies from `filter()` into
  `output_dir`. `output_dir` is optional, and defaults to `clindb`
- `dataframe()` - loads all the studies from `filter()` into a
  list, with column `study_list` that contains the names of the
  studies and `df` that contains a list of the study data information.

See the examples below for more information on how to use.

## Examples

### Filter and Download

Filters studies for those which used rituximab or ipilimumab then
downloads them to the `studies` folder.

*Notes*: `output_dir` is optional. Defaults to `clindb`.

``` r
library(clinicalomicsdbR)

clinicalomicsdbR$new()$filter(drugs = c("ipilimumab", "rituximab"))$download(output_dir = "studies") # downloads all files
#> [1] "Filtered to 4 studies."
#> [1] "Downloading study Gide_Cell_2019_pembro_ipi.csv from https://bcm.box.com/shared/static/swf5fywqcqmf75600g7v8irt2a9agnqo.csv"
#> [1] "Downloading study VanAllen_antiCTLA4_2015.csv from https://bcm.box.com/shared/static/v0sphd7ht487qk96xbwjokgkbkjpexom.csv"
#> [1] "Downloading study Gide_Cell_2019_nivo_ipi.csv from https://bcm.box.com/shared/static/jwv108f6cy4kvyeqer95jdugla53m1zt.csv"
#> [1] "Downloading study GSE35935.csv from https://bcm.box.com/shared/static/8icr4i6gbbp6lgd01iscbss4v7lnj6c5.csv"
#> [1] "Downloaded 4 studies."
```

### Filter and Get Data Frame

Filters studies for those which used rituximab or ipilimumab then gets
data frame.

*Notes*: `output_dir` is optional. Defaults to `clindb`.

``` r
library(clinicalomicsdbR)

res <- clinicalomicsdbR$new()$filter(drugs = c("ipilimumab", "rituximab"))$dataframe(); # downloads all files
#> [1] "Filtered to 4 studies."
#> [1] "Getting dataframe of study Gide_Cell_2019_pembro_ipi.csv from https://bcm.box.com/shared/static/swf5fywqcqmf75600g7v8irt2a9agnqo.csv"
#> [1] "Getting dataframe of study VanAllen_antiCTLA4_2015.csv from https://bcm.box.com/shared/static/v0sphd7ht487qk96xbwjokgkbkjpexom.csv"
#> [1] "Getting dataframe of study Gide_Cell_2019_nivo_ipi.csv from https://bcm.box.com/shared/static/jwv108f6cy4kvyeqer95jdugla53m1zt.csv"
#> [1] "Getting dataframe of study GSE35935.csv from https://bcm.box.com/shared/static/8icr4i6gbbp6lgd01iscbss4v7lnj6c5.csv"

for (study in res[["study_list"]]) {
  print(ncol(res[["df"]][[study]]))
}
#> [1] 15194
#> [1] 15059
#> [1] 17145
#> [1] 20321
```

<!-- ```{r example} -->
<!-- library(clinicalomicsdbR) -->
<!-- ## basic filtering -->
<!-- clinicalomicsdbR$new()$filter(drugs=c("paclitaxel"))$study_list[[1]] -->
<!-- ``` -->
