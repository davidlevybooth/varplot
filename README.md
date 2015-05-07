# varplot
Plot variation partitioning results as a horizontal bar plot in R

Produces a bar plot of variations and returns a formatted table of 
results (including Monte-Carlo tested p-values).

Using the variation partitioning function in vegan for R (which is
basically a wrapper for some RDA functions and a bit of algerbra),
you can produce a nice horizonal bar plot to visualize the unique
impact of your explanatory variables with overlapping variation 
removed. 

How it works: 

varbar(y, data, order = TRUE, plot = TRUE)

"y" is the name for the dependant variable that you want to find 
the variation of.

"data" should be a dataframe of all of the variables to be tested, 
including "y".

order = FALSE to turn off automatic variable ordering in the plot.

plot = FALSE to turn off the plotting.

 

Enjoy. 
