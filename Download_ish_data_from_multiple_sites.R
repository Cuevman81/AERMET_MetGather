library(httr)
library(R.utils)

# Define the station IDs and years to download
station_ids <- c("747570-93874", "722350-03940", "723320-93862")
years <- c(2018, 2019, 2020, 2021, 2022)

# Create the output directory if it doesn't exist
output_dir <- "ish_data"
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# Loop over each station and year combination
for (station_id in station_ids) {
  # Create a subfolder for each station if it doesn't exist
  station_dir <- file.path(output_dir, station_id)
  if (!dir.exists(station_dir)) {
    dir.create(station_dir)
  }
  
  for (year in years) {
    # Construct the URL for the data file
    url <- paste0("https://www1.ncdc.noaa.gov/pub/data/noaa/", year, "/", station_id, "-", year, ".gz")
    
    # Define the local filename for the downloaded file
    filename <- paste0(station_id, "-", year, ".gz")
    
    # Set the output path for the downloaded file
    output_path <- file.path(station_dir, filename)
    
    # Download the file and save it locally
    GET(url, write_disk(output_path, overwrite = TRUE))
    
    # Uncompress the downloaded file
    gunzip(output_path)
  }
}
