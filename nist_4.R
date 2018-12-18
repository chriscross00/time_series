library(tidyverse)
library(forecast)

#Read in data, skipping header. While read_table2() is more flexible than read.table(), it doesn't have a header argument
co2 <- read_table2('data/MLCO2MON.DAT.txt', skip=23)
View(co2)

clean_co2 <- co2 %>% 
  drop_na() %>%
  rename(time = 'Year&Month')
View(clean_co2)

clean_co2<- clean_co2 %>%
  mutate(CO2=as.numeric(CO2))
sapply(clean_co2, class)

summary(clean_co2)

ggplot(clean_co2, aes(time, CO2)) +
  geom_point() +
  scale_y_countinuous(breaks = )
