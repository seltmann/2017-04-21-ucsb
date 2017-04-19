---
title: ggplot
teaching: FIX
exercises: FIX
questions:
- "FIXME"
objectives:
- "FIXME"
- "FIXME"
keypoints:
- "FIXME"
keypoints:
- "FIXME"
- "FIXME"
- "FIXME"
---

*by Umi Hoshijima and Thomas Smith, based on material by Naupaka Zimmerman, Andrew Tredennick, & Kartik Ram*

**Supplementary Material**: [answers to exercises](ggplot-lesson-answers.R)

# What is ggplot?

- `ggplot2` is the package, `ggplot` is the function.
- A package that provides graphics tools that differ from those available in `plot`.
- The 'gg' stands for grammar of graphics.  
- A syntax for making plots and figures.
- Defines components of a figure.
- Coherent, consistent syntax for a range of plotting.

Let's compare two plots of the same data.

### Here are the codes to make plots of body size vs. litter size:

`plot(adult_head_body_len_mm~adult_body_mass_g, data=mammals)`

OR

`ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm)) + geom_point()`  

Although the plots look similar, we can see differences in the basic structure of the code, and some of the default formatting.  The first is obvious, in which `plot(y~x)` means _"plot y with respect to x"_ which is pretty close to how we all learned to plot things back in the day.  That second line of code probably looks a little like gobbledygook.  But it won't help you get gold out of Gringott's until you understand all its parts.

# So why do we need another plotting method, to make the same plot?

Both `plot` and `ggplot` can be used to make publication quality figures, and both certainly have limitations for some types of graphics.  Arguably, ggplot excels over base graphics for data exploration and consistent syntax, and we'll explore those in the end of the lesson.  

ggplot2 Pros:| ggplot2 Cons:|
-|-|
consistent, concise syntax | different syntax from the rest of R|
intuitive (to many) | does not handle a few types of output well|
visually appealing by default | |
entirely customizable | |  

base graphics Pros:|base graphics Cons:|
-|-|
simple, straightforward for simple plots|syntax can get cumbersome for complex figures|
entirely customizable|fiddly for adjusting positions, sizes, etc.|
-|not visually appealing by default|

***

# Getting Started:

Let's install and load our `ggplot2` package.  We'll aslo be using some plyr here. 

~~~
install.packages("ggplot2")
library(ggplot2)
library(dplyr)
~~~
{: .r}

Second, reload the data if you need to:

~~~
#loading mammals dataset for ggplot exercise:
setwd("C:/Users/Thomas/Documents/2016-04-14-ucsb/data/")
mammals <- read.csv("mammal_stats.csv", head=T)
# OR:
mammals <- read.csv(file.choose())
~~~
{: .r}


***

# Parts of a ggplot plot:
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

## `ggplot()`
Some people like to assign (`<-`) their plot function to a variable, like this:

~~~
myplot<-ggplot(...)
~~~
{: .r}

***

## `data`
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

## `aes` 
For **aes**thetics.

How your data are to be visually represented.  `aes()` is an argument within `ggplot` that takes its own arguments, `aes(x=, y=)`.  These are your independent (x) variable and your dependent (y) variable.  `ggplot2` nerds call this *mapping*.  As I understand it, they mean that you are *mapping* data points by the data values, in a 'landscape' of a coordinate system based on your data. Mapping will be important later, when we add meaningful colors and symbols to differentiate things like mice and whales, based on a variable that corresponds to one of our mapped data points.

~~~
myplot<-ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))
myplot  
~~~
{: .r}


If you executed `myplot` you probably got an empty plot.  So far, we have told ggplot where to look for data, and how to represent that data, but not what to do with the data values.  So there is nice space for our data... but we still need to actually plot the data.  

***

## `geom` 
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

Let's add a geom to make a scatter plot:

~~~
myplot<-ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))  
myplot+geom_point()  
~~~
{: .r}


    
OR
 
~~~   
ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
  geom_point()
~~~
{: .r}

      
Well, that looks a little funky. Clearly, the body mass size range is huge.  Our data includes data from rodents and cetaceans, so we might want to use a log10 scale to express our body size data:

~~~
ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
  geom_point()+
  scale_x_log10()
~~~
{: .r}


`scale_x_log10` is an example of an argument you can easily add to your figure to improve how it conveys information.  Now, we'll show you some other ways to improve your figures, capitalizing on the flexibility of your `aes()`.

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

Thats a lot of orders to look at, and its hard to tell who's who.  Note however, the __automatically generated legend__.  __Yew!__  That doesn't happen in `plot`.  You get it automatically in when `ggplot` maps colors or shapes to categorical variables.  You can also manually control all those colors.  But, lets limit the number of Orders we are examining in our figure.  We can use `dPlyr` again, to examine just the Rodentia and Cetacea.

