#Annie Latsko
#best subset selection, lasso, and ridge

#file imports:
path_to_file <- "C:/Users/user/congress_data_stat1291/full_data.csv"    #change this to your own path
path_to_new_members_file <- "C:/Users/user/congress_data_stat1291/new_members.csv"

##obtain data:
congress <- read.csv(path_to_file)  # read csv file
congress$bioguide <- NULL #bioguide is going to be useless to me
new.members <- read.csv(path_to_new_members_file)


##best subset selection
regfit.full <- regsubsets(age ~ termstart+chamber+party+state+GDP, data=congress, really.big=500)
reg.summary <- summary(regfit.full)
max <- which.max(reg.summary$adjr2) #results in max = 8
coef(regfit.full, max)
#results of above are:
#y = 602.914 + -0.2807(termstart) + 5.1863(chamber) + -0.9913(party) + -3.425(Indiana) + -5.8890(Maine) + 3.0309(North Carolina) + -4.5460(Oklahoma) + 0.001237(GDP)  

##Forwards and Backwards Stepwise Selection:
regfit.fwd <- regsubsets(age ~ termstart+chamber+party+state+GDP,data=congress,nvmax=15,method="forward")
regfit.bwd<- regsubsets(age ~ termstart+chamber+party+state+GDP,data=congress,nvmax=15,method="backward")
summary(regfit.fwd)
