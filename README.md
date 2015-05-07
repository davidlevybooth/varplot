# varplot
Plot variation partitioning results as a horizontal bar plot in R

Using the variation partitioning function in vegan for R (which is
basically a wrapper for some RDA functions and a bit of algerbra),
you can produce a nice horizonal bar plot to visualize the unique
impact of your explanatory variables with overlapping variation 
removed. 

How it works: 

varbar(y, data, order = TRUE, plot = TRUE)

Produces a bar plot of variations and returns a formatted table of 
results (including Monte-Carlo tested p-values). Use order = FALSE
to turn off automatic variable ordering in the plot and plot = FALSE
to turn off the plotting. 

Enjoy. 
