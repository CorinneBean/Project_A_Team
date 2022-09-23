---------------------------------------------------------------------------
## Clean_addresses_geocoding.ipynb
---------------------------------------------------------------------------

From above JN we get the distinct and clean addresses that we can get the zip codes, geo-coordinates and demographic data.



# data_refined.csv contains Intakes Found Location and are split into - Address ,City and State.

# Here we run batch geocoding 

# Total Addresses - 35862 distinct rows

# Bucketed into 5k files

# Used - https://geocoding.geo.census.gov/geocoder/geographies/addressbatch?form for getting  -

# Index_ID
# Address from CSV	If match or not
# Geo coded Address with zipcode
# Longitude
# Latitude
# Tigerline ID Side
# STATE CODE:
# COUNTY CODE
# TRACT CODE
# BLOCK CODE


---------------------------------------------------------------------------
# # Input Files contains - the Batch geocoding files contains csv files containing
# 'Index_ID' 'Street_Address''City' 'State' 'Zipcode'
# Output files contains output from the input batch files contain the following information
# Index_ID 
# Street_Address
# City 
# State 
# If matched with input 
# Exact address 
# Longitude 
# Latitude
# Tigerline ID Side
# STATE CODE:
# COUNTY CODE
# TRACT CODE
# BLOCK CODE

---------------------------------------------------------------------------

# For convinience  - all input files are merged into an excel "batches.xlsx"
# all output files are merged into an excel "batches_with_zipcode"

---------------------------------------------------------------------------
# all 35k records are stored in a datafile - all_data.csv

