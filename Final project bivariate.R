library(dplyr)
library(readxl)

# Read in data
data <- read_xlsx("cleaned data.xlsx")
data <- data[, c("cigcragp", "irsex", "CATAG3", "inc_numeric", "HEALTH2")]
data <- na.omit(data)
View(data)
attach(data)



# Count respondents by gender and cigcragp level
count_data_gender <- data %>%
  group_by(cigcragp, irsex) %>%
  summarise(count = n())

# View the resulting data
View(count_data_gender)





# Count respondents by age and cigcragp level
count_data_age <- data %>%
  group_by(cigcragp, CATAG3) %>%
  summarise(count = n())

# View the resulting data
View(count_data_age)





# Group the data by cigcragp level and calculate summary statistics for income
summary_stats <- data %>%
  group_by(cigcragp) %>%
  summarise(
    mean_income = mean(inc_numeric, na.rm = TRUE),
    median_income = median(inc_numeric, na.rm = TRUE),
    min_income = min(inc_numeric, na.rm = TRUE),
    max_income = max(inc_numeric, na.rm = TRUE),
    sd_income = sd(inc_numeric, na.rm = TRUE)
  )

# View the summary statistics
View(summary_stats)





# Count respondents by health and cigcragp level
count_data_health <- data %>%
  group_by(cigcragp, HEALTH2) %>%
  summarise(count = n())

# View the resulting data
View(count_data_health)







# HT tests
chisq.test(irsex, cigcragp)

chisq.test(CATAG3, cigcragp)

inc_anova <- aov(inc_numeric ~ cigcragp)
summary(inc_anova)

chisq.test(HEALTH2, cigcragp)








