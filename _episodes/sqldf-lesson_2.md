---
title: Creating SQLlite databases
teaching: 90
exercises: 5
questions:
- What are databases and how do I use them.
objectives:
- Understand what a database is and when is it useful
- Understand SQL syntax using SQLlite database manager directly on data frames
- Understand how to start building a relational database
keypoints:

keypoints:
- SQL is powerful for manipulating dataframes
- "FIXME"
- "FIXME"

---

*by Katja Seltmann* with excerpts from Software Carpentry SQLite lesson.

**Supplementary Material**: 

- [answers to exercises](https://mqwilber.github.io/2017-04-21-ucsb/sqldf-answers.txt)
- [reference](https://swcarpentry.github.io/sql-novice-survey/reference/)
- [SQLite function reference](https://www.sqlite.org/lang_corefunc.html)

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
Disconnect at the end. Important if you have multiple transactions happening in an R script

    dbDisconnect(db)

***
> **Exercise 4**:
> Update the Mammalcsv table to round the adult_body_mass_g
    
