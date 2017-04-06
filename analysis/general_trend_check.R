#Annie Latsko


path_to_file <- "C:/Users/Annie/congress_data_stat1291/full_data.csv"    #change this to your own path
path_to_new_members <- "C:/Users/Annie/congress_data_stat1291/AG_Final_New_Member_Data.csv"


##obtain data:
congress <- read.csv(path_to_file)  # read csv file
new_members <- read.csv(path_to_new_members)


install.packages("coin")
require(coin)

congress.test<-independence_test(age~termstart,data=congress,teststat="scalar",alternative="greater")
#Asymptotic General Independence Test

#data:  age by termstart
#Z = 14.267, p-value < 2.2e-16
#alternative hypothesis: greater


new.members.test<-independence_test(age~termstart,data=new_members,teststat="scalar",alternative="greater")
#Asymptotic General Independence Test

#data:  age by termstart
#Z = 9.2944, p-value < 2.2e-16
#alternative hypothesis: greater

