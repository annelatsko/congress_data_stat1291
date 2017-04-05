##Annie:
##simpson's paradox w/r/t states

path_to_file <- "C:/Users/user/congress_data_stat1291/AG_Final_New_Member_Data.csv"    #change this to your own path

##obtain data:
congress <- read.csv(path_to_file)  # read csv file
#GLOBAL VARIABLES
years<-c(1961,1963,1965,1967,1969,1971,1973,1975,1977,1979,1981,1983,1985,1987,1989,1991,1993,1995,1997,1999,2001,2003,2005,2007,2009)
x_name<-"year"
y_name<-"mean"
#---------------------------------------------------------------------------------------
#CONGRESS ONLY STUFF (you need this to compare against)
#----------------------------------------------------------------------------------------
years<-c(1961,1963,1965,1967,1969,1971,1973,1975,1977,1979,1981,1983,1985,1987,1989,1991,1993,1995,1997,1999,2001,2003,2005,2007,2009)
congress.means<- rep(NA,25)

for(i in 1:25){
  x<-congress[congress$First.Term==years[i],]
  congress.means[i]<- mean(x$Age.First.Term)
}

##this combines the years vector with the congress.means vector into a data frame
require(reshape2)
means.df<-data.frame(years,congress.means)
colnames(means.df)<-c(x_name,y_name)

##linear regression:
congress.fit<-lm(mean~.,data=means.df) #0.1347=slope

#------------------------------------------------------------------------------------------
#STATE EXAMPLE
#-------------------------------------------------------------------------------------
AL <- congress[congress$state == 'AL',]
AL.means<- rep(NA,25)

for(i in 1:25){
  x<-AL[AL$First.Term==years[i],]
  AL.means[i]<- mean(x$Age.First.Term)
}

AL[AL$First.Term==years[3],]$Age.First.Term

##this combines the years vector with the congress.means vector into a data frame
require(reshape2)
AL.means.df<-data.frame(years,AL.means)
colnames(AL.means.df)<-c(x_name,y_name)

##linear regression:
AL.fit<-lm(mean~.,data=AL.means.df) #0.05695=slopes
anova(congress.fit,AL.fit)






