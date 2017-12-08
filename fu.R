library(ggplot2)
library(forecast)
library(ggfortify)
library(timeSeries)

lyme=read.csv("/Users/gcgibson/Desktop/lyme/lymedata2.csv",header=T)
lyme$X2011<- as.integer(lyme$X2011)
lyme$X2012<- as.integer(lyme$X2012)

ts<- ts(t(lyme[,2:11]))
autoplot(ts) + xlab("Year") + ylab("Lyme Incidence") + scale_x_discrete(limits=c("2006","2007","2008", "2009","2010","2011","2012","2013","2014","2015")) + scale_colour_discrete(name="State", labels=c("Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming")) + theme(text = element_text(size=9), axis.text.x = element_text(angle=90, hjust=1))

ts.plot(ts)

#Let 1 = Northeast
#Let 2 = Midwest
#Let 3 = South
#Let 4 = West
lyme$Region<- c(3,4,4,3,4,4,1,3,3,3,4,4,2,2,2,2,3,3,1,3,1,2,2,3,2,4,2,4,1,1,4,1,3,2,2,3,4,1,1,3,2,3,3,4,1,3,4,3,2,4)
lyme$Region<- as.factor(lyme$Region)

aggregate<- aggregate(cbind(X2006,X2007,X2008,X2009,X2010,X2011,X2012,X2013,X2014,X2015)~Region, data=lyme, sum)

ts2<- ts(t(aggregate[,2:11]))

autoplot(ts2)+ xlab("Year") + ylab("Lyme Incidence") + scale_x_discrete(limits=c("2006","2007","2008", "2009","2010","2011","2012","2013","2014","2015")) + scale_colour_discrete(name="Region", labels=c("1","2","3","4")) + theme(text = element_text(size=9), axis.text.x = element_text(angle=90, hjust=1))

