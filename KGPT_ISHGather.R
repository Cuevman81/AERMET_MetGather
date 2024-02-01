# Load necessary packages
library(R.utils)
library(httr)

# Define the station ID and years to download
station_id <- "747570-93874"
years <- c(2019, 2020, 2021, 2022, 2023)

# Define the output directory
output_dir <- "KGPT22_ISH"

# Create output directory if it doesn't exist
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# Define the output file based on the output directory
output_file <- paste0(output_dir, "/", gsub("_ISH", ".ish", basename(output_dir)))

# Loop over each year and download the corresponding data file
for (year in years) {
  # Construct the URL for the data file
  url <- paste0("https://www1.ncdc.noaa.gov/pub/data/noaa/", year, "/", station_id, "-", year, ".gz")
  
  # Define the local filename for the downloaded file
  filename <- paste0(output_dir, "/", year, ".gz")
  
  # Download the file and save it locally
  download.file(url, destfile = filename, mode = "wb")
  
  # Uncompress the downloaded file
  gunzip(filename)
}

# create a vector with the file names of the individual year files
file_names <- paste0(output_dir, "/", as.character(years))

# loop through the file names and read the contents into a list
file_list <- lapply(file_names, function(x) readLines(x))

# combine the list into a single character vector
combined_text <- unlist(file_list)

# write the combined text to the new file
writeLines(combined_text, output_file)
