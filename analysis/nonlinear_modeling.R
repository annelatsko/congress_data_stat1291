#Annie Latsko
#Nonlinear Modeling

#file imports:
path_to_file <- "C:/Users/user/congress_data_stat1291/full_data.csv"    #change this to your own path
path_to_new_members_file <- "C:/Users/user/congress_data_stat1291/new_members.csv"

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

##stepwise
train<-sample(length(congress$age),length(congress$age)/2)
test<--train
congress.train<-congress[train,]
congress.test<-congress[test,]
congress.test<-congress.test[-nrow(congress.test),]
fit<-regsubsets(age~termstart+chamber+party+state+GDP,data=congress.train,nvmax=17,method="forward")
fit.summary<-summary(fit)
fit.summary #8 variables seems to minimize the Cp and BIC
fit<-regsubsets(age~termstart+chamber+party+state+GDP,data=congress,method="forward")
coefs<- coef(fit,id=8)
names(coefs) #"termstart"     "chambersenate" "partyR"        "stateIN"      "stateME"       "stateNC"       "stateOK"       "GDP"
#literally just see the stuff for forward stepwise regression

##GAMs
fit<-gam(age~s(termstart,df=2)+chamber+party+state+s(GDP,df=2),data=congress.train)
preds<-predict(fit,congress.train)
err<-mean((congress.test$age-preds)^2) #this will give an error but nbd
tss<-mean((congress.test$age-mean(congress.test$age))^2)
rss<-1-err/tss
rss #-0.1068608
##NOTE THAT THE GAME WE FIT HAS A NEGATIVE RSS MEANING THAT IT FITS WORSE THAN A HORIZONTAL LINE

##splines

#natural splines
cvs<-rep(NA,15)
for(i in 5:15){
  fit<-glm(age~ns(termstart,df=i)+chamber+party+state+GDP,data=congress)
  cvs[i]<-cv.glm(congress,fit,K=10)$delta[1]
}
fit<-lm(age~ns(termstart,df=8)+chamber+party+state+GDP,data=congress)
summary(fit)
#this gives a multiple r2 of 0.1121

#specified splines on the decade
fit<-lm(age~ns(termstart,knots=c(1970,1980,1990,2000))+chamber+party+state+GDP,data=congress)
summary(fit)
#this gives a multiple r2 of 0.1107