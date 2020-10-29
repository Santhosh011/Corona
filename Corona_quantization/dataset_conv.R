rm(list=ls())
getwd()
setwd("The desired directory")
library(dplyr)

df <- read.csv('covid-data.csv')

df_edited <- select(df,location,date,new_cases)

df1_edited <- df_edited%>% group_by(location) %>%
  filter(location == 'India' )

df2<-df1_edited[!(df1_edited$new_cases<100),]
write.csv(df2, "Path to which u want it to be saved")

