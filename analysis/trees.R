#Annie Latsko
#trees



#file imports:
path_to_file <- "C:/Users/Annie/congress_data_stat1291/full_data.csv"    #change this to your own path
path_to_new_members_file <- "C:/Users/Annie/congress_data_stat1291/new_members.csv"

##obtain data:
congress <- read.csv(path_to_file)  # read csv file
congress$bioguide <- NULL #bioguide is going to be useless to me


##classification trees:
#-> not relevant

##regression trees:
set.seed(16)

train<- sample(1:nrow(congress),nrow(congress)/2)
tree.congress<-tree(age~termstart+chamber+party+GDP,data=congress,subset=train) #note lack of state: this is due to factor predictors only being able to have 32 levels
summary(tree.congress) #only chamber and termstart are actually used in tree construction
                       #number of terminal nodes
cv.congress<-cv.tree(tree.congress)
prune.congress<-prune.tree(tree.congress,best=2)
yhat<-predict(tree.congress,newdata=congress[-train,])
congress.test<-congress[-train,"age"]
mean((yhat-congress.test)^2)
#the test MSE associated with the regression tree is 105.9342
sqrt(105.9342) #10.29243, meaning that this model leads to test predictions that are within 10 years of the true age (bad)

##bagging
set.seed(16)
bag.congress<-randomForest(age~termstart+chamber+party+state+GDP,data=congress,subset=train,mtry=5,importance=T)
bag.congress
#% var explained = 3.72 wow me too this is soooo bad
yhat.bag<-predict(bag.congress,newdata=congress[-train,])
mean((yhat.bag-congress.test)^2)
#test mse: 106.0736

##randomForest
bag.congress<-randomForest(age~termstart+chamber+party+state+GDP,data=congress,subset=train,mtry=2,importance=T)
bag.congress #12.86 % variance explained
yhat.bag<-predict(bag.congress,newdata=congress[-train,])
mean((yhat.bag-congress.test)^2) #96.57069 = test mse
importance(bag.congress) #chamber and state are around 100, termstart, part, and GDP are much lower

#boosting
set.seed(16)
boost.congress<-gbm(age~termstart+chamber+party+state+GDP,data=congress[train,],distribution="gaussian",n.trees=5000,interaction.depth=4)
yhat.boost<-predict(boost.congress,newdata=congress[-train,],n.trees=5000)
mean((yhat.boost-congress.test)^2) #97.12298