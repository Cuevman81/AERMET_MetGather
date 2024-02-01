# AERMET_MetGather
Script to quickly gather 1/5 Minute data for AERMINUTE as well as ISH data for AERMET<br />

NCDC has changed the url for gathering one and five minute met data from https://www1.ncdc.noaa.gov/pub/data/ to https://www.ncei.noaa.gov/data/<br />

For the 1 and 5 minute data, at the beginning of the script put year and whatever ICAO your wanting to pull for processing.<br /><br />
For the ISH data, choose correct station_id <- "747570-93874" and for output_dir put ICAO in accorance with station_id. In this case KGPT goes with 747570-93874. Will download each year individually and and bind the data set into one 5 year file for processing.
