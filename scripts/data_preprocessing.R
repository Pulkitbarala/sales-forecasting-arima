# Load necessary libraries
library(readr)
library(dplyr)

# Load the data
data <- read_csv("data/salesdata.csv")

# Convert date column to Date format
data$date <- as.Date(data$date)

# Rename columns for consistency
colnames(data) <- c("Date", "Sales")

# Sort data by Date
data <- data %>% arrange(Date)

# Check for missing values
print(sum(is.na(data)))

# Save cleaned data (optional)
write_csv(data, "data/salesdata_cleaned.csv")
