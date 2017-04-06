#Annie Latsko
#Simpson's Paradox for Parties

path_to_file <- "C:/Users/Annie/congress_data_stat1291/full_data.csv"    #change this to your own path
path_to_new_members <- "C:/Users/Annie/congress_data_stat1291/AG_Final_New_Member_Data.csv"


##obtain data:
congress <- read.csv(path_to_file)  # read csv file
new_members <- read.csv(path_to_new_members)

#GLOBAL VARIABLES
years<-c(1961,1963,1965,1967,1969,1971,1973,1975,1977,1979,1981,1983,1985,1987,1989,1991,1993,1995,1997,1999,2001,2003,2005,2007,2009)
x_name<-"year"
y_name<-"mean"

################################################ CONGRESS
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

############################################### PARTIES
reps <- congress[congress$party == 'R',]
dems <- congress[congress$party == 'D',]
inds <- congress[congress$party == 'I',]


rep.means <- rep(NA, 25)
for(i in 1:25){
  x<-reps[reps$termstart==years[i],]
  rep.means[i]<- mean(x$age)
}

dem.means <- rep(NA, 25)
for(i in 1:25){
  x<-dems[dems$termstart==years[i],]
  dem.means[i]<- mean(x$age)
}

ind.means <- rep(NA, 25)
for(i in 1:25){
  x<-inds[inds$termstart==years[i],]
  ind.means[i]<- mean(x$age)
}

r.means.df<-data.frame(years,rep.means)
colnames(r.means.df)<-c(x_name,y_name)
rep.fit<-lm(mean~.,data=r.means.df)
summary(rep.fit) #0.08628=slope

d.means.df<-data.frame(years,dem.means)
colnames(d.means.df)<-c(x_name,y_name)
dem.fit<-lm(mean~.,data=d.means.df)
summary(dem.fit) #0.09381=slope

i.means.df<-data.frame(years,ind.means)
colnames(i.means.df)<-c(x_name,y_name)
ind.fit<-lm(mean~.,data=i.means.df)
summary(ind.fit) #0.36657=slope
