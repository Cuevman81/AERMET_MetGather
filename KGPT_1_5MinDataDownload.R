# Load necessary packages
library(httr)

# Define the year and ICAO code
year <- 2023
icao_code <- "KGPT"

# Define base URLs for one minute and five minute data
url_base_1min <- "https://www.ncei.noaa.gov/data/automated-surface-observing-system-one-minute-pg1/access/"
url_base_5min <- "https://www.ncei.noaa.gov/data/automated-surface-observing-system-five-minute/access/"

# Define output directories for one minute and five minute data
output_dir_1min <- paste("asos_data_1min", icao_code, year, sep = "/")
output_dir_5min <- paste("asos_data_5min", icao_code, year, sep = "/")

# Create output directories if they don't exist
if (!dir.exists(output_dir_1min)) {
  dir.create(output_dir_1min, recursive = TRUE)
}

if (!dir.exists(output_dir_5min)) {
  dir.create(output_dir_5min, recursive = TRUE)
}

# Loop over months from January to December
for (month in 1:12) {
  # Create URL and file name for one minute data
  url_1min <- paste0(url_base_1min, year, "/", sprintf("%02d", month), "/asos-1min-pg1-", icao_code, "-", year, sprintf("%02d", month), ".dat")
  file_name_1min <- paste0("64050", icao_code, year, sprintf("%02d", month), ".dat")
  file_path_1min <- paste(output_dir_1min, file_name_1min, sep = "/")
  
  # Download one minute data
  response_1min <- GET(url_1min)
  data_1min <- content(response_1min, "text")
  write(data_1min, file_path_1min)
  cat("One minute data for month", month, "downloaded and saved to", file_path_1min, "\n")
  
  # Create URL and file name for five minute data
  url_5min <- paste0(url_base_5min, year, "/", sprintf("%02d", month), "/asos-5min-", icao_code, "-", year, sprintf("%02d", month), ".dat")
  file_name_5min <- paste0("64010", icao_code, year, sprintf("%02d", month), ".dat")
  file_path_5min <- paste(output_dir_5min, file_name_5min, sep = "/")
  
  # Download five minute data
  response_5min <- GET(url_5min)
  data_5min <- content(response_5min, "text")
  write(data_5min, file_path_5min)
  cat("Five minute data for month", month, "downloaded and saved to", file_path_5min, "\n")
}
