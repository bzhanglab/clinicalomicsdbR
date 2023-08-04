library(httr2)

filter <- function(drugs = c(), cancers = c(), partial = TRUE) {
  req <- request("localhost:3000/api/filter")
  req <- req %>%
    req_method("POST") %>%
    req_headers("Accept" = "application/json, text/plain", "Content-Type" = "application/json;charset=UTF-8") %>%
    req_body_raw("
      {
        \"drugs\": [\"drug_paclitaxel\"],
        \"cancers\": [\"Breast\"],
        \"partial\": true,
        \"groups\": []
      }
      ")
  resp <- req_perform(req)
  filter_res <- resp %>% resp_body_json()
  print(filter_res)
}

#' clinicalomicsdbR object
#' @import httr2
#' @export
clinicalomicsdbR <- list(filter = filter, hello = function(name) {
  print(paste0("Hello ", name, "!"))
})
