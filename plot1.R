library(stringr)
library(dplyr)
library(tidyverse)
library(mice)
# read data
hpc<- read.csv("~/Desktop/ExData_Plotting1/household_power_consumption.txt", 
               header=TRUE, sep=";")
# find 2007/02/01-02 data
one<-hpc%>%
  filter(Date=="1/2/2007")
two<-hpc%>%
  filter(Date=="2/2/2007")
# combine two days' data
twodays<-bind_rows(one,two)
# check missing value
md.pattern(twodays)
questionmark<-c("?")
questionmark %in% twodays

str(twodays)
twodays$Global_active_power<-as.numeric(twodays$Global_active_power)
#plot 1
png(filename="plot1.png",width=480,height=480,unit="px")
hist(twodays$Global_active_power, main="Global Active Power",col="red",
     xlab="Global Active Power(kilowatts)",ylim = c(0,1300))
dev.off()








