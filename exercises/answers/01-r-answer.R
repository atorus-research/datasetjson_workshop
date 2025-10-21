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
attr(adae$USUBJID, "label")  # "Unique Subject Identifier"

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
write_dataset_json(adae_json, "ADAE_complete.json")

# WG.6 Read it back and verify
adae_restored <- read_dataset_json("ADAE_complete.json")

# Check labels are preserved
attr(adae_restored$USUBJID, "label")  # "Unique Subject Identifier"

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

print("🎉 Whole Game complete! You've mastered the Dataset-JSON workflow with ADAE.")
print("Notice how time variables may change class during round-trip!")

# =============================================================================
# EXERCISE 1: Basic Operations - Read and Write Dataset-JSON Files
# =============================================================================

# 1.1 Create sample clinical trial data
sample_data <- data.frame(
  USUBJID = paste0("SUBJ-", sprintf("%03d", 1:10)),
  AGE = c(25, 34, 45, 29, 38, 52, 41, 33, 47, 36),
  SEX = c("M", "F", "M", "F", "M", "F", "M", "F", "M", "F"),
  RACE = rep(c("WHITE", "BLACK", "ASIAN"), length.out = 10),
  TREATMENT = rep(c("PLACEBO", "DRUG A"), each = 5),
  BASELINE_SCORE = c(12.5, 15.2, 18.7, 11.3, 16.8, 14.2, 17.5, 13.9, 19.1, 15.6)
)

# Examine the structure of your sample data
str(sample_data)
head(sample_data)

# 1.2 Convert data.frame to Dataset-JSON format
sample_json <- dataset_json(sample_data, name = "DEMO", dataset_label = "Demographics")

# 1.3 Write Dataset-JSON to file
write_dataset_json(sample_json, "sample_clinical_data.json")

# 1.4 Read Dataset-JSON back from file
sample_restored <- read_dataset_json("sample_clinical_data.json")

# 1.5 Verify the round-trip conversion
identical(sample_data, sample_restored)
all.equal(sample_data, sample_restored)

# 1.6 Work with provided sample data
ae_data <- read_dataset_json("data/sample_adverse_events.json")
str(ae_data)
head(ae_data)

# =============================================================================
# EXERCISE 2: Data Exploration - Examine Dataset-JSON Structure
# =============================================================================

# 2.1 Load the built-in iris dataset and convert to Dataset-JSON
data("iris")
iris_json <- dataset_json(iris, name = "IRIS", dataset_label = "Iris Dataset")

# Explore the top-level structure of the Dataset-JSON object
names(iris_json)
# Should show: "clinicalData"

# 2.2 Examine clinical data metadata
names(iris_json)
str(iris_json, max.level = 2)

# 2.3 Explore item group data
names(iris_json)
str(iris_json$clinicalData$itemGroupData)

# 2.4 Investigate individual items (columns)
# Look at column information
if (!is.null(iris_json$columns)) {
  iris_json$columns
} else {
  # Columns are auto-generated from data
  str(iris_json$clinicalData$itemGroupData)
}

# 2.5 Examine item data (actual values)
# The actual data is stored in the original data.frame format
head(iris_json$data)
str(iris_json$data)

# =============================================================================
# EXERCISE 3: Data Processing - Transform and Export Data
# =============================================================================

# 3.1 Load and examine the mtcars dataset
data("mtcars")

# Add a row names column to mtcars (car names)
mtcars$CAR_NAME <- rownames(mtcars)

# 3.2 Create a processed version of the data
processed_data <- mtcars %>%
  filter(mpg > 20) %>%
  select(mpg, cyl, hp, CAR_NAME) %>%
  arrange(desc(mpg))

# 3.3 Add meaningful labels to your processed data
attr(processed_data$mpg, "label") <- "Miles Per Gallon"
attr(processed_data$cyl, "label") <- "Number of Cylinders"
attr(processed_data$hp, "label") <- "Gross Horsepower"
attr(processed_data$CAR_NAME, "label") <- "Car Model Name"

# 3.4 Convert to Dataset-JSON and examine the metadata
# Create column metadata
columns <- data.frame(
  itemOID = paste0("IT.", names(processed_data)),
  name = names(processed_data),
  label = sapply(names(processed_data), function(x) attr(processed_data[[x]], "label") %||% x),
  dataType = c("float", "integer", "integer", "text")
)

processed_json <- dataset_json(processed_data, 
                              name = "CARS", 
                              dataset_label = "Efficient Cars",
                              columns = columns)

# 3.5 Export the processed data
write_dataset_json(processed_data, "efficient_cars.json")

# =============================================================================
# EXERCISE 4: Error Handling - Handle Common Issues
# =============================================================================

