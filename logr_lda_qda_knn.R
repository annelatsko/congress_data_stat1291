#Annie Latsko
#Logistic Regression, LDA, QDA, and KNN

#file imports:
path_to_file <- "C:/Users/Annie/congress_data_stat1291/full_data.csv"    #change this to your own path
path_to_new_members_file <- "C:/Users/Annie/congress_data_stat1291/new_members.csv"

##obtain data:
congress <- read.csv(path_to_file)  # read csv file
congress$bioguide <- NULL #bioguide is going to be useless to me
new.members <- read.csv(path_to_new_members_file)


##LOGISTIC REGRESSION:
congress.copy<-congress
divider <- 25 + (98.1-25)/2 #this gets us the halfway point between the min age (25) and the max age (98.1)
congress.copy$agegroup<-ifelse(as.numeric(congress.copy$age)>divider, 1,0) # this is what you want
#old = 1, young = 0
glm.fit <- glm(agegroup~termstart+chamber+party+state+GDP, data=congress.copy)
glm.probs <- predict(glm.fit,type="response")
glm.pred <- rep("younger_half",13675)
glm.pred[glm.probs>0.5]<-"older_half"
table(glm.pred,congress.copy$agegroup)
(10699 + 69)/13675 #this is the percent correct the training model got (0.7874223)

set.seed(17)
train_index <- sample(seq_len(nrow(congress.copy)), size = 13000)
train <- congress.copy[train_index,]
test <- congress.copy[-train_index,]
glm.fit<-glm(agegroup~termstart+chamber+party+state+GDP, data=train)
glm.probs <- predict(glm.fit,test,type="response")
glm.pred<-rep("younger_half",675)
glm.pred[glm.probs>0.5]<-"older_half"
table(glm.pred,test)
