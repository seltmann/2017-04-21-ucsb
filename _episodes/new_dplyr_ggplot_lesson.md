---
title: Data Wrangling and Plotting with dplyr and ggplot2
teaching: 65
exercises: 10
questions:
- Data Wrangling in R 
- How do I work with data to make cool, complex graphs easily in R
objectives:
- Working in the TidyVerse
- Plotting using ggplot
- Using different colors, grouping data, subplots.
keypoints:

keypoints:
- Dplyr is a great tool for exploring data
- Pipes can make your code more legible and more logical
- What is ggplot?  And why have multiple graphics tools?
- Parts of a ggplot figure: ggplot, data, aes, geom,
- Using mapping to make your figures more informative.
- How facets are helpful and how to make them.
- Using themes to make your figures more pleasing.
- Saving figures.
---




*by Umi Hoshijima, Corinne Fuchs, and Geraziella DiRenzo, based on material by Naupaka Zimmerman, Andrew Tredennick, & Kartik Ram*


Goals
-----
The goal of this module is to give a brief introduction to the world of quick data analysis using `dplyr`, to serve as reference when working with your own datasets. You will be observing your manipulated data using the package `ggplot`. 

By the end of this lesson, you should be able to: 

1. Plot using `ggplot`
2. use `dplyr` examples to understand the principles behind this method of data analysis
3. Streamline and increase legibility of code by using `pipes`

