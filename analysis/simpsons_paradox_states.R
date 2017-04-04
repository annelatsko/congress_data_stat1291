##Annie:
##simpson's paradox w/r/t states

path_to_file <- "C:/Users/user/congress_data_stat1291/full_data.csv"    #change this to your own path
path_to_new_members_file <- "C:/Users/user/congress_data_stat1291/new_members.csv"

##obtain data:
congress <- read.csv(path_to_file)  # read csv file
congress$bioguide <- NULL #bioguide is going to be useless to me
new.members <- read.csv(path_to_new_members_file)

congress.age <- congress$age

AL <- congress[congress$state == 'AL',]
AK <- congress[congress$state == 'AK',]
AZ <- congress[congress$state == 'AZ',]




