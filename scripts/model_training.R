# Load required libraries
library(readr)
library(forecast)

# Load cleaned data
data <- read_csv("data/salesdata_cleaned.csv")
data$Date <- as.Date(data$Date)

# Convert to time series (monthly frequency assumed)
start_year <- as.numeric(format(min(data$Date), "%Y"))
start_month <- as.numeric(format(min(data$Date), "%m"))
ts_data <- ts(data$Sales, start = c(start_year, start_month), frequency = 12)

# Automatically select the best ARIMA model
model <- auto.arima(ts_data)

# Display model summary
summary(model)

# Save the model as RDS (optional)
saveRDS(model, file = "output/arima_model.rds")
