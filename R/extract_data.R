#' Fetch Data from EEA API
#'
#' @param endpoint A character string of the API endpoint
#' @param params A list of parameters to pass to the API
#' @return A data.frame or list containing the fetched data
#' @export
#' @examples
#' data <- fetch_eea_data("some_endpoint", list(param1 = "value1", param2 = "value2"))
#' @import jsonlite

#' @export
# Define the function
extract_info_from_json <- function(json_text) {
  # Try to parse the JSON text, return NULL on error
  tryCatch({
    json_data <- fromJSON(json_text)
  }, error = function(e) {
    cat("Error parsing JSON:", e$message, "\n")
    return(NULL)
  })

  # Proceed only if json_data is not NULL
  if (!is.null(json_data)) {
    # Initialize an empty list to store the extracted information
    extracted_info <- list()

    # Extract publication date, assuming it's the date under 'type': 'publication'
    publication_dates <- sapply(json_data$resourceDate, function(x) ifelse(x$type == "publication", x$date, NA))
    publication_date <- na.omit(publication_dates)[1]  # Taking the first publication date, adjust as necessary

    # Extract places
    places <- json_data$places

    # Extract description
    description <- json_data$description

    # Store extracted information in the list
    extracted_info$publication_date <- publication_date
    extracted_info$places <- places
    extracted_info$description <- description

    # Return the list
    return(extracted_info)
  } else {
    return(list(publication_date = NA, places = NA, description = NA))
  }
}

# Example usage:
# Assuming `json_text` is your JSON-like string containing the data
# result <- extract_info_from_json(json_text)
# print(result)



#############





# extract_information_from_html <- function(html_content) {
#   # Parse the HTML content
#   page <- read_html(html_content)
#
#   # Extract the title
#   title <- page %>% html_node("title") %>% html_text()
#
#   # Extract some text content, for example, paragraphs
#   # This is just an example and might need to be adjusted based on the actual HTML structure
#   text_content <- page %>% html_nodes("p") %>% html_text()
#
#   # Return the extracted information
#   list(title = title, text_content = text_content)
# }

# Example usage with your HTML content as 'html_content' variable
#result <- extract_information_from_html(html_content)
#print(result$title)
#print(result$text_content)