# 4.1 Handle missing files gracefully
tryCatch({
  df <- read_dataset_json("nonexistent_file.json")
}, error = function(e) {
  message("Error reading file: ", e$message)
})

# 4.2 Handle invalid data types
problematic_data <- data.frame(
  x = 1:3,
  y = I(list(a = 1, b = 2, c = 3))  # List column
)

tryCatch({
  json_data <- dataset_json(problematic_data, name = "TEST", dataset_label = "Test")
}, error = function(e) {
  message("Error converting data: ", e$message)
})

# 4.3 Validate file contents
safe_read_dataset_json <- function(file_path) {
  # Check if file exists
  if (!file.exists(file_path)) {
    message("Error: File does not exist: ", file_path)
    return(NULL)
  }
  
  # Try to read the file
  tryCatch({
    result <- read_dataset_json(file_path)
    
    # Validate that it returns a data.frame
    if (!is.data.frame(result)) {
      message("Error: File did not return a valid data.frame")
      return(NULL)
    }
    
    message("Successfully read ", nrow(result), " rows and ", ncol(result), " columns")
    return(result)
    
  }, error = function(e) {
    message("Error reading file: ", e$message)
    return(NULL)
  })
}

# Test the function
test_result <- safe_read_dataset_json("data/sample_adverse_events.json")
test_result2 <- safe_read_dataset_json("nonexistent.json")

# =============================================================================
# EXERCISE 5: Advanced Usage - Work with Metadata and Attributes
# =============================================================================

# 5.1 Create rich metadata for clinical data
clinical_data <- data.frame(
  USUBJID = paste0("SUBJ-", 1:5),
  VISIT = c("BASELINE", "WEEK 2", "WEEK 4", "WEEK 8", "WEEK 12"),
  AVAL = c(10.2, 8.7, 6.5, 4.3, 3.1),
  AVALC = c("SEVERE", "MODERATE", "MILD", "MILD", "MINIMAL"),
  AVISIT = c("Baseline", "Week 2", "Week 4", "Week 8", "Week 12")
)

# Add comprehensive labels to each column
attr(clinical_data$USUBJID, "label") <- "Unique Subject Identifier"
attr(clinical_data$VISIT, "label") <- "Visit Code"
attr(clinical_data$AVAL, "label") <- "Analysis Value"
attr(clinical_data$AVALC, "label") <- "Analysis Value Character"
attr(clinical_data$AVISIT, "label") <- "Analysis Visit"

# 5.2 Add additional metadata
attr(clinical_data$AVAL, "units") <- "mg/dL"

# 5.3 Convert to Dataset-JSON and examine metadata preservation
# Create column metadata
clinical_columns <- data.frame(
  itemOID = paste0("IT.", names(clinical_data)),
  name = names(clinical_data),
  label = sapply(names(clinical_data), function(x) attr(clinical_data[[x]], "label") %||% x),
  dataType = c("text", "text", "float", "text", "text")
)

clinical_json <- dataset_json(clinical_data, 
                             name = "CLINICAL", 
                             dataset_label = "Clinical Data",
                             columns = clinical_columns)

# 5.4 Round-trip test with metadata
write_dataset_json(clinical_json, "clinical_with_metadata.json")
clinical_restored <- read_dataset_json("clinical_with_metadata.json")

# Check if labels are preserved
sapply(names(clinical_data), function(col) {
  original_label <- attr(clinical_data[[col]], "label")
  restored_label <- attr(clinical_restored[[col]], "label")
  identical(original_label, restored_label)
})

# 5.5 Create a utility function
add_clinical_metadata <- function(df) {
  # Add standard labels based on common CDISC variable names
  if ("USUBJID" %in% names(df)) {
    attr(df$USUBJID, "label") <- "Unique Subject Identifier"
  }
  if ("AGE" %in% names(df)) {
    attr(df$AGE, "label") <- "Age"
    attr(df$AGE, "units") <- "years"
  }
  if ("SEX" %in% names(df)) {
    attr(df$SEX, "label") <- "Sex"
  }
  if ("RACE" %in% names(df)) {
    attr(df$RACE, "label") <- "Race"
  }
  if ("AVAL" %in% names(df)) {
    attr(df$AVAL, "label") <- "Analysis Value"
  }
  
  return(df)
}

# Test the function
test_data <- data.frame(
  USUBJID = c("001", "002"),
  AGE = c(25, 30),
  SEX = c("M", "F")
)

enhanced_data <- add_clinical_metadata(test_data)
sapply(names(enhanced_data), function(col) attr(enhanced_data[[col]], "label"))

# =============================================================================
# BONUS EXERCISES: Real-world Scenarios
# =============================================================================

# BONUS 1: Work with real sample data
demographics <- read.csv("data/demographics.csv", stringsAsFactors = FALSE)

