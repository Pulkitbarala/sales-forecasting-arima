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

# Load the trained ARIMA model
model <- readRDS("output/arima_model.rds")

# Forecast next 12 months
forecast_data <- forecast(model, h = 12)

# Plot the forecast
png("output/forecast_plot.png", width = 800, height = 600)
plot(forecast_data,
     main = "12-Month Sales Forecast",
     xlab = "Time",
     ylab = "Sales")
dev.off()

# Save forecast data to CSV
forecast_df <- data.frame(
  Date = seq(from = max(data$Date) + 30, by = "month", length.out = 12),
  Forecast = as.numeric(forecast_data$mean)
)
write_csv(forecast_df, "output/sales_forecast.csv")
