##Annie Latsko
##Stats 1291 Group Project 
##analysis of full_dataset.csv

##constants
path_to_file <- "C:/Users/Annie/congress_data_stat1291/full_data.csv"    #change this to your own path



###read in the data
congress.df <- read.csv(path_to_file)  # read csv file 
head(congress.df)


###Average age of congress per year (basically what fivethirtyeight did)
require(plyr)
avg_age_per_year <- ddply(congress.df, .(termstart), summarize,  avg_age=mean(age))
head(avg_age_per_year)

###Average age of congress per party per year (basically what fivethirtyeight did)
cols <- c("termstart","party")
avg_age_per_party_per_year <- ddply(congress.df, cols, summarize, age=mean(age))

###Average age of new members in congress