# Create column metadata
demog_columns <- data.frame(
  itemOID = paste0("IT.", names(demographics)),
  name = names(demographics),
  label = c("Unique Subject Identifier", "Age at Consent", "Sex", "Race", "Ethnicity", "Country", "Treatment Arm"),
  dataType = c("text", "integer", "text", "text", "text", "text", "text")
)

# Convert to Dataset-JSON
demog_json <- dataset_json(demographics, 
                          name = "DM", 
                          dataset_label = "Demographics",
                          columns = demog_columns)
write_dataset_json(demog_json, "demographics_dataset.json")

# BONUS 2: Batch processing
process_csv_directory <- function(input_dir, output_dir) {
  # Create output directory if it doesn't exist
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }
  
  # Find all CSV files
  csv_files <- list.files(input_dir, pattern = "\\.csv$", full.names = TRUE)
  
  for (csv_file in csv_files) {
    tryCatch({
      # Read CSV
      df <- read.csv(csv_file, stringsAsFactors = FALSE)
      
      # Create output filename
      base_name <- tools::file_path_sans_ext(basename(csv_file))
      output_file <- file.path(output_dir, paste0(base_name, "_dataset.json"))
      
      # Create dataset-json object and write
      ds_json <- dataset_json(df, name = base_name, dataset_label = base_name)
      write_dataset_json(ds_json, output_file)
      
      message("Converted: ", csv_file, " -> ", output_file)
      
    }, error = function(e) {
      message("Error processing ", csv_file, ": ", e$message)
    })
  }
}

# BONUS 3: Data validation
validate_dataset_json <- function(file_path) {
  validation_results <- list(
    file_exists = file.exists(file_path),
    valid_json = FALSE,
    has_required_structure = FALSE,
    has_usubjid = FALSE,
    errors = character(0)
  )
  
  if (!validation_results$file_exists) {
    validation_results$errors <- c(validation_results$errors, "File does not exist")
    return(validation_results)
  }
  
  tryCatch({
    df <- read_dataset_json(file_path)
    validation_results$valid_json <- TRUE
    
    # Check for required structure
    if (is.data.frame(df) && nrow(df) > 0) {
      validation_results$has_required_structure <- TRUE
    }
    
    # Check for USUBJID (common in clinical trials)
    if ("USUBJID" %in% names(df)) {
      validation_results$has_usubjid <- TRUE
    } else {
      validation_results$errors <- c(validation_results$errors, "Missing USUBJID column")
    }
    
  }, error = function(e) {
    validation_results$errors <- c(validation_results$errors, paste("JSON error:", e$message))
  })
  
  return(validation_results)
}

# Test validation
validation_result <- validate_dataset_json("data/sample_adverse_events.json")
print(validation_result)

# BONUS 4: Performance comparison
compare_formats <- function(df, base_filename) {
  results <- data.frame(
    format = character(0),
    file_size_kb = numeric(0),
    write_time_sec = numeric(0),
    read_time_sec = numeric(0)
  )
  
  # CSV
  csv_file <- paste0(base_filename, ".csv")
  write_time <- system.time(write.csv(df, csv_file, row.names = FALSE))
  file_size <- file.info(csv_file)$size / 1024
  read_time <- system.time(read.csv(csv_file))
  
  results <- rbind(results, data.frame(
    format = "CSV",
    file_size_kb = file_size,
    write_time_sec = write_time[["elapsed"]],
    read_time_sec = read_time[["elapsed"]]
  ))
  
  # RDS
  rds_file <- paste0(base_filename, ".rds")
  write_time <- system.time(saveRDS(df, rds_file))
  file_size <- file.info(rds_file)$size / 1024
  read_time <- system.time(readRDS(rds_file))
  
  results <- rbind(results, data.frame(
    format = "RDS",
    file_size_kb = file_size,
    write_time_sec = write_time[["elapsed"]],
    read_time_sec = read_time[["elapsed"]]
  ))
  
  # Dataset-JSON
  json_file <- paste0(base_filename, "_dataset.json")
  write_time <- system.time(write_dataset_json(df, json_file))
  file_size <- file.info(json_file)$size / 1024
  read_time <- system.time(read_dataset_json(json_file))
  
  results <- rbind(results, data.frame(
    format = "Dataset-JSON",
    file_size_kb = file_size,
    write_time_sec = write_time[["elapsed"]],
    read_time_sec = read_time[["elapsed"]]
  ))
  
  # Clean up
  file.remove(csv_file, rds_file, json_file)
  
  return(results)
}

# Test with mtcars
performance_results <- compare_formats(mtcars, "performance_test")
print(performance_results)

print("All exercises completed! Great work exploring the datasetjson R package.")