#Annie Latsko
#Nonlinear Modeling

#file imports:
path_to_file <- "C:/Users/Annie/congress_data_stat1291/full_data.csv"    #change this to your own path
path_to_new_members_file <- "C:/Users/Annie/congress_data_stat1291/new_members.csv"

##obtain data:
congress <- read.csv(path_to_file)  # read csv file
congress$bioguide <- NULL #bioguide is going to be useless to me
new.members <- read.csv(path_to_new_members_file)


##polynomial regression
#i'm going to go up to a fifth degree polynomial for termstart and gdp to see if it does anything interesting
fit.without.polynomials<-lm(age~termstart+chamber+party+state+GDP,data=congress)
fit.2.termstart<-lm(age~poly(termstart,2)+chamber+party+state+GDP,data=congress)
fit.2.gdp<-lm(age~termstart+chamber+party+state+poly(GDP,2),data=congress)
fit.3.termstart<-lm(age~poly(termstart,3)+chamber+party+state+GDP,data=congress)
fit.3.gdp<-lm(age~termstart+chamber+party+state+poly(GDP,3),data=congress)
fit.4.termstart<-lm(age~poly(termstart,4)+chamber+party+state+GDP,data=congress)
fit.4.gdp<-lm(age~termstart+chamber+party+state+poly(GDP,4),data=congress)
fit.5.termstart<-lm(age~poly(termstart,5)+chamber+party+state+GDP,data=congress)
fit.5.gdp<-lm(age~termstart+chamber+party+state+poly(GDP,5),data=congress)

anova(fit.without.polynomials,fit.2.termstart,fit.3.termstart,fit.4.termstart,fit.5.termstart,fit.2.gdp,fit.3.gdp,fit.4.gdp,fit.5.gdp)
#this checks to see if they are significant - all are significant except for fit.3.termstart
#I think this is due to the fact that congress$age, when plotted, is a big wall of data

##splines

