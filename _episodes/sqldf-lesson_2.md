---
title: Creating SQLlite databases
teaching: 90
exercises: 5
questions:
- What are databases and how do I use them.
objectives:
- Understand the difference between SQLlite database and data frames
- Commit database to GitHub
keypoints:

keypoints:
- Databases work better when your data gets bigger, but you can do the same tasks in data frames or databases.

---

*by Katja Seltmann* with excerpts from Software Carpentry SQLite lesson.

**Supplementary Material**: 

- [answers to exercises](https://seltmann.github.io/2018-04-05-ucsb/sqldf-answers.txt)
- [reference](https://swcarpentry.github.io/sql-novice-survey/reference/)
- [SQLite function reference](https://www.sqlite.org/lang_corefunc.html)

#`Goal of this lesson`
- Create a SQLite database, select values, and commit to GitHub

***
Getting started where we left off...
    
    mammals <- read.csv("mammal_stats.csv", header=TRUE)
    library("sqldf")
    
    ??read.csv
    

***TIP***: When you load sqldf you also load the packages RSQLite and DBI by default. DBI allows us to work in R directly with a database manager software, and RSQLite package that lets us create SQLite databases.

***

#Create a SQLite database

    db <- dbConnect(SQLite(), dbname="Mammaldb.sqlite")

***TIP***: Look inside the workshop/sqldf folder. What do you see?
   
***
*Create* a table manually

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
**Reading** database tables

    dbListTables(db)
    dbListFields(db, "Mammal")


***
**Insert** a single record

 db <- dbConnect(SQLite(), dbname="Mammaldb.sqlite")
 
    dbSendQuery(conn = db,"insert into Mammal values ('Primates','New primate-2', 55.00,'',134,2)")

    sqldf(c("insert into Mammal values ('Primates','New primate', 55.00,'',134,2)","select * from Mammal"), dbname = "Mammaldb.sqlite")
    
***
**Select** from database using sqldf and SQLite syntax

    sqldf("SELECT * FROM Mammal limit 10", dbname = "Mammaldb.sqlite") 
    dbReadTable(db, "Mammal")

***
**Drop** database table

    dbRemoveTable(db, "Mammal")
    
***

***remember***: we have a data frame called mammals.

    mammals <- read.csv("mammal_stats.csv", header=TRUE)
    head(mammals)

***
**Insert** the data frame into the database

    dbWriteTable(conn = db, name = "Mammalcsv", value = mammals, row.names = TRUE)
    dbReadTable(db, "Mammalcsv")

***
**Write** query from database to data frame

	results <- dbGetQuery(db, "SELECT species, avg(litter_size) FROM Mammalcsv GROUP BY species;")

	head(results)

***
**SQL** in R functions

	library(RSQLite)

	db <- dbConnect(SQLite(), "Mammaldb.sqlite")

	getName <- function(orderName) {
  		query <- paste0("SELECT `order` || '-' || species FROM Mammalcsv WHERE 			`order` =='",orderName, "';")
  		return(dbGetQuery(db, query))
	}

	print(paste("species:", getName('Tubulidentata')))

	dbDisconnect(connection)


***
**Disconnect** at the end. Important if you have multiple transactions happening in an R script

    dbDisconnect(db)

***

    
