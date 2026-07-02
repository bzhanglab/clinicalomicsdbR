# clinicalomicsdbR object

clinicalomicsdbR object

clinicalomicsdbR object

## Value

Returns a new clinicalomicsdbR object

## Public fields

- `hostname`:

  The url of the API to connect to. Only change if you are using a
  custom service.

- `study_list`:

  The list of all the studies that are a result of filtering.

- `verbosity`:

  The level of messages wanted for downloads (defaults to 0: No Output).
  Follows httr2 documentatation for `req_perform`

## Methods

### Public methods

- [`clinicalomicsdbR$filter()`](#method-clinicalomicsdbR-filter)

- [`clinicalomicsdbR$get_download_url()`](#method-clinicalomicsdbR-get_download_url)

- [`clinicalomicsdbR$download()`](#method-clinicalomicsdbR-download)

- [`clinicalomicsdbR$download_from_id()`](#method-clinicalomicsdbR-download_from_id)

- [`clinicalomicsdbR$dataframe()`](#method-clinicalomicsdbR-dataframe)

- [`clinicalomicsdbR$dataframe_from_id()`](#method-clinicalomicsdbR-dataframe_from_id)

- [`clinicalomicsdbR$clone()`](#method-clinicalomicsdbR-clone)

------------------------------------------------------------------------

### Method [`filter()`](https://rdrr.io/r/stats/filter.html)

filter objects according to the specified drugs and cancers

#### Usage

    clinicalomicsdbR$filter(drugs = c(), cancers = c())

#### Arguments

- `drugs`:

  list or vector containing drugs that studies need to contain at least
  one of

- `cancers`:

  list of vector of cancer types to consider. Leave empty to consider
  all cancer types

#### Returns

new clinicalomicsdbR object with the filtered results in `$study_list`

------------------------------------------------------------------------

### Method `get_download_url()`

Get download url for a study at specified `study_id`

#### Usage

    clinicalomicsdbR$get_download_url(study_id)

#### Arguments

- `study_id`:

  String of the ID of the study to get the download url of

#### Returns

String of the download url

------------------------------------------------------------------------

### Method `download()`

Download all files of the studies in `self$study_list`. Use `filter`
function first

#### Usage

    clinicalomicsdbR$download(output_dir)

#### Arguments

- `output_dir`:

  Directory to download files to.

#### Returns

unmodifed clinicalomicsdbR object

------------------------------------------------------------------------

### Method `download_from_id()`

Download all file from `study_id` into `output_dir` directory

#### Usage

    clinicalomicsdbR$download_from_id(study_id)

#### Arguments

- `study_id`:

  String containing the ID of the study to download

- `output_dir`:

  Directory to download files to.

#### Returns

unmodifed clinicalomicsdbR object

------------------------------------------------------------------------

### Method `dataframe()`

Get all files of the studies in `self$study_list` and load into data
frame. Use `filter` function first.

#### Usage

    clinicalomicsdbR$dataframe()

#### Returns

list with `study_list` element to display all studies and list `df` with
each dataframe in the list

------------------------------------------------------------------------

### Method `dataframe_from_id()`

Get file from `study_id` and convert into dataframe.

#### Usage

    clinicalomicsdbR$dataframe_from_id(study_id)

#### Arguments

- `study_id`:

  String containing the ID of the study to get dataframe of

#### Returns

data frame containing data of study

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    clinicalomicsdbR$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
clinicalomicsdbR$new()$filter(drugs = c("ipilimumab", "rituximab"))$study_list # downloads all files
#> Filtered to 4 studies.
#> [1] "Gide_Cell_2019_pembro_ipi.csv" "VanAllen_antiCTLA4_2015.csv"  
#> [3] "Gide_Cell_2019_nivo_ipi.csv"   "GSE35935.csv"                 
```
