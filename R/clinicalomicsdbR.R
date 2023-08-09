library(httr2)
library(R6)

#' clinicalomicsdbR object
#' @import httr2
#' @import R6
#' @export
clinicalomicsdbR <- R6Class("clinicalomicsdbR", list(
  hostname = "http://clinicalomicsdb.zhang-lab.org",
  studies = list(),
  filter = function(drugs = c(), cancers = c(), partial = TRUE) {
    req <- request("localhost:3000/api/filter")
    req <- req %>%
      req_method("POST") %>%
      req_headers("Accept" = "application/json, text/plain", "Content-Type" = "application/json;charset=UTF-8") %>%
      req_body_raw("
        {
          \"drugs\": [\"paclitaxel\"],
          \"cancers\": [\"Breast\"],
          \"partial\": true,
          \"groups\": []
        }
        ")
    resp <- req_perform(req)
    filter_res <- resp %>% resp_body_json()
    print(filter_res)
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
  download = function(study_id) {
    dl_url <- self$get_download_url(study_id)
    print(paste0("Download study ", study_id, " from ", dl_url))
    return(read.csv(dl_url))
  }
))
