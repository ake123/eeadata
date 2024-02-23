#' Fetch Data from EEA API
#'
#' @param endpoint A character string of the API endpoint
#' @param params A list of parameters to pass to the API
#' @return A data.frame or list containing the fetched data
#' @export
#' @examples
#' data <- fetch_eea_data("some_endpoint", list(param1 = "value1", param2 = "value2"))
#' @import httr
#' @import jsonlite
#' @export


#file_path <- "eea_daviz_data.json"
# Define the function
download_json_data <- function(url, file_path) {
  if(missing(url) || missing(file_path)) {
    stop("Both 'url' and 'file_path' arguments are required")
  }

  # Attempt to download and parse the JSON data
  tryCatch({
    response <- GET(url)
    if(status_code(response) != 200) {
      stop("Failed to download data. Status code: ", status_code(response))
    }
    json_data <- content(response, "text", encoding = "UTF-8")
    data <- fromJSON(json_data)
    return(data)

    # Save the JSON data to the specified file path
    write.json(data, file_path)
    cat("Data downloaded and saved to", file_path, "\n")
  }, error = function(e) {
    cat("An error occurred: ", e$message, "\n")
  })
}
# download_json <- function(url) {
#   # Load required libraries
#   library(httr)
#   library(jsonlite)
#
#   # Make the HTTP GET request
#   response <- GET(url)
#
#   # Check if the request was successful
#   if (status_code(response) == 200) {
#     # Parse the JSON content
#     content <- content(response, "text")
#     json_data <- fromJSON(content)
#     return(json_data)
#   } else {
#     stop("Failed to download the JSON file: HTTP status code ", status_code(response))
#   }
# }
#
# # Example usage
# json_url <- "https://www.eea.europa.eu/code/api/data/daviz.json"
# json_data <- download_json(json_url)
#
# # Print the downloaded JSON data (or perform other operations)
# print(json_data)


# Example usage
#url <- "https://www.eea.europa.eu/code/api/data/daviz.json"
#file_path <- "eea_daviz_data.json"
#download_json_data(url, file_path)


