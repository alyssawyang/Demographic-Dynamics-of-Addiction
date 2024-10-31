library(dplyr)
library(readxl)
library(odds.n.ends)

# Read in data
data <- read_xlsx("cleaned data.xlsx")
data <- data[, c("ALCCUT1X", "alccutdn", "irsex", "NEWRACE2", "inc_numeric")]
View(data)
attach(data)

# Change ALCCUT1X to 1,0 instead of 1,2
data <- data %>%
  mutate(ALCCUT1X = recode(ALCCUT1X, "Yes" = "1", "No" = "0"))



# Change all except inc_numeric to factors
ALCCUT1X = as.factor((ALCCUT1X))
alccutdn = as.factor(alccutdn)
irsex = as.factor(irsex)
NEWRACE2 = as.factor(NEWRACE2)

class(ALCCUT1X)
class(alccutdn)
class(irsex)
class(NEWRACE2)
class(inc_numeric)

# Logistic regression
logistic_reg <- glm(ALCCUT1X ~ alccutdn + irsex + NEWRACE2 + inc_numeric, family = binomial("logit"))
summary(logistic_reg)

odds.n.ends(logistic_reg)






