# Load required libraries
library(ggplot2)
library(readr)

# Load cleaned data
data <- read_csv("data/salesdata_cleaned.csv")
data$Date <- as.Date(data$Date)

# Plot the sales over time
ggplot(data, aes(x = Date, y = Sales)) +
  geom_line(color = "steelblue", size = 1) +
  labs(title = "Sales Over Time",
       x = "Date",
       y = "Sales",
       caption = "Source: Anti-diabetic drug sales (Australia)") +
  theme_minimal()

# Plot seasonal pattern if data is monthly
data$Month <- format(data$Date, "%m")
ggplot(data, aes(x = Month, y = Sales)) +
  geom_boxplot(fill = "skyblue") +
  labs(title = "Seasonal Sales Pattern by Month",
       x = "Month",
       y = "Sales") +
  theme_minimal()

