# R/Pharma 2025 Workshop: datasetjson in R - ANSWER KEY
# Solutions for hands-on practice with the datasetjson R package

# Load required libraries
library(datasetjson)
library(dplyr)
library(arrow)  # For reading parquet files

# Helper function for null coalescing
`%||%` <- function(x, y) if (is.null(x)) y else x

# Set working directory to the workshop folder
if (!file.exists("data")) {
  warning("Data directory not found. Make sure you're in the workshop root directory.")
}

# =============================================================================
# THE WHOLE GAME: Complete Workflow with ADAE Data - SOLUTIONS
# =============================================================================

# WG.1 Load the ADAE datasets (format doesn't matter - RDS or Parquet!)
# Using parquet (could also use readRDS)
adae <- read_parquet("data/adam/adae.parquet")
# Alternative: adae <- readRDS("data/adam/adae.rds")

# WG.2 Load the metadata
adae_meta <- read_parquet("data/adam/metadata/adae_meta.parquet")
# Alternative: adae_meta <- readRDS("data/adam/metadata/adae_meta.rds")

# WG.3 Examine what we have
str(adae)  # Adverse events data
head(adae_meta)  # Metadata in Dataset-JSON format
str(attributes(adae))

# Look for time variables and their classes
time_vars <- adae_meta[adae_meta$dataType == "time", ]

if(nrow(time_vars) > 0) {
  print("Time variables found:")
  print(time_vars$name)
  # Check original classes
  for(var in time_vars$name) {
    if(var %in% names(adae)) {
      cat(var, ":", class(adae[[var]]), "\n")
    }
  }
}


# WG.4 Create Dataset-JSON object
adae_json <- dataset_json(
  adae,
  name = "ADAE",
  dataset_label = "Adverse Events Analysis Dataset",
  columns = adae_meta
)

# WG.5 Write to standardized file
write_dataset_json(adae_json, "ADAE_answer.json")

# WG.6 Read it back and verify
adae_restored <- read_dataset_json("ADAE_answer.json")

# Check attributes are preserved
str(attributes(adae_restored))

# Check time variable classes after round-trip
if(nrow(time_vars) > 0) {
  print("Time variable classes after round-trip:")
  for(var in time_vars$name) {
    if(var %in% names(adae_restored)) {
      cat(var, ":", class(adae_restored[[var]]), "\n")
    }
  }
}

# WG.7 Compare original and restored
diffdf::diffdf(adae, adae_restored)
waldo::compare(adae, adae_restored)

# differences
# 1. df class is now datasetjson_v1_1_0, datasetjson, data.frame - this is ok and expected!
# 2. ASEVN was numeric and now is character !?! - check the adae_meta.rds.  There is an error in dataType.  It was set to string when it should be integer.
adae_meta$dataType[adae_meta$name == "ASEVN"] <- "integer"

adae_json <- dataset_json(
  adae,
  name = "ADAE",
  dataset_label = "Adverse Events Analysis Dataset",
  columns = adae_meta
)

write_dataset_json(adae_json, "ADAE_answer.json")

adae_restored <- read_dataset_json("ADAE_answer.json")

diffdf::diffdf(adae, adae_restored)

print("🎉 Whole Game complete! You've mastered the Dataset-JSON workflow with ADAE.")
print("Notice how time variables may change class during round-trip!")