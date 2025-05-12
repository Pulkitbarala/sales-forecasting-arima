# Load required libraries
library(forecast)
library(readr)

# Load cleaned data
data <- read_csv("data/salesdata_cleaned.csv")
data$Date <- as.Date(data$Date)

# Convert to time series
start_year <- as.numeric(format(min(data$Date), "%Y"))
start_month <- as.numeric(format(min(data$Date), "%m"))
ts_data <- ts(data$Sales, start = c(start_year, start_month), frequency = 12)

# Split data into training and test sets
train_size <- length(ts_data) - 12
train_ts <- window(ts_data, end = c(start_year + (train_size - 1) %/% 12, (train_size - 1) %% 12 + 1))
test_ts <- window(ts_data, start = c(start_year + train_size %/% 12, train_size %% 12 + 1))

# Train model on training data
model <- auto.arima(train_ts)

# Forecast next 12 months
forecast_test <- forecast(model, h = 12)

# Evaluate accuracy against the test set
accuracy_metrics <- accuracy(forecast_test, test_ts)
print(accuracy_metrics)
