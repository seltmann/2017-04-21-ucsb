---
title: Getting set up for R
layout: page
---

Now that you know the basics of Git.  Let's quickly get setup for the R lessons that will happen after lunch. Follow these steps

A.  Make a folder called `workshop` on your `Desktop`
    
    cd ~/Desktop
    mkdir workshop

B. Download the data files that we will be using for the R portion of the workshop by clicking [here](http://swcarpentry.github.io/r-novice-inflammation/files/r-novice-inflammation-data.zip).  

C. Unzip these files and move the resulting `data` folder into your `workshop` folder. If the `data` folder is in your `Downloads` directory you can use

    mv ~/Downloads/data ~/Desktop/workshop

D. `cd` into your `workshop` folder (if you are not already there) and initialize it as a Git repo

    cd ~/Desktop/workshop
    git init

E. Add the R data as your first commit

    git add data
    git commit -m "Added R data"

That's it!  See you after lunch!

