#READING Data from CSV
data_csv<-read.csv('/Users/hlamba/Documents/DSSG/Project_Week1/AgentSmith/Data/Building_Violations_sample_50000.csv')

#LOADING PostGreSQL
library('RPostgreSQL')
drv<-dbDriver('PostgreSQL')
con<-dbConnect(drv,
               host="dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com",
               dbname="training_2015",
               user="lamba",
               password="lamba")

data_sql<-dbGetQuery(con,"select * from hemank_lamba.building_violations_sample_50000")
#Disconnecting the Connection.
dbDisconnect(con)

data<-data_sql

#Viewing Data
head(data)
tail(data)
dim(data)
summary(data)
sapply(data,class)

#Renaming columns in the data
names(data)<-gsub(" ",".",names(data))

#Removing Columns
data <- data[,!(names(data) %in% 'SSA')]

data$ID
data['ID']
data[c('ID','VIOLATION_CODE')]

#Converting factor into date.
data$VIOLATION.DATE <- as.character(data$VIOLATION.DATE)
data$VIOLATION.DATE <- as.Date(data$VIOLATION.DATE, format = '%m/%d/%Y')
class(data$VIOLATION.DATE)
head(data$VIOLATION.DATE)

#Null Data
sum(is.na(data$VIOLATION.INSPECTOR.COMMENTS))
comment_breakdown <- table(data$VIOLATION.INSPECTOR.COMMENTS)
comment_breakdown_sorted <- sort(comment_breakdown, decreasing = TRUE)
data$VIOLATION.INSPECTOR.COMMENTS[ data$VIOLATION.INSPECTOR.COMMENTS == '' ] <- NA


#Applying FUnctions
data$log_latitude <- log(data$LATITUDE)
data$new_latitude <- data$LATITUDE + rnorm(length(data$LATITUDE))
head(data[c('LATITUDE', 'new_latitude')])