~~~
TailsnWhales<-filter(mammals, order == "Rodentia" | order == "Cetacea") 

ggplot(data=TailsnWhales, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
  geom_point(size=3, aes(color=order))+
  scale_x_log10()
~~~
{: .r}


We can see that on average, rodents are smaller and have bigger litters than whaley-things. How else might we represent that observation?

### geoms for summarization:

**Boxplot**  

~~~
ggplot(data=TailsnWhales, aes(x=order, y=adult_body_mass_g))+
  geom_boxplot(size=1, aes(color=order))+
  scale_y_log10()
~~~
{: .r}


**Histogram** - here you need only specify one variable to be visualized in your `aes()`:

~~~
ggplot(data=TailsnWhales, aes(x=adult_head_body_len_mm))+  
  geom_histogram()
~~~
{: .r}


> **Tip**: For most histograms, don't feel like you are not challenging yourself if you still use `hist()` in base graphics.  

> **Challenge 1:** Plot Primates and Carnivora body sizes vs. home range size in the same figure, distinguishing between the two orders.

***

## `facets`
Facets are panels in which sub-plots are arranged according to a categorical grouping variable(s).  Facets are probably the most exciting and superior aspect of using `ggplot2` for exploratory graphics!

~~~
ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+
  geom_point()+
  scale_x_log10()+
  facet_wrap(~order)
~~~
{: .r}


And we can combine them with summary graphics, for some easy exploratory analyses.  First, though we need to do some voodoo to make our plots more interesting, and you should cut and paste this chunk of code.  This code adds to `mammals` a vector of home range categories (we use conditional subsetting to select rows, or individuals, and assign them a factor level in a new vector):

~~~
mammals$RangeCategory[mammals$home_range_km2 <= 0.01] <- "micro_machines"
mammals$RangeCategory[mammals$home_range_km2 > 0.01 & mammals$home_range_km2 <= 1] <- "homebodies"
mammals$RangeCategory[mammals$home_range_km2 > 0.1 & mammals$home_range_km2 <= 10] <- "strollers"
mammals$RangeCategory[mammals$home_range_km2 > 10 & mammals$home_range_km2 <= 100] <- "roamers"
mammals$RangeCategory[mammals$home_range_km2 > 100 & mammals$home_range_km2 <= 1000] <- "free_agents"
mammals$RangeCategory[mammals$home_range_km2 > 1000] <- "transcendentalists"
~~~
{: .r}
   
  
Then, here, we create a new subset for just a few orders, because 29 orders is a lot to try to summarize at once.  Then we tell R to put the factor levels in RangeCategory and order in, um, order.  Now they will plot from small to large.  Note we are not changing the order of rows in our data.frame.

~~~   
OrderSubset<-filter(mammals, order == "Rodentia" | order == "Cetacea" | order=="Primates" | order=="Carnivora") 

~~~
{: .r}



Finally, here is a faceted figure that depicts the distribution of mammal body sizes with respect to Order and to range size:

~~~
ggplot(data=OrderSubset, aes(x=adult_body_mass_g))+
  geom_histogram(aes(fill=order))+
  scale_x_log10()+
  facet_grid(RangeCategory~order, scales="free")
~~~
{: .r}

        
Specifying the group variable on the left `facet_grid(RangeCategory~.)` arranges facets as rows in one column; on the right `facet_grid(~.order)` in several columns in one row.  We used `facet_wrap(~variable)` in the previous figure, because we had  many categories of one variable, and were not arranging the subplots with respect to a second categorical variable.

> **Challenge 2:** Make a figure that summarizes mammal body sizes with respect to their range category, and separately for a few different orders? Hint: try a boxplot, and don't forget about `filter`.

***

## `stats`

For **stats**istics. 

The `geom_boxplot()` and `geom_histogram()` are stats components we have already used, and there are many more.  They mostly look like a `geom_`, but you end up with some summarization of your data.  You can put a `stats` geom on top of regular geoms, like this:

~~~
ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm))+  
  geom_point(size=3)+  
  scale_x_log10()+
  geom_smooth(method=lm)
~~~
{: .r}



***

## `theme` 
### Controlling figure appearance

Themes allow you to specify how the non-data components of your figure look, e.g. legends, axis labels, and backgrounds.

First though, there are ways to control the appearance of your data points by setting a value to them, or mapping them to a grouping variable. You can do this in the aes() or in the geom, but any character of the plot you set in `aes()` becomes a global setting for your figure.  For axample, if you set `aes(..., color=pink)`, then all the data in your figure will be pink, no matter what (or how many) geoms you map to the variables.

