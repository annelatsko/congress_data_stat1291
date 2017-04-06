#Annie Latsko
#best subset selection, lasso, and ridge

#file imports:
path_to_file <- "C:/Users/Annie/congress_data_stat1291/full_data.csv"    #change this to your own path

##obtain data:
congress <- read.csv(path_to_file)  # read csv file
congress$bioguide <- NULL #bioguide is going to be useless to me


##best subset selection
regfit.full <- regsubsets(age ~ termstart+chamber+party+state+GDP, data=congress, really.big=500)
reg.summary <- summary(regfit.full)
max <- which.max(reg.summary$adjr2) #results in max = 8
coef(regfit.full, max)
#results of above are:
#y = 602.914 + -0.2807(termstart) + 5.1863(chamber) + -0.9913(party) + -3.425(Indiana) + -5.8890(Maine) + 3.0309(North Carolina) + -4.5460(Oklahoma) + 0.001237(GDP)  

##Forwards and Backwards Stepwise Selection:
regfit.fwd <- regsubsets(age ~ termstart+chamber+party+state+GDP,data=congress,nvmax=8,method="forward")
#limiting to 8 for the sake of interpretabiliy
summary(regfit.fwd)
#best 1 var model: chamber
#best 2 var model: chamber + GDP
#best 3 var model: chamber + GDP + termstart 
#best 4 var model: chamber + GDP + termstart + OK
#best 5 var model: chamber + GDP + termstart + OK + IN
#best 6 var model: chamber + GDP + termstart + OK + IN + ME
#best 7 var model: chamber + GDP + termstart + OK + IN + ME + party(republican)
#best 8 var model: chamber + GDP + termstart + OK + IN + ME + party(republican) + NC


regfit.bwd<- regsubsets(age ~ termstart+chamber+party+state+GDP,data=congress,nvmax=8,method="backward")
summary(regfit.bwd)
#best 1 var model: chamber
#best 2 var model: chamber + GDP
#best 3 var model: chamber + GDP + termstart 
#best 4 var model: chamber + GDP + termstart + OK
#best 5 var model: chamber + GDP + termstart + OK + IN
#best 6 var model: chamber + GDP + termstart + OK + IN + ME
#best 7 var model: chamber + GDP + termstart + OK + IN + ME + party(republican)
#best 8 var model: chamber + GDP + termstart + OK + IN + ME + party(republican) + NC


##note that the exact same mode is produced for forward AND backward selection

##Choosing the best model using cross validation
set.seed(16)
train <- sample(c(TRUE,FALSE),nrow(congress),rep=TRUE)
test<-(!train)

regfit.best<-regsubsets(age~termstart+chamber+party+state+GDP,data=congress[train,],nvmax=8,really.big=500)
test.mat<-model.matrix(age~termstart+chamber+party+state+GDP,data=congress[test,])
val.errors<-rep(NA,8)
for(i in 1:8){coefi=coef(regfit.best,id=i)
pred<-test.mat [,names(coefi)]%*% coefi
val.errors[i]<-mean((congress$age[test]-pred)^2)
}
which.min(val.errors) #result is 7
coef(regfit.best,7)
regfit.best<-regsubsets(age~termstart+chamber+party+state+GDP,data=congress,nvmax=8,really.big=T)
coef(regfit.best,7)
#result of above:
#BEST MODEL: y = 603.369706735 +-0.280877569(termstart) + 5.167036169(chambersenate) + -1.005317810(partyR) + -3.504502013(stateIN) + -5.961384878(stateME) + -4.623567832(stateOK) + 0.001239108(GDP) 
#RSS: 1516168

##Ridge Regression
x<-model.matrix(age~termstart+chamber+party+state+GDP,congress)[,-1]
y<-congress$age

grid<-10^seq(10,-2,length=100) #sets up lambdas
ridge.mod<-glmnet(x,y,alpha=0,lambda=grid)
set.seed(16)
train<-sample(1:nrow(x),nrow(x)/2)
test<-(-train)
y.test<-y[test]
ridge.mod<-glmnet(x[train,],y[train],alpha=0,lambda=grid,thresh=1e-12)
  #choosing the value of lambda
set.seed(16)
cv.out<-cv.glmnet(x[train,],y[train],alpha=0)
bestlambda<-cv.out$lambda.min
bestlambda #0.2315731
ridge.pred<-predict(ridge.mod,s=bestlambda,newx=x[test,])
mean((ridge.pred-y.test)^2) #100.8076


##Lasso
lasso.mod<-glmnet(x[train,],y[train],alpha=1,lambda=grid)
set.seed(16)
cv.out<-cv.glmnet(x[train,],y[train],alpha=1)
bestlam<-cv.out$lambda.min
lasso.pred<-predict(lasso.mod,s=bestlam,newx=x[test,])
mean((lasso.pred-y.test)^2) #100.5631
out<-glmnet(x,y,alpha=1,lambda=grid)
lasso.coef<-predict(out,type="coefficients",s=bestlam)[1:55,]
lasso.coef #this checks to see if lasso did any variable selection
#the only coefficient that is exactly zero is stateWY weeeird

##PCR
set.seed(16)
pcr.fit<-pcr(age~termstart+chamber+party+state+GDP,data=congress,subset=train,scale=TRUE,validation="CV")
validationplot(pcr.fit,val.type="MSEP") #shows that 53 variables is where the CV error bottoms out?
pcr.pred<-predict(pcr.fit,x[test,],ncomp=53)
mean((pcr.pred-y.test)^2) #100.6056 
pcr.fit<-pcr(y~x,scale=TRUE,ncomp=53)
summary(pcr.fit)
#with 53 variables, 10.71% of variance is explained
#yeah, idk if fitting the PCR on 53 variables is really a good idea, plus it gives us no real improvement w/r/t test MSE

##PLS
set.seed(16)
pls.fit<-plsr(age~termstart+chamber+party+state+GDP,data=congress,subset=train,scale=TRUE,validation="CV")
summary(pls.fit) #ok, lowest CV error is at 7 comps (M=7)
pls.pred<-predict(pls.fit,x[test,],ncomp=7)
mean((pls.pred-y.test)^2) #100.5939
pls.fit<-plsr(age~termstart+chamber+party+state+GDP,data=congress,scale=TRUE,ncomp=7)
summary(pls.fit)
#lmao, it explains 10.72% of variance

##SUMMARY: Lasso explains has the lowest test MSE by just a smidge.
##         when comparing PCR to PLS, PLS is simpler and explains 0.01 more variance than PCR
