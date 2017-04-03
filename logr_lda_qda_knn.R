#Annie Latsko
#Logistic Regression, LDA, QDA, and KNN

#file imports:
path_to_file <- "C:/Users/user/congress_data_stat1291/full_data.csv"    #change this to your own path
path_to_new_members_file <- "C:/Users/user/congress_data_stat1291/new_members.csv"

##obtain data:
congress <- read.csv(path_to_file)  # read csv file
congress$bioguide <- NULL #bioguide is going to be useless to me
new.members <- read.csv(path_to_new_members_file)


##LOGISTIC REGRESSION:
congress.copy<-congress
divider_mean <- 25 + (98.1-25)/2 #this gets us the halfway point between the min age (25) and the max age (98.1)
divider_median <- median(congress$age)
congress.copy$agegroup_mean<-ifelse(as.numeric(congress.copy$age)>divider_mean, 1,0)
congress.copy$agegroup_median<-ifelse(as.numeric(congress.copy$age)>divider_median,1,0)
#old = 1, young = 0
set.seed(17)
train_index <- sample(seq_len(nrow(congress.copy)), size = 13000)
train <- congress.copy[train_index,]
test <- congress.copy[-train_index,]
#mean
glm.fit.mean<-glm(agegroup_mean~termstart+chamber+party+state+GDP, data=train)
glm.probs.mean <- predict(glm.fit.mean,test,type="response")
glm.pred.mean<-rep("younger_half",675)
glm.pred.mean[glm.probs.mean>0.5]<-"older_half"
table(glm.pred.mean,test$agegroup_mean)
(543 + 0)/675 #0.8044 ????
#median
glm.fit.median<-glm(agegroup_median~termstart+chamber+party+state+GDP, data=train, family=binomial)
glm.probs.median <- predict(glm.fit.median,test,type="response")
glm.pred.median<-rep("younger_half",675)
glm.pred.median[glm.probs.median>0.5]<-"older_half"
table(glm.pred.median,test$agegroup_median)
(250 + 155)/675 #0.6


##LDA
agegroup_mean <- train$agegroup_mean
lda.fit.mean <- lda(agegroup_mean~termstart+chamber+party+state+GDP, data=train)
lda.fit.median <- lda(agegroup_median~termstart+chamber+party+state+GDP, data=train)
lda.pred.mean <- predict(lda.fit.mean, test)
lda.pred.median <- predict(lda.fit.median, test)
lda.class.mean <- lda.pred.mean$class
lda.class.median <- lda.pred.median$class
table(lda.class.mean,test$agegroup_mean)
table(lda.class.median,test$agegroup_median)
mean(lda.class.mean==test$agegroup_mean) #0.8088889
mean(lda.class.median==test$agegroup_median) #0.6 #both are basically the same as logreg
