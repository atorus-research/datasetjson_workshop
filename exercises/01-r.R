# R/Pharma 2025 Workshop: datasetjson in R
# Exercises for hands-on practice with the datasetjson R package
#
# INSTRUCTIONS:
# 1. Work through each exercise section in order
# 2. Replace TODO comments with actual R code
# 3. Run your code to test it works
# 4. Check your answers against exercises/answers/01-r-answer.R
# 5. Ask for help if you get stuck!
#
# TIP: Use Ctrl+Enter (Cmd+Enter on Mac) to run individual lines

# Load required libraries
library(datasetjson)
library(dplyr)
library(arrow)  # For reading parquet files

# Set working directory to the workshop folder
# Adjust this path as needed for your setup
if (!file.exists("data")) {
  warning("Data directory not found. Make sure you're in the workshop root directory.")
}

# =============================================================================
# THE WHOLE GAME: Complete Workflow with ADAE Data
# =============================================================================

# Now it's your turn! Repeat the same workflow we saw with ADSL, but using ADAE data.

# WG.1 Load the ADAE datasets (format doesn't matter - RDS or Parquet!)
# TODO: Load ADAE data using either read_parquet() or readRDS()
# Files: "data/adam/adae.parquet" or "data/adam/adae.rds"
# YOUR CODE HERE:


# WG.2 Load the metadata
# TODO: Load ADAE metadata from "data/adam/metadata/adae_meta.parquet" or .rds
# YOUR CODE HERE:


# WG.3 Examine what we have
# TODO: Look at the structure of adae and adae_meta
# Check some variable labels and data types
# Look for time variables - what class are they?
# YOUR CODE HERE:


# WG.4 Create Dataset-JSON object
# TODO: Use dataset_json() to combine the data and metadata
# HINT: dataset_json(adae, name = "ADAE", dataset_label = "Adverse Events Analysis Dataset", columns = adae_meta)
# YOUR CODE HERE:


# WG.5 Write to standardized file
# TODO: Use write_dataset_json() to save as "ADAE_complete.json"
# YOUR CODE HERE:


# WG.6 Read it back and verify
# TODO: Use read_dataset_json() to read the file back
# Check that labels are preserved and data is identical
# Pay attention to any time variables - do their classes change?
# YOUR CODE HERE:


# WG.7 Compare original and restored
# TODO: Use diffdf::diffdf() and waldo::compare() to check differences
# YOUR CODE HERE:


print("🎉 Whole Game complete! You've mastered the Dataset-JSON workflow with ADAE.")
