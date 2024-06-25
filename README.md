
<!-- README.md is generated from README.Rmd. Please edit that file -->

# clinicalomicsdbR

<!-- badges: start -->

[![Zenodo](https://zenodo.org/badge/DOI/10.5281/zenodo.8239443.svg)](https://doi.org/10.5281/zenodo.8239443)
<!-- badges: end -->

R package to interface with the ClinicalOmicsDB API. Can be used to
download data for your own analysis, or directly load study information
into a dataframe for exploration.

Designed with the structure from <https://r-pkgs.org/>.

## Installation

To install the latest stable release, run

``` r
install.packages("clinicalomicsdbR")
```

You can install the development version of clinicalomicsdbR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("bzhanglab/clinicalomicsdbR")
```

See Examples below to see how to use.

## Parameters

- `hostname` - base URL of the website containing the ClinicalOmicsDB
  API. Only change if you are running a custom service.
- `study_list` - list containing all the studies that were filtered by
  the `filter()` function.

## Functions

- `new()` - Create new clinicalomicsdbR object. Needed before any other
  function
- `filter(drugs, cancers)` - filters studies matching provided
  arguments. `drugs` is a list and can be individual drugs or
  combinations. See the ClinicalOmicsDB website for all options.
  `cancers` can contain multiple cancers.
- `download(output_dir)` - downloads all studies from `filter()` into
  `output_dir`.
- `dataframe()` - loads all the studies from `filter()` into a list,
  with column `study_list` that contains the names of the studies and
  `df` that contains a list of the study data information.
- `dataframe_from_id(study_id)` - loads a study with id from `study_id`
  into a dataframe
- `download_from_id(study_id, output_dir)` - downsloads a study with id
  from `study_id` into a folder `output_dir`. See the examples below for
  more information on how to use.

## Examples

### Filter and Download

Filters studies for those which used rituximab or ipilimumab then
downloads them to the `studies` folder.

``` r
library(clinicalomicsdbR)

clinicalomicsdbR$new()$filter(drugs = c("ipilimumab", "rituximab"))$download(output_dir = tempdir()) # downloads all files
#> Filtered to 4 studies.
#> Downloading study Gide_Cell_2019_pembro_ipi.csv from https://bcm.box.com/shared/static/swf5fywqcqmf75600g7v8irt2a9agnqo.csv
#> Downloading study VanAllen_antiCTLA4_2015.csv from https://bcm.box.com/shared/static/v0sphd7ht487qk96xbwjokgkbkjpexom.csv
#> Downloading study Gide_Cell_2019_nivo_ipi.csv from https://bcm.box.com/shared/static/jwv108f6cy4kvyeqer95jdugla53m1zt.csv
#> Downloading study GSE35935.csv from https://bcm.box.com/shared/static/8icr4i6gbbp6lgd01iscbss4v7lnj6c5.csv
#> Downloaded 4 studies.
```

### Filter and Get Data Frame

Filters studies for those which used rituximab or ipilimumab then gets
data frame.

*Notes*: `output_dir` is optional. Defaults to `clindb`.

``` r
library(clinicalomicsdbR)

res <- clinicalomicsdbR$new()$filter(drugs = c("ipilimumab", "rituximab"))$dataframe(); # downloads all files
#> Filtered to 4 studies.
#> Getting dataframe of study Gide_Cell_2019_pembro_ipi.csv from https://bcm.box.com/shared/static/swf5fywqcqmf75600g7v8irt2a9agnqo.csv
#> Getting dataframe of study VanAllen_antiCTLA4_2015.csv from https://bcm.box.com/shared/static/v0sphd7ht487qk96xbwjokgkbkjpexom.csv
#> Getting dataframe of study Gide_Cell_2019_nivo_ipi.csv from https://bcm.box.com/shared/static/jwv108f6cy4kvyeqer95jdugla53m1zt.csv
#> Getting dataframe of study GSE35935.csv from https://bcm.box.com/shared/static/8icr4i6gbbp6lgd01iscbss4v7lnj6c5.csv
```

``` r

for (study in res[["study_list"]]) {
  print(ncol(res[["df"]][[study]]))
}
#> [1] 15194
#> [1] 15059
#> [1] 17145
#> [1] 20321
```
