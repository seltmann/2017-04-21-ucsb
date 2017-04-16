---
title: "Learning SQLite databases"
output: html_document
root: ../..
layout: lesson
---
  
  *by Katja Seltmann* with excerpts from Software Carpentry SQLite lesson.

**Supplementary Material**: 
  
- [answers to exercises](sqldf-answers.txt)
- [reference](http://swcarpentry.github.io/sql-novice-survey/reference.html)
- [SQLite function reference](https://www.sqlite.org/lang_corefunc.html)
- [Sandy Muspratts R Blog](http://sandymuspratt.blogspot.com/2012/11/r-and-sqlite-part-1.html)

#`Goal of this lesson`
- Introduction to creating and storing data using SQLite, data Joins, Updates and Delete

***
Getting started where we left off...
    
    mammals <- read.csv("mammal_stats.csv", header=TRUE)
    library("sqldf")
    
    ??read.csv
    

***TIP***: When you load sqldf you also load the packages RSQLite and DBI by default. DBI allows us to work in R directly with a database manager software, and RSQLite package that lets us create SQLite databases.

***
 <img src="https://s-media-cache-ak0.pinimg.com/736x/e3/e9/02/e3e90236dfce025c9f4ac9aec842f246.jpg" height="300px" align="middle"  />

***

#Joining data frames

Let's make the merge in a way we can select values from 2 different data frames and put them together in a new data frame

    mammalCounts <- sqldf("select count(*) as orderTotal, species from mammals group by `order`")
    sqldf("select count(*) from mammals where `order` = 'Afrosoricida'")
    head(mammalCounts)
    
    sqlJoinMammalsCount <- sqldf("select * from mammals join mammalCounts on mammals.species = mammalCounts.species")
    head(sqlJoinMammalsCount)
    
    sqlJoinMammalsCount <- sqldf("select mammals.*,mammalCounts.orderTotal from mammals join mammalCounts on mammals.species=mammalCounts.species")
    head(sqlJoinMammalsCount)
    
***

# Update and Delete values from a data frame

***
Update a data frame by merging and overwriting the first dataframe

    sql1 <- "update sqlJoinMammalsCount set `order`='Primates' where species='Dromiciops gliroides'"
    
    sql2 <- "select * from sqlJoinMammalsCount"
    
   sqlJoinMammalsCount <- sqldf(c(sql1, sql2))
    
***
Delete values

    sqlJoinMammalsCount <- sqldf(c("delete from sqlJoinMammalsCount where `order`='Dermoptera'", "select * from sqlJoinMammalsCount"))

    head(sqlJoinMammalsCount)
    
***
Insert a value
    sqlJoinMammalsCount <- sqldf(c("insert into sqlJoinMammalsCount values (1,'Primates','New primate', 55.00,'',134,2,4)","select * from sqlJoinMammalsCount"))

    head(sqlJoinMammalsCount)
    
    sqldf("select * from sqlJoinMammalsCount where species='New Primate'")
    
    *** 
> **Exercise 3**:
> Insert a new record where litter size is NA

***TIP***: NA is NULL in SQL

***

#Create a SQLite database

    db <- dbConnect(SQLite(), dbname="Mammaldb.sqlite")
 
***
 Attach the database to R
 
    sqldf("attach 'Mammaldb.sqlite' as new")
    
***
Create a table manually

    dbSendQuery(conn = db,
    "CREATE TABLE Mammal
    (TaxonOrder TEXT,
    species TEXT,
    mass NUMERIC,
    length NUMERIC,
    range NUMERIC,
    litterSize NUMERIC)")

***TIP***: SQLite supports TEXT, NUMERIC, INTEGER, REAL, BLOB [data types](https://www.sqlite.org/datatype3.html). 

***
Reading database tables

    dbListTables(db)
    dbListFields(db, "Mammal")


***
Insert a single record

 db <- dbConnect(SQLite(), dbname="Mammaldb.sqlite")
 
    dbSendQuery(conn = db,"insert into Mammal values ('Primates','New primate-2', 55.00,'',134,2)")
         
    sqldf(c("insert into Mammal values ('Primates','New primate', 55.00,'',134,2)","select * from Mammal"), dbname = "Mammaldb.sqlite")
    
***
Select from database using sqldf and SQLite syntax

    sqldf("SELECT * FROM Mammal limit 10", dbname = "Mammaldb.sqlite") 
    dbReadTable(db, "Mammal")

***
Drop database table

    dbRemoveTable(db, "Mammal")
    
***

***remember***: we have a data frame called mammals.

    mammals <- read.csv("mammal_stats.csv", header=TRUE)
    head(mammals)

***
Insert the data frame into the database

    dbWriteTable(conn = db, name = "Mammalcsv", value = mammals, row.names = TRUE)
    
***
Disconnect at the end. Important if you have mulitple transactions happening in an R script

    dbDisconnect(db)

***
> **Exercise 4**:
> Update the Mammalcsv table to round the adult_body_mass_g
    
