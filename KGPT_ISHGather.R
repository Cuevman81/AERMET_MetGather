library(R.utils)
library(httr)

# Define the station ID and years to download
station_id <- "747570-93874"
years <- c(2018, 2019, 2020, 2021, 2022,2023)

# Loop over each year and download the corresponding data file
for (year in years) {
  # Construct the URL for the data file
  url <- paste0("https://www1.ncdc.noaa.gov/pub/data/noaa/", year, "/", station_id, "-", year, ".gz")
  
  # Define the local filename for the downloaded file
  filename <- paste0(year, ".gz")
  
  # Download the file and save it locally
  download.file(url, destfile = filename, mode = "wb")
  
  # Uncompress the downloaded file
  gunzip(filename)
}

# create a vector with the file names of the individual year files
file_names <- c("2018", "2019", "2020", "2021", "2022", "2023")

# loop through the file names and read the contents into a list
file_list <- lapply(file_names, function(x) readLines(x))

# combine the list into a single character vector
combined_text <- unlist(file_list)

# write the combined text to a new file
writeLines(combined_text, "KGPT22.ish")