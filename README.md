
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
#> [1] "[\"paclitaxel\"]"
#>  [1] "GSE194040_Paclitaxel_AMG386.csv"                
#>  [2] "GSE194040_Paclitaxel_Pertuzumab_Trastuzumab.csv"
#>  [3] "GSE194040_Paclitaxel.csv"                       
#>  [4] "GSE51373.csv"                                   
#>  [5] "GSE164458_carboplatin_paclitaxel.csv"           
#>  [6] "GSE165252.csv"                                  
#>  [7] "GSE194040_Paclitaxel_Pembrolizumab.csv"         
#>  [8] "GSE25065.csv"                                   
#>  [9] "GSE66305_lapatinib.csv"                         
#> [10] "GSE25055.csv"                                   
#> [11] "GSE66305_trastuzumab_lapatinib.csv"             
#> [12] "GSE194040_Paclitaxel_AMG386_Trastuzumab.csv"    
#> [13] "GSE66305_trastuzumab.csv"                       
#> [14] "GSE194040_Paclitaxel_ABT888_carboplatin.csv"    
#> [15] "GSE194040_Paclitaxel_Neratinib.csv"             
#> [16] "GSE194040_Paclitaxel_Trastuzumab.csv"           
#> [17] "GSE164458_veliparib_carboplatin_paclitaxel.csv" 
#> [18] "GSE194040_Paclitaxel_MK_2206.csv"               
#> [19] "GSE194040_T_DM1_Pertuzumab.csv"                 
#> [20] "GSE20194.csv"                                   
#> [21] "GSE25066.csv"                                   
#> [22] "GSE41998_Paclitaxel.csv"                        
#> [23] "GSE194040_Paclitaxel_Ganetespib.csv"            
#> [24] "GSE194040_Paclitaxel_MK_2206_Trastuzumab.csv"   
#> [25] "GSE14764.csv"                                   
#> [26] "GSE164458_paclitaxel.csv"                       
#> [27] "GSE194040_Paclitaxel_Ganitumab.csv"             
#> [1] "Filtered to 27 studies."
#> [1] "GSE194040_Paclitaxel_AMG386.csv"
```
