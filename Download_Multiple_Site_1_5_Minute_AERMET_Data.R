# Load necessary packages
library(httr)

# Select the year
selected_year <- 2022

# Define base URLs for one minute and five minute data
url_base_1min <- "https://www.ncei.noaa.gov/data/automated-surface-observing-system-one-minute-pg1/access/"
url_base_5min <- "https://www.ncei.noaa.gov/data/automated-surface-observing-system-five-minute/access/"

# Define ASOS sites and their respective folders
asos_sites <- c("KGPT", "KJAN", "KTUP")
folder_names <- c("Gulfport_met", "Jackson_met", "Tupelo_met")
output_dir_1min <- "asos_data_1min"
output_dir_5min <- "asos_data_5min"

# Create output directories if they don't exist
if (!dir.exists(output_dir_1min)) {
  dir.create(output_dir_1min)
}

if (!dir.exists(output_dir_5min)) {
  dir.create(output_dir_5min)
}

# Loop over ASOS sites
for (i in seq_along(asos_sites)) {
  asos_site <- asos_sites[i]
  folder_name <- folder_names[i]
  
  # Create subfolders for each ASOS site if they don't exist
  subfolder_1min <- file.path(output_dir_1min, folder_name)
  subfolder_5min <- file.path(output_dir_5min, folder_name)
  
  if (!dir.exists(subfolder_1min)) {
    dir.create(subfolder_1min, recursive = TRUE)
  }
  
  if (!dir.exists(subfolder_5min)) {
    dir.create(subfolder_5min, recursive = TRUE)
  }
  
  # Loop over months from January to December
  for (month in 1:12) {
    # Create URL and file name for one minute data
    url_1min <- paste0(url_base_1min, selected_year, "/", sprintf("%02d", month), "/asos-1min-pg1-", asos_site, "-", selected_year, sprintf("%02d", month), ".dat")
    file_name_1min <- paste0("64050", asos_site, selected_year, sprintf("%02d", month), ".dat")
    file_path_1min <- file.path(subfolder_1min, file_name_1min)
    
    # Download one minute data
    response_1min <- tryCatch(GET(url_1min), error = function(e) NULL)
    
    if (!is.null(response_1min) && status_code(response_1min) == 200) {
      data_1min <- content(response_1min, "text")
      write(data_1min, file_path_1min)
      cat("One minute data for", asos_site, "for month", month, "downloaded and saved to", file_path_1min, "\n")
    } else {
      cat("One minute data for", asos_site, "for month", month, "not found\n")
    }
    
    # Create URL and file name for five minute data
    url_5min <- paste0(url_base_5min, selected_year, "/", sprintf("%02d", month), "/asos-5min-", asos_site, "-", selected_year, sprintf("%02d", month), ".dat")
    file_name_5min <- paste0("64010", asos_site, selected_year, sprintf("%02d", month), ".dat")
    file_path_5min <- file.path(subfolder_5min, file_name_5min)
    
    # Download five minute data
    response_5min <- tryCatch(GET(url_5min), error = function(e) NULL)
    
    if (!is.null(response_5min) && status_code(response_5min) == 200) {
      data_5min <- content(response_5min, "text")
      write(data_5min, file_path_5min)
      cat("Five minute data for", asos_site, "for month", month, "downloaded and saved to", file_path_5min, "\n")
    } else {
      cat("Five minute data for", asos_site, "for month", month, "not found\n")
    }
  }
}
