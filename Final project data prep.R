# Set working directory and libraries
library(dplyr)
library(writexl)
setwd("/Users/alyssayang/Desktop/qmss 201/final project")

# Read in dataset
data <- read.csv("Project Data.csv")
View(data)


# Recode variables --------------------------------------------------------

# Demographic variables: age categories (catag3), gender (irsex), race (newrace2), income (irfamin3), and health status (health2)
data <- data %>%  
  mutate(CATAG3 = recode(CATAG3, "1" = "12-17 Years Old", "2" = "18-25 Years Old", "3" = "26-34 Years Old", 
                                 "4" = "35-49 Years Old", "5" = "50 or Older")) %>%
  mutate(irsex = recode(irsex, "1" = "Male", "2" = "Female")) %>%
  mutate(NEWRACE2 = recode(NEWRACE2, "1" = "NonHisp White", "2" = "NonHisp Black/Afr Am", "3" = "NonHisp Native Am/AK Native",
                                     "4" = "NonHisp Native HI/Other Pac Isl", "5" = "NonHisp Asian", "6" = "NonHisp more than one race",
                                     "7" = "Hispanic")) %>%
  mutate(IRFAMIN3 = recode(IRFAMIN3, "1" = "Less than $10,000 (Including Loss)", "2" = "$10,000 - $19,999", "3" = "$20,000 - $29,999",
                                     "4" = "$30,000 - $39,999", "5" = "$40,000 - $49,999", "6" = "$50,000 - $74,999", "7" = "$75,000 or more")) %>%
  mutate(HEALTH2 = recode(HEALTH2, "1" = "Excellent (HEALTH=1)", "2" = "Very Good (HEALTH=2)", "3" = "Good (HEALTH=3)", 
                                   "4" = "Fair/Poor (HEALTH=4,5)"))

# Addiction variables: cigarette cravings (cigcragp), tried cutting down alcohol (alccutdn), and able to cut down alcohol (alccut1x)
data <- data %>%  
  mutate(cigcragp = recode(cigcragp, "1" = "Not at all true", "2" = "Somewhat true", "3" = "Moderately true", 
                                     "4" = "Very true", "5" = "Extremely true")) %>%
  mutate(alccutdn = recode(alccutdn, "1" = "Yes", "2" = "No")) %>%
  mutate(ALCCUT1X = recode(ALCCUT1X, "1" = "Yes", "2" = "No"))



# irfamin3 -> numeric -----------------------------------------------------

data$inc_numeric = data$IRFAMIN3
data <- data %>%  
  mutate(inc_numeric = recode(inc_numeric, "Less than $10,000 (Including Loss)" = "5000", "$10,000 - $19,999" = "15000", "$20,000 - $29,999" = "25000",
                                           "$30,000 - $39,999" = "35000", "$40,000 - $49,999" = "45000", "$50,000 - $74,999" = "62500", "$75,000 or more" = "75000"))
data$inc_numeric = as.numeric(data$inc_numeric)



# Write to excel file -----------------------------------------------------

write_xlsx(data, "cleaned data.xlsx")


