rm(list=ls())

library('RPostgreSQL')


drv <- dbDriver('PostgreSQL')
con <- dbConnect(drv,
host = "dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com",
dbname = "training_2015",
user = "ahuja",
password = "ahuja")
data <- dbGetQuery(con, "SELECT * FROM ahuja.building_violations_sample;")
dbDisconnect(con)

head(data)
tail(data)
dim(data)
sapply(data, class)
sapply(data, length)