You can control the non-data elements (text, axes, legends) using themes.
Using our color-coded scatterplot of Sepal Width vs Sepal Length, lets add a theme to make our figure worthy of our next committee meeting.

Rerun the code to see how the plot looked by default:

~~~
ggplot(data=OrderSubset, aes(x=adult_body_mass_g))+
  geom_histogram(aes(fill=order))+
  scale_x_log10()+
  facet_grid(RangeCategory~order, scales="free")
~~~
{: .r}

But with theme, it could look like:

~~~
ggplot(data=OrderSubset, aes(x=adult_body_mass_g))+
  geom_histogram(aes(fill=order))+
  scale_x_log10()+
  facet_grid(RangeCategory~order, scales="free")+
  theme(legend.key=element_rect(fill=NA),
      legend.position="bottom",
      axis.title=element_text(angle=0, size=18, face="bold"),
      legend.text=element_text(angle=0, size=12, face="bold"),
      panel.background=element_rect(fill=NA))
~~~
{: .r}



Obviously, you can really go nuts with themes... and create your own customs:

~~~
install.packages("wesanderson")
library(wesanderson)
~~~
{: .r}


To see color palettes:

~~~
wes_palette("Royal1")
~~~
{: .r}


For those studying predation/medium sized mammals/trophic cascades, try:

~~~
wes_palette("FantasticFox")
~~~
{: .r}

    
...and for the marine biologists (or their interns):

~~~
wes_palette("Zissou")
~~~
{: .r}

    
Lets apply the Fantastic Fox palette (because, mammals), and default theme `theme_bw()` to our histogram figure.  We can actually add multiple theme elements and arguments, allowing you to start with the nice looking default, and tweak it:

~~~ 
myplot<-ggplot(data=OrderSubset, aes(x=adult_body_mass_g))+
          geom_histogram(aes(fill=order), color="black", size=0.25)+
          scale_x_log10()+
          facet_grid(RangeCategory~order, scales="free")+
          scale_fill_manual(values = wes_palette("FantasticFox")) + 
          theme_bw()+
          theme(legend.key=element_rect(fill=NA),
            legend.position="bottom",
            axis.title=element_text(angle=0, size=18, face="bold"),
            legend.text=element_text(angle=0, size=12, face="bold"),
            panel.background=element_rect(fill=NA))
~~~
{: .r}



***

## Saving a ggplot figure:

    ggsave("myplot.jpg", width=6, height=8, unit="in", dpi=300)

If you don't specify file path, it will save to your working directory.  You may be saving figures into your data folder.

You can save as most image formats (jpeg, TIFF, PNG, PDF, etc.), as well as specify the size and resolution (dpi, ppi) of the image.

The following will actually save any figure you make in R, whether you produce it using `ggplot` or `plot`:

~~~
ppi<-300
jpeg(file="Figure1.jpg", width=6, height=8, units="in", res=ppi)
myplot
dev.off()
~~~
{: .r}

***

> **Challenge:**
> Yesterday we made this scatter plot: plot(avg_day_inflammation).  Reproduce and improve the inflammation plot we created yesterday.  Hint: ggplot needs a data.frame.

> **Challenge:**
> Using `ggplot` recreate the example plot of rodent and cetacean body size v. litter size shown in the beginning of the lesson.  For extra challenge, use `plot` in base R.

> **Challenge:**
> Save one of the figures you made in this lesson, and email it to your advisor, with the subject line "For your refrigerator!"

***

> **Challenge:**
> Yesterday we made this scatter plot: plot(avg_day_inflammation).  Reproduce and improve the inflammation plot we created yesterday.  Hint: ggplot needs a data.frame.

There are many packages that will enhance ggplots, and allow you to use other data structures, theme elements, or to combine plots.  Here are a few: ggthemes, gridExtra, colorbrewer, ggbiplot, ggmap

ggplot2 will probably not replace all other graphics tools.  You may still use base graphics, and you may export ggplot figures to graphics programs like Illustrator for final touches.

Graphics are an important part of the process of scientific computing and research - from data exploration to communication.  We hope we have shown you the building blocks for making figures that help you discover new things about your self!

> ## Key Points
> * What is ggplot?  And why have multiple graphics tools?
> * Parts of a ggplot figure: *ggplot, data, aes, geom*.
> * Using mapping to make your figures more informative.
> * How *facets* are helpful and how to make them.
> * Using themes to make your figures more pleasing.
> * Saving figures.

***