What is a package? 
----------
- An R package extends the functionality of R beyond its out-of-the-box capabilities. Packages exist for all sorts of things (stats, 
- Last I checked, there are over [12,000 official packages for R](https://cran.r-project.org/web/packages/available_packages_by_name.html). This is quite overwhelming, and generally you install what you need as you go. For inspiration, select packages are sorted into groups by function at the [CRAN Task View](https://cran.r-project.org/web/views/). 

What is ggplot?
---------

- `ggplot2` is the package, `ggplot` is the main function, but as you see we will use quite a few functions from `ggplot2` in this lesson.
- The 'gg' stands for grammar of graphics.  
- A syntax for making plots and figures.
- Defines components of a figure.
- Coherent, consistent syntax for a range of plotting.


Getting Started with ggplot: 
--------

Let's install and load our `ggplot2` package.  We'll also be using some dplyr here as well.

~~~
install.packages("ggplot2")
install.packages("dplyr")
library(ggplot2)
library(dplyr)
~~~
{: .r}

Then, import the `mammals` dataset. This is a subset of a *["species-level database of extant and recently extinct mammals](http://esapubs.org/archive/ecol/E090/184/)*. You can download it [HERE](https://seltmann.github.io/2018-04-05-ucsb/data/mammal_stats.csv). 

~~~
#loading mammals dataset for ggplot exercise:
setwd("~/Dropbox/SoftwareCarpenty18/")
mammals <- read.csv("mammal_stats.csv", head=T)
# OR:
mammals <- read.csv(file.choose()) # to bring up a file dialog
~~~
{: .r}



Let's compare two plots of the same data.

Here are the codes to make plots of body size vs. litter size:
------
~~~
plot(adult_head_body_len_mm ~ adult_body_mass_g, data=mammals)
~~~
{: .r}
![plot](https://seltmann.github.io/2018-04-05-ucsb/fig/ggplot_figs/first_plot.jpg.jpeg)


OR



~~~
ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm)) + geom_point()
~~~
{: .r}

![plot](https://seltmann.github.io/2018-04-05-ucsb/fig/ggplot_figs/first_plot_ggplot.jpg.jpeg)

Although the plots look similar, we can see differences in the basic structure of the code, and some of the default formatting.  The first is obvious, in which `plot(y~x)` means _"plot y with respect to x"_, which is fairly standard in many functions in R (e.g. statistics).  That second line of code probably looks a little like gobbledygook.  But it won't help you get gold out of Gringott's until you understand all its parts.

So why do we need another plotting method, to make the same plot?
-----------


Both `plot` and `ggplot` can be used to make publication quality figures, and both certainly have limitations for some types of graphics.  Arguably, ggplot excels over base graphics for data exploration and consistent syntax, and we'll explore those in the end of the lesson.  

ggplot2 Pros:| ggplot2 Cons:|
-|-|
consistent, concise syntax | different syntax from the rest of R|
intuitive (to many) | does not handle a few types of output well|
visually appealing by default | |
entirely customizable | |  
Easy to standardize formatting between graphs | | 

base graphics Pros:|base graphics Cons:|
-|-|
simple, straightforward for simple plots|syntax can get cumbersome for complex figures|
entirely customizable|fiddly for adjusting positions, sizes, etc.|
-|not visually appealing by default|

***




***

Parts of a ggplot plot:
-

There are several essential parts of any plot, and in `ggplot2`, they are:
  
1. the function: `ggplot()`
2. the arguments:
    - **data** - the dataframe
    - **aes** - the "aesthetics", or what columns to use 
    - **geom** - the type of graph
    - stats
    - facets
    - scales
    - theme
    - ...and others

In `ggplot` you absolutely need the first three arguments: `data, aes, geom` to make any graphic.  The latter arguments help you customize your graphic to summarize data, express trends, or customize appearances.  We won't cover any these in much depth, but if you are comfortable with what we show you today, exploring the vast functionality of `geom, stats, scales, and theme` should be a pleasure.

***

###`ggplot()`

Some people like to assign (`<-`) their plot function to a variable, like this:

~~~
myplot<-ggplot(...)
~~~
{: .r}

***

### `data`
- This is the data you want to plot
- Must be a data.frame

For this lesson, we are going to look at the `mammals` data set that we used earlier.

~~~
head(mammals)  
~~~
{: .r}

Let's **build** a scatter plot of mammal body size and litter size.

~~~
myplot<-ggplot(data=mammals... )
~~~
{: .r}


***

### `aes` 
For **aes**thetics.

How your data are to be visually represented.  `aes()` is an argument within `ggplot` that takes its own arguments, `aes(x=, y=)`.  These are your independent (x) variable and your dependent (y) variable.  `ggplot2` nerds call this *mapping*.  As I understand it, they mean that you are *mapping* data points by the data values, in a 'landscape' of a coordinate system based on your data. Mapping will be important later, when we add meaningful colors and symbols to differentiate things like mice and whales, based on a variable that corresponds to one of our mapped data points.

### What happens if we make a plot just using `data` and `aes`?
~~~
myplot<-ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))
myplot  
~~~
{: .r}


If you executed this code, you probably got an blank, data-less plot. Why?

So far, we have told ggplot where to look for data (`data`), and how to represent that data (`aes`), but not what to *do* with the data values.  So there is nice space for our data... but we still need to actually plot the data.

***

### `geom` 
For **geom**etry.  

This is how we create the 'layer' we actually see as our figure.  
These are the geometric objects likes points, lines, polygons, etc. that are in the plot

  - `geom_point()`
  - `geom_line()`
  - `geom_boxplot()`
  - `geom_text()`
  - `geom_bar()`
  - `geom_hline()`
  - 25 more!

Let's add a geom to make that scatter plot from above. 

In this scatterplot, we tell ggplot to use the `mammals` dataset, to plot body mass on the x and body length on the y axis, and to plot those data as points, creating a scatterplot...

~~~
ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
         geom_point()
~~~
{: .r}



To make this code formatted neatly, with `geom_point` on the second line, simply press enter after the `+` sign. Rstudio will automatically tab into the second line. (Hint: to correctly tab any line automatically, put your cursor on the code line and type `cmd + i` (mac) or `ctrl + i ` (windows)).  
 
 When you run this code, Rstudio will automatically recognize the + and know that the lines should run together. You should produce a plot with points displaying our data. 

Plotting by order: challenges of more complex visualization
----

### Changing the aesthetics of a `geom` 

This scatterplot is pretty simple. But what if we wanted to see which orders had which body sizes? 


### Changing the aesthetics of a `geom` 

You can easily specify which data points get a certain: color, size, shape.  You can __set__ or __map__ an visual property to your data points. But, if you __set__ it, it is *not* part of the aesthetic, because the data values have no influence on a set property.  If you __map__ that property within the aesthetic, what you see will depend on your data values.

Lets __set__ the size of the data points to make them easier to see when projected to an audience:

~~~
ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
  geom_point(size=3)+
  scale_x_log10()
~~~
{: .r}

...or __map__ some **useful** color onto our values. Mapping is based on your data values, usually of a yet-unplotted variable that also describes each point or observation.  In this case, taxonomic Order is a property that describes each individual mammal in our dataset, so we can map the Order on to each data point to differentiate them:

~~~
ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
  geom_point(size=3, aes(color=order))+
  scale_x_log10()
~~~
{: .r}

Thats a lot of orders to look at, and its hard to tell who's who.  Note however, the __automatically generated legend__.  __Yew!__  That doesn't happen in `plot` very easily, but you get it automatically in when `ggplot` maps colors or shapes to categorical variables.  

To do this kind of plot without using ggplot, you would need something to this effect: 
~~~
# Library to make color palettes - ggplot does this automatically
install.packages('colorspace')
library(colorspace)
# make empty plot with space for the legend
plot(adult_head_body_len_mm ~ adult_body_mass_g, data=mammals, type = 'n', 
     xlim = c(0,200000000))
# get lists for order
orders = unique(mammals$order)
# make colors 
colors = rainbow_hcl(length(orders))
# plot every order in a different color
for (a in 1:length(orders)) {
  dat_plot = mammals[mammals$order == orders[a],]
  points(adult_head_body_len_mm ~ adult_body_mass_g, data=dat_plot, 
         col = colors[a], pch = 16)
}
# get legend in the right place, and manually set values. 
legend(120000000,23000, legend = orders, col = colors, cex = 0.5, pch = 16, ncol = 2)
~~~
{: .r}

![plot](https://seltmann.github.io/2018-04-05-ucsb/fig/ggplot_figs/mammals_baseplot_order.jpeg)

...ew. 


I think you ge the idea. Let's limit the number of Orders we are examining in our figure. 


Dplyr
----

We can use `dplyr` here, which we have already loaded. You'll notice that as we work on larger datasets, viewing and visualizing the entire dataset can become more and more difficult. Similarly, analyzing the datasets becomes more complex. Dplyr can be helpful for dealing with medium-size datasets such as this - both for stats and for visualization. `dplyr` will allow us to perform more complex operations on single dataframes in intuitive ways.

First off, though, let's explore some very handy sorting and viewing functions in `dplyr`. `glimpse()` is a quick and pretty alternative to `head()`:
Dplyr has quick/intuitive functions for manipulationg datasets. 


~~~
head(mammmals)
glimpse(mammals)
~~~
{: .r}

All of the previous plots we created had a ton of orders - let's try looking at some individually. If you want to filter a dataset using a certain column (e.g. order), you can use the `filter` command in dplyr: 


~~~
# This returns the data from mammals were order equals rodentia. 
tails = filter(mammals, order=="Rodentia") 
head(tails)
~~~
{: .r}


Now suppose I'm interested in finding the large mammals: 

~~~
large_mammals = filter(mammals, adult_body_mass_g > 1000000)
head(large_mammals)
~~~
{: .r}

We can also combine these sorts of statements using 'and' or  'or': 

~~~
filter(mammals, order == "Rodentia" & adult_body_mass_g > 1000000) 
filter(mammals, order == "Rodentia" | adult_body_mass_g > 1000000) 
~~~
{: .r}

There's also cool functions in dplyr to select columns by name, or to arrange the dataframe by a certain column. 
Let's make a simple mammals dataset that's just species and mass of terrestrial animals. Then we can find the heaviest terrestrial mammal: 



~~~
# First, make a terrestrial mammals dataframe:
tmammals = filter(mammals, habitat == 'T')
# Let's simplify the column names
colnames(tmammals)
tmammals_simple = select(mammals, species, adult_body_mass_g)
#Let's arrange this data frame by body mass: 
arrange(tmammals_simple, adult_body_mass_g)
head(arrange(tmammals_simple, adult_body_mass_g))
head(arrange(tmammals_simple, desc(adult_body_mass_g)))

~~~
{: .r}

***
Challenge: Make a scatterplot of weight vs. litter size, but only with Rodentia and Cetecea orders. 
color by order. 
***

Add in alpha, as well as log-scaling axes later.



# boxplot of marine vs terrestrial body size?
We need to read in the file because we overwrote the object mammals when we were filtering. 

After reading it in, we can specify the geom_boxplot to make a boxplot with different environments.


~~~
mammals1 <- read.csv("mammal_stats.csv", head=T)

# Create a simple plot
ggplot(data = mammals1, aes(x = habitat, y = adult_body_mass_g))+geom_boxplot()

# Make the y axis on the log scale
ggplot(data = mammals1, aes(x = habitat, y = adult_body_mass_g))+geom_boxplot()+
  scale_y_log10()

# Change boxplot color
ggplot(data = mammals1, aes(x = habitat, y = adult_body_mass_g, fill = habitat))+geom_boxplot()+
  scale_y_log10()+
  scale_fill_manual(values = c("dodgerblue", "forestgreen"))

# Change the legend title
ggplot(data = mammals1, aes(x = habitat, y = adult_body_mass_g, fill = habitat))+geom_boxplot()+
  scale_y_log10()+
  scale_fill_manual(name = "Habitat", values = c("dodgerblue", "forestgreen"))

# Change the x and y labels
ggplot(data = mammals1, aes(x = habitat, y = adult_body_mass_g, fill = habitat))+geom_boxplot()+
  scale_y_log10()+
  scale_fill_manual(name = "Habitat", values = c("dodgerblue", "forestgreen"))+
  labs(x = 'Habitat', y = 'Adult body mass (g)')
~~~
{: .r}



Great!

# Jittered points on top of boxplot, x = habitat

Now, we are interested in seeing the datapoints on the boxplot. We simply add the function + geom_point()

~~~
ggplot(data = mammals1, aes(x = habitat, y = adult_body_mass_g, fill = habitat))+geom_boxplot()+
  scale_y_log10()+
  scale_fill_manual(name = "Habitat", values = c("dodgerblue", "forestgreen"))+
  labs(x = 'Habitat', y = 'Adult body mass (g)')+
  geom_point()
~~~
{: .r}

Wait! They are all on top of each other! Let's fix that by using geom_jitter(), which as the name implies jitters the points.

~~~
ggplot(data = mammals1, aes(x = habitat, y = adult_body_mass_g, fill = habitat))+geom_boxplot()+
  scale_y_log10()+
  scale_fill_manual(name = "Habitat", values = c("dodgerblue", "forestgreen"))+
  labs(x = 'Habitat', y = 'Adult body mass (g)')+
  geom_jitter()
~~~
{: .r}

AHHHH!!! So many points ontop of the terrestrial boxplot! Let's change the transparency of the points again using the argument "alpha"- and this allows us to see where points overlap.

~~~
ggplot(data = mammals1, aes(x = habitat, y = adult_body_mass_g, fill = habitat))+geom_boxplot()+
  scale_y_log10()+
  scale_fill_manual(name = "Habitat", values = c("dodgerblue", "forestgreen"))+
  labs(x = 'Habitat', y = 'Adult body mass (g)')+
  geom_jitter(alpha = 0.3)
~~~
{: .r}

One last neat thing you can do is add the orders as different colors to this boxplot as well.
~~~
ggplot(data = mammals1, aes(x = habitat, y = adult_body_mass_g, fill = habitat))+geom_boxplot()+
  scale_y_log10()+
  scale_fill_manual(name = "Habitat", values = c("dodgerblue", "forestgreen"))+
  labs(x = 'Habitat', y = 'Adult body mass (g)')+
  geom_jitter(aes(x = habitat, y = adult_body_mass_g, col = order), alpha = 0.3)
~~~
{: .r}

 
# BREAKTIME! 
 
 
# back to dplyr: grouping
~~~
summarize(mammals, mean_mass = mean(adult_body_mass_g))
?mean
summarize(mammals, mean_mass = mean(adult_body_mass_g, na.rm = TRUE))

mammals_group_order = group_by(mammals, order)
mammals_group_order
mammals_summarize = summarize(mammals_group_order, mean_mass = mean(adult_body_mass_g, na.rm = TRUE))
mammals_summarize = summarize(mammals_group_order, mean_mass = mean(adult_body_mass_g, na.rm = TRUE),
          mean_len = mean(adult_head_body_len_mm, na.rm = TRUE))

ggplot(mammals_summarize, aes(x = mean_mass, y = mean_len))+geom_point()
~~~
{: .r}


# group the same thing WITH pipes
~~~
mammals %>%
  group_by(order) %>%
  summarize(mean_mass = mean(adult_body_mass_g, na.rm = TRUE),
          mean_len = mean(adult_head_body_len_mm, na.rm = TRUE))%>%
  ggplot( aes(x = mean_mass, y = mean_len))+geom_point()


~~~
{: .r}

## plot outcome
## plot outcome using filter etc. function within ggplot code (as a pipe)
~~~
mammals %>%
  filter(order == 'Rodentia' | order == 'Sirenia')%>%
  ggplot( aes(x = adult_head_body_len_mm, y = adult_body_mass_g))+geom_point(aes(color = order))+
  scale_x_log10()+ scale_y_log10()
~~~
{: .r}

## revisit previous concepts with pipes


# facet marine/terrestrial things

~~~
  ggplot(mammals1, aes(x = adult_head_body_len_mm, y = adult_body_mass_g))+geom_point(aes(color = order))+
  scale_x_log10()+ scale_y_log10() + facet_grid(.~habitat)

  ggplot(mammals1, aes(x = adult_head_body_len_mm, y = adult_body_mass_g))+geom_point(aes(color = order))+
  scale_x_log10()+ scale_y_log10() + facet_grid(habitat~.)
~~~
{: .r}


# Final section: making ggplot pretty

Let's make the background white, remove the major and minor lines, and adjust the text size of the axis text and axis titles, and change the background color to the facet names to "white".

~~~
ggplot(mammals1, aes(x = adult_head_body_len_mm, y = adult_body_mass_g))+geom_point(aes(color = order))+
  scale_x_log10()+ scale_y_log10() + facet_grid(habitat~.)+
  theme_bw()+
  ylab("Adult body mass (g)")+
  xlab("Adult head body length (mm)")+
  theme(axis.text.x = element_text(size = 12, color = "black"), 
        axis.text.y = element_text(size = 12, color = "black"), 
        axis.title.y = element_text(size = 12, color = "black"), 
        axis.title.x =element_text(size = 12, color = "black"),
        legend.title =element_text(size = 12, color = "black"),
        legend.text =element_text(size = 12, color = "black"),
        strip.background = element_rect("white"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())
~~~
{: .r}

Let's add a linear model to the plots. We use the function stat_smooth(method = "lm"). Notice you can also specify your own functions using the argument "y =...."

~~~
ggplot(mammals1, aes(x = adult_head_body_len_mm, y = adult_body_mass_g))+geom_point(aes(color = order))+
  scale_x_log10()+ scale_y_log10() + facet_grid(habitat~.)+
  theme_bw()+
  ylab("Adult body mass (g)")+
  xlab("Adult head body length (mm)")+
  theme(axis.text.x = element_text(size = 12, color = "black"), 
        axis.text.y = element_text(size = 12, color = "black"), 
        axis.title.y = element_text(size = 12, color = "black"), 
        axis.title.x =element_text(size = 12, color = "black"),
        legend.title =element_text(size = 12, color = "black"),
        legend.text =element_text(size = 12, color = "black"),
        strip.background = element_rect("white"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())+
  stat_smooth(method = "lm")
~~~
{: .r}
Let's save the plot and learn to save it in different sizes

~~~
ggsave("Mass_v_length1.pdf", height = 8, width = 6)

ggsave("Mass_v_length2.pdf", height = 6, width = 8)
~~~
{: .r}


* more layered geoms (stats geoms, showing multiple geoms on one plot)

* then save that into a custom theme
* set custom theme as global default theme

# END OF LESSON!

## Bonus material if there's extra time:

## More complicated theme things; 


* more theme details 
* colors
* shapes
* color pallettes (scale_color_manual, brewer (for more complex stuff))
* geom_errorbar

* using expression stuff for symbols in axes etc.; only do if there's free time)
* angled axis labels


 
## super-bonus xtra options for if there's lots of spare time @ end

* ggThemeAssist
* cowplot
