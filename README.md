
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

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(clinicalomicsdbR)
## basic filtering

clinicalomicsdbR$new()$filter(drugs=c("paclitaxel"))$study_list[[1]]
#> $study_list
#> $study_list[[1]]
#> [1] "GSE164458_paclitaxel.csv"
#> 
#> $study_list[[2]]
#> [1] "GSE66305_lapatinib.csv"
#> 
#> $study_list[[3]]
#> [1] "GSE66305_trastuzumab_lapatinib.csv"
#> 
#> $study_list[[4]]
#> [1] "GSE66305_trastuzumab.csv"
#> 
#> $study_list[[5]]
#> [1] "GSE164458_carboplatin_paclitaxel.csv"
#> 
#> $study_list[[6]]
#> [1] "GSE194040_Paclitaxel_Ganitumab.csv"
#> 
#> $study_list[[7]]
#> [1] "GSE25065.csv"
#> 
#> $study_list[[8]]
#> [1] "GSE194040_Paclitaxel_Pembrolizumab.csv"
#> 
#> $study_list[[9]]
#> [1] "GSE25055.csv"
#> 
#> $study_list[[10]]
#> [1] "GSE194040_Paclitaxel_AMG386_Trastuzumab.csv"
#> 
#> $study_list[[11]]
#> [1] "GSE194040_Paclitaxel_Trastuzumab.csv"
#> 
#> $study_list[[12]]
#> [1] "GSE194040_Paclitaxel_Neratinib.csv"
#> 
#> $study_list[[13]]
#> [1] "GSE194040_Paclitaxel_ABT888_carboplatin.csv"
#> 
#> $study_list[[14]]
#> [1] "GSE164458_veliparib_carboplatin_paclitaxel.csv"
#> 
#> $study_list[[15]]
#> [1] "GSE194040_Paclitaxel_MK_2206.csv"
#> 
#> $study_list[[16]]
#> [1] "GSE194040_T_DM1_Pertuzumab.csv"
#> 
#> $study_list[[17]]
#> [1] "GSE20194.csv"
#> 
#> $study_list[[18]]
#> [1] "GSE25066.csv"
#> 
#> $study_list[[19]]
#> [1] "GSE41998_Paclitaxel.csv"
#> 
#> $study_list[[20]]
#> [1] "GSE194040_Paclitaxel_Pertuzumab_Trastuzumab.csv"
#> 
#> $study_list[[21]]
#> [1] "GSE194040_Paclitaxel_Ganetespib.csv"
#> 
#> $study_list[[22]]
#> [1] "GSE194040_Paclitaxel_AMG386.csv"
#> 
#> $study_list[[23]]
#> [1] "GSE194040_Paclitaxel.csv"
#> 
#> $study_list[[24]]
#> [1] "GSE194040_Paclitaxel_MK_2206_Trastuzumab.csv"
#> 
#> 
#> $possible_cancers
#> $possible_cancers[[1]]
#> [1] "Esophageal_adv"
#> 
#> $possible_cancers[[2]]
#> [1] "Breast"
#> 
#> $possible_cancers[[3]]
#> [1] "Ovarian"
#> 
#> 
#> $is_ok
#> [1] TRUE
#> 
#> $length
#> [1] 24
#> [1] "GSE164458_paclitaxel.csv"
```
