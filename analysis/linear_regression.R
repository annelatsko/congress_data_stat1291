#Annie Latsko
#zoopin' thru the tests
#LINEAR REGRESSION

#file imports:
path_to_file <- "C:/Users/user/congress_data_stat1291/AG_Final_New_Member_Data.csv"    #change this to your own path

##obtain data:
congress <- read.csv(path_to_file)  # read csv file
congress$bioguide <- NULL #bioguide is going to be useless to me
congress$incumbent <- NULL

##simple least squares: SINGLE PREDICTOR (all of these are shit)
lm.fit.termstart <- lm(age~termstart, data=congress) #r2 = 0.01489
lm.fit.chamber <- lm(age~chamber, data=congress) #r2 = 0.03513
lm.fit.party <- lm(age~party, data=congress) #r2 = 0.001264
lm.fit.state <- lm(age~state, data=congress) #r2 = 0.0331

plot(congress$termstart,congress$age) #ugly ass plot w/data all over the place
abline(lm.fit.termstart)
plot(congress$chamber,congress$age) #boxplot, mean of house lower than mean of senate
plot(congress$party,congress$age) #3 boxplots (for d, i, and r)
plot(congress$state,congress$age) #50 boxplots, INTERESTING VISUAL
#################################################################################
#I briefly considered trying to fit all of the possible models.
#The internet was VERY against this (data dredging), plus it seemed tedious AF
#################################################################################

##multiple least squares: ORIGINAL DATA (termstart,chamber,party,state)
#note that this checks each state individually (and some of them are significant, which is weird)
lm.fit.og <- lm(age~termstart+chamber+party+state, data=congress) #r2 = 0.08795

##multiple least squares: FULL DATA 
#below found that in this model, GDP is significant at highest level but nothing else is if you use an alpha of 0.05
#probably just leave them out
lm.fit.full <- lm(age~chamber+state+party+Annual.GPD.Percent.Change+working.age+X65.and.Older, data=congress) #r2 = 0.1814, but the improvement prolly just due to inclusion of variables

##multiple least squares: STUFF THAT LOOKED IMPORTANT (termstart,chamber,party,state,gdp)
#let's call this the best dataset
lm.fit.important <- lm(age~termstart+chamber+party+state+GDP, data=congress) #r2 = 0.1074

#INTERACTIONS:
#I kind of suggest that we don't do this. I don't think it really makes any sense.

#NONLINEAR TRANSFORMATIONS
lm.transformation <- lm(age~termstart+chamber+party+state+GDP+log(GDP), data=congress) #r2 = 0.1086 (made it slightly better)
anova(lm.fit.important,lm.transformation) #f-statistic = 19.149, p-value is near 0, suggesting that by adding the log term, we can improve the fit.

lm.poly <- lm(age~termstart+chamber+party+state+GDP+poly(GDP,5), data=congress) #all of the terms (2-5) are significant?, w/ r2 = 0.1107
#the above fit is better but the improvement might just be due to the fact that we added 5 more variables.

#CONCLUSION:
#I would suggest going with predicting age based off termstart, chamber, party, state, and GDP for the sake of parsimony.




