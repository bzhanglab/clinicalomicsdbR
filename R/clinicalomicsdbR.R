#' clinicalomicsdbR object
#' @importFrom httr2 request req_perform req_method req_headers req_body_raw resp_body_json
#' @importFrom R6 R6Class
#' @importFrom utils download.file
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr %>%
#' @return Returns a new clinicalomicsdbR object
#' @examples
#' clinicalomicsdbR$new()$filter(drugs = c("ipilimumab", "rituximab"))$study_list # downloads all files
#' @export
clinicalomicsdbR <- R6Class("clinicalomicsdbR", list(
  #' @field hostname The url of the API to connect to. Only change if you are using a custom service.
  hostname = "https://trials.linkedomics.org",
  #' @field study_list The list of all the studies that are a result of filtering.
  study_list = c(),
  #' @field verbosity The level of messages wanted for downloads (defaults to 0: No Output). Follows httr2 documentatation for `req_perform`
  verbosity = 0,
  #' @description
  #' filter objects according to the specified drugs and cancers
  #' @param drugs list or vector containing drugs that studies need to contain at least one of
  #' @param cancers list of vector of cancer types to consider. Leave empty to consider all cancer types
  #' @return new clinicalomicsdbR object with the filtered results in `$study_list`
  filter = function(drugs = c(), cancers = c()) {
    if (length(drugs) == 0) {
      drug_text <- "[]"
    } else {
      drug_text <- "["
      for (drug in drugs) {
        drug_text <- paste0(drug_text, '"', drug, '",')
      }
      drug_text <- substr(drug_text, 1, nchar(drug_text) - 1)
      drug_text <- paste0(drug_text, "]")
    }
    if (length(cancers) == 0) {
      cancer_text <- "[]"
    } else {
      cancer_text <- "["
      for (cancer in cancers) {
        cancer_text <- paste0(cancer_text, '"', cancer, '",')
      }
      cancer_text <- substr(cancer_text, 1, nchar(cancer_text) - 1)
      cancer_text <- paste0(cancer_text, "]")
    }
    req <- request(paste0(self$hostname, "/api/filter"))
    req <- req %>%
      req_method("POST") %>%
      req_headers(
        "Accept" = "application/json, text/plain",
        "Content-Type" = "application/json;charset=UTF-8"
      ) %>%
      req_body_raw(paste0("
        {
          \"drugs\": ", drug_text, ",
          \"cancers\": ", cancer_text, "
        }
        "))
    resp <- req_perform(req, verbosity = self$verbosity)
    filter_res <- resp %>% resp_body_json()
    self$study_list <- unlist(filter_res$study_list)
    message(paste0("Filtered to ", length(self$study_list), " studies."))
    invisible(self)
  },
  #' @description
  #' Get download url for a study at specified `study_id`
  #' @param study_id String of the ID of the study to get the download url of
  #' @return String of the download url
  get_download_url = function(study_id) {
    req <- request(paste0(self$hostname, "/api/info/", study_id))
    req <- req %>%
      req_method("GET") %>%
      req_headers("Accept" = "application/json, text/plain")
    resp <- req_perform(req, verbosity = self$verbosity)
    resp_json <- resp %>% resp_body_json()
    return(resp_json$download_url)
  },
  #' @description
  #' Download all files of the studies in `self$study_list`. Use `filter` function first
  #' @param output_dir Directory to download files to.
  #' @return unmodifed clinicalomicsdbR object
  download = function(output_dir) {
    dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
    for (study_id in self$study_list) {
      dl_url <- self$get_download_url(study_id)
      message(paste0("Downloading study ", study_id, " from ", dl_url))
      download.file(dl_url, paste0(output_dir, "/", study_id))
    }
    message(paste0("Downloaded ", length(self$study_list), " studies."))
    invisible(self)
  },
  #' @description
  #' Download all file from `study_id` into `output_dir` directory
  #' @param study_id String containing the ID of the study to download
  #' @param output_dir Directory to download files to.
  #' @return unmodifed clinicalomicsdbR object
  download_from_id = function(study_id) {
    dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
    dl_url <- self$get_download_url(study_id)
    tryCatch(
      {
        message(paste0("Downloading study ", study_id, " from ", dl_url))
        download.file(dl_url, paste0(output_dir, "/", study_id))
        message("Done downloading study.")
        invisible(self)
      },
      error = function(err) {
        message(paste0("Error fetching study with ID: ", study_id, ".\nVerify ID is correct or change hostname."))
        stop(paste0("Could not fetch study: ", study_id))
      },
      warning = function(warn) {
        message(paste0("Warning fetching study with ID: ", study_id, ".\nVerify ID is correct or change hostname."))
        warn(paste0("Warning with study: ", study_id))
      }
    )
  },
  #' @description
  #' Get all files of the studies in `self$study_list` and load into data frame. Use `filter` function first.
  #' @return list with `study_list` element to display all studies and list `df` with each dataframe in the list
  dataframe = function() {
    res <- list(study_list = self$study_list, df = list())
    for (study in self$study_list) {
      res$df[[study]] <- self$dataframe_from_id(study)
    }
    return(res)
  },
  #' @description
  #' Get file from `study_id` and convert into dataframe.
  #' @param study_id String containing the ID of the study to get dataframe of
  #' @return data frame containing data of study
  dataframe_from_id = function(study_id) {
    tryCatch(
      {
        dl_url <- self$get_download_url(study_id)
        message(paste0("Getting dataframe of study ", study_id, " from ", dl_url))
        return(read.csv(dl_url))
      },
      error = function(err) {
        message(paste0("Error fetching study with ID: ", study_id, ".\nVerify ID is correct or change hostname."))
        stop(paste0("Could not fetch study: ", study_id))
      },
      warning = function(warn) {
        message(paste0("Warning fetching study with ID: ", study_id, ".\nVerify ID is correct or change hostname."))
        warn(paste0("Warning with study: ", study_id))
      }
    )
  }
))
