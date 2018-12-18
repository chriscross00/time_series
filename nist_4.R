library(tidyverse)
library(forecast)

#Read in data, skipping header. While read_table2() is more flexible than read.table(), it doesn't have a header argument
co2 <- read_table2('data/MLCO2MON.DAT.txt', skip=23)
View(co2)

#Simple cleaning of the data, dropping rows with NAs
clean_co2 <- co2 %>% 
  drop_na() %>%
  rename(time = 'Year&Month')
View(clean_co2)

#For some reason col CO2 got read in as a char so i'm changing it into a numeric
clean_co2<- clean_co2 %>%
  mutate(CO2=as.numeric(CO2))
sapply(clean_co2, class)

summary(clean_co2)
#I had to change the y-axis a bit to clean it up but this is a pretty good picture of the data.
ggplot(clean_co2, aes(time, CO2)) +
  geom_point() +
  scale_y_continuous(breaks = seq(300, 400, 10))
