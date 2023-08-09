library(httr2)
library(R6)

#' clinicalomicsdbR object
#' @import httr2
#' @import R6
#' @export
clinicalomicsdbR <- R6Class("clinicalomicsdbR", list(
  hostname = "http://clinicalomicsdb.zhang-lab.org",
  study_list = c(),
  filter = function(drugs = c(), cancers = c(), partial = TRUE) {
    if (length(drugs) == 0) {
      drug_text <- "[]"
    } else {
      drug_text <- "["
      for (drug in drugs) {
        drug_text <- paste0(drug_text, '"', drug, '",')
      }
      drug_text <- substr(drug_text, 1, nchar(drug_text) - 1)
      drug_text <- paste0(drug_text, "]")
      print(drug_text)
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
      print(cancer_text)
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
    resp <- req_perform(req)
    filter_res <- resp %>% resp_body_json()
    self$study_list <- unlist(filter_res$study_list)
    print(self$study_list)
    print(paste0("Filtered to ", length(self$study_list), " studies."))
    invisible(self)
  },
  get_download_url = function(study_id) {
    req <- request(paste0(self$hostname, "/api/info/", study_id))
    req <- req %>%
      req_method("GET") %>%
      req_headers("Accept" = "application/json, text/plain")
    resp <- req_perform(req)
    resp_json <- resp %>% resp_body_json()
    return(resp_json$download_url)
  },
  download = function(study_id, output_dir = "clindb") {
    for (study_id in self$study_list) {
      dl_url <- self$get_download_url(study_id)
      print(paste0("Downloading study ", study_id, " from ", dl_url))
      download.file(dl_url, paste0(output_dir, "/", study_id))
    }
    print(paste0("Downloaded ", length(self$study_list), " studies."))
    invisible(self)
  },
  download_from_id = function(study_id) {
    dl_url <- self$get_download_url(study_id)
    print(paste0("Downloading study ", study_id, " from ", dl_url))
    download.file(dl_url)
    print("Done downloading study.")
    invisible(self)
  },
  dataframe = function() {
    res <- list(study_list = self$study_list, df = list())
    for (study in self$study_list) {
      res$df[[study]] <- self$dataframe_from_id(study)
    }
    return(res)
  },
  dataframe_from_id = function(study_id) {
    dl_url <- self$get_download_url(study_id)
    print(paste0("Getting dataframe of study ", study_id, " from ", dl_url))
    return(read.csv(dl_url))
  }
))
