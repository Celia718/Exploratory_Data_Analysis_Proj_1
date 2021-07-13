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
twodays$Time<-strptime(paste(twodays$Date,twodays$Time),"%d/%m/%Y %H:%M:%S")
twodays$Date<-as.Date(twodays$Date,"%d/%m/%Y")
twodays$Global_active_power<-as.numeric(twodays$Global_active_power)

#plot 4
png(filename="plot4.png",width=480,height=480,unit="px")

par(mfrow=c(2,2))

plot(twodays$Time,twodays$Global_active_power,type = "l", 
     xlab="",ylab="Global Active Power") #(1,1)

plot(twodays$Time,twodays$Voltage,type = "l", 
     ylab="Voltage",xlab="datetime") #(1,2)

plot(twodays$Time, twodays$Sub_metering_3, type="l",col="blue",
     xlab="",ylab="Energy Sub metering",ylim=c(0,30))
lines(twodays$Time, twodays$Sub_metering_1,col="black")
lines(twodays$Time, twodays$Sub_metering_2,col="red")
legend("topright",col=c("black","red","blue"),lwd=1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) #(2,1)

plot(twodays$Time,twodays$Global_reactive_power,type = "l", 
     ylab="Global_reactive_power",xlab="datetime") #(2,2)

dev.off()






