##Annie:
##simpson's paradox w/r/t states

path_to_file <- "C:/Users/Annie/congress_data_stat1291/full_data.csv"    #change this to your own path

##obtain data:
congress <- read.csv(path_to_file)  # read csv file
#---------------------------------------------------------------------------------------------------------------------------------------
#GLOBAL VARIABLES
years<-c(1961,1963,1965,1967,1969,1971,1973,1975,1977,1979,1981,1983,1985,1987,1989,1991,1993,1995,1997,1999,2001,2003,2005,2007,2009)
x_name<-"year"
y_name<-"mean"
state.list<- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")
#-----------------------------------------------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------
#CONGRESS ONLY STUFF (you need this to compare against)
#----------------------------------------------------------------------------------------
years<-c(1961,1963,1965,1967,1969,1971,1973,1975,1977,1979,1981,1983,1985,1987,1989,1991,1993,1995,1997,1999,2001,2003,2005,2007,2009)
congress.means<- rep(NA,25)

for(i in 1:25){
  x<-congress[congress$termstart==years[i],]
  congress.means[i]<- mean(x$age)
}

##this combines the years vector with the congress.means vector into a data frame
means.df<-data.frame(years,congress.means)
colnames(means.df)<-c(x_name,y_name)

##linear regression:
congress.fit<-lm(mean~.,data=means.df) #0.1347=slope

#------------------------------------------------------------------------------------------
#GENERATING STATE SLOPES
#-------------------------------------------------------------------------------------
slope.list<-rep(NA,50)

for(i in 1:50){
  state <- congress[congress$state == state.list[i],] ##<------------------------------NOTE THAT THE ONLY THING YOU HAVE TO CHANGE IS THIS TO GET OTHER STATES
  state.means<- rep(NA,25)
  
  for(j in 1:25){
    x<-state[state$termstart==years[j],]
    state.means[j]<- mean(x$age)
  }
  
  ##this combines the years vector with the congress.means vector into a data frame
  state.means.df<-data.frame(years,state.means)
  colnames(state.means.df)<-c(x_name,y_name)
  
  #linear regression:
  state.fit<-lm(mean~.,data=state.means.df)#0.0661=slope
  slope<-state.fit$coefficients[2]
  slope.list[i]<-slope
}
#-------------------------------------------------------------------------------------------

slopes.df <- data.frame(state.list,slope.list)
names(slopes.df) <- c("state","slope")
negative.slopes.df <- slopes.df[slopes.df$slope<0,]

#results from negative.slopes.df
#state        slope
#4     AR -0.103159341  <--------- this one looks big : TESTED WAS SIGNIFICANT W/R/T A NEGATIVE TREND
#18    LA -0.045869521
#24    MS -0.090826694  <--------- TESTED WAS SIGNIFICANT W/R/T A NEGATIVE TREND
#27    NE -0.040955128
#29    NH -0.037619231
#34    ND -0.067980128
#35    OH -0.004584404
#36    OK -0.074165133
#38    PA -0.013949213
#41    SD -0.194771795  <--------- this one does too : TESTED WAS SIGNIFICANT W/R/T A NEGATIVE TREND

install.packages("coin")
require(coin)

####Testing for Significance

##ARKANSAS
state <- congress[congress$state == 'AR',] ##<------------------------------
state.means<- rep(NA,25)

for(j in 1:25){
  x<-state[state$termstart==years[j],]
  state.means[j]<- mean(x$age)
}

##this combines the years vector with the congress.means vector into a data frame
state.means.df<-data.frame(years,state.means)
colnames(state.means.df)<-c(x_name,y_name)

#linear regression:
state.fit<-lm(mean~.,data=state.means.df)#0.0661=slope
congress.test<-independence_test(mean~.,data=state.means.df,teststat="scalar",alternative="less")
#Asymptotic General Independence Test

#data:  mean by year
#Z = -2.0364, p-value = 0.02085
#alternative hypothesis: less
##########################SIGNIFICANT NEGATIVE TREND


##South Dakota
state <- congress[congress$state == 'SD',]
state.means<- rep(NA,25)

for(j in 1:25){
  x<-state[state$termstart==years[j],]
  state.means[j]<- mean(x$age)
}

##this combines the years vector with the congress.means vector into a data frame
state.means.df<-data.frame(years,state.means)
colnames(state.means.df)<-c(x_name,y_name)

#linear regression:
state.fit<-lm(mean~.,data=state.means.df)#0.0661=slope
congress.test<-independence_test(mean~.,data=state.means.df,teststat="scalar",alternative="less")
#Asymptotic General Independence Test

#data:  mean by year
#Z = -2.659, p-value = 0.003919
#alternative hypothesis: less
############################SIGNIFICANT NEGATIVE TREND


## Mississippi
state <- congress[congress$state == 'MS',]
state.means<- rep(NA,25)

for(j in 1:25){
  x<-state[state$termstart==years[j],]
  state.means[j]<- mean(x$age)
}

##this combines the years vector with the congress.means vector into a data frame
state.means.df<-data.frame(years,state.means)
colnames(state.means.df)<-c(x_name,y_name)

#linear regression:
state.fit<-lm(mean~.,data=state.means.df)#0.0661=slope
congress.test<-independence_test(mean~.,data=state.means.df,teststat="scalar",alternative="less")
#Asymptotic General Independence Test

#data:  mean by year
#Z = -2.659, p-value = 0.003919
#alternative hypothesis: less
############################SIGNIFICANT NEGATIVE TREND

##Oklahoma
state <- congress[congress$state == 'OK',]
state.means<- rep(NA,25)

for(j in 1:25){
  x<-state[state$termstart==years[j],]
  state.means[j]<- mean(x$age)
}

##this combines the years vector with the congress.means vector into a data frame
state.means.df<-data.frame(years,state.means)
colnames(state.means.df)<-c(x_name,y_name)

#linear regression:
state.fit<-lm(mean~.,data=state.means.df)#0.0661=slope
congress.test<-independence_test(mean~.,data=state.means.df,teststat="scalar",alternative="less")
#Asymptotic General Independence Test

#data:  mean by year
#Z = -1.062, p-value = 0.1441
#alternative hypothesis: less
############################NOT A SIGNIFICANT NEGATIVE TREND