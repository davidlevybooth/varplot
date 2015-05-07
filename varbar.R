### Variation partitioning

varbar <- function(y, data, order = TRUE, plot = TRUE) {
  require(vegan) ##load the required package
  
  #function to convert negative R2 to zero
  zero <- function(r2){ if (r2 < 0){ x<-0 } else {x<-r2}
                        return(x)}
  
  #function to convert p-values to ***
  p.sym <- function(Pr){ if (Pr <= 0.001) { x<-"***" } else if (Pr <= 0.01) {x<-"**" } else if (Pr <=0.05) { x<-"*" } else x<-" "
                         return(as.character(x))}
  
  rs<- list() #create empty list for R2
  p<- list() #create empty list for p-value
  ps<- list() #create empty list for p symbol (*)
  y_var <- deparse(substitute(y)) #get y-variable name
  data2 <-data[,!(names(data) %in% y_var)] #create new dataframe without y-variable

  #loop to do varpart on each variable in data, get zero-corrected R2
  for(i in (1:length(data2))) {
    rs[[i]]<-varpart(data[y_var],data2[i], cbind(subset(data2, select=-i)))
    r_tot<-rs[[i]]$part$fract$Adj.R.squared[3]
    rs[[i]]<-zero(rs[[i]]$part$indfract$Adj.R.square[1])
    p[[i]]<-anova.cca(rda(data[y_var],data2[i], cbind(subset(data2, select=-i)) ,step=1000))$Pr[1]
    p_tot<-anova.cca(rda(data[y_var],cbind(data2) ,step=1000))$Pr[1]
    
  }
  #let's add stars(*) for p-values
  for(i in 1:length(p)) {
    ps[[i]]<-p.sym(p[[i]])
    }
  
  #sort and label the resulting R2 values as explained variation (*100)
  var<-as.data.frame(c(round(unlist(rs),3)*100))
  colnames(var)<-c("Variation Explained (%)")
  rownames(var)<-c(names(data2))
  var["p-value"]<-unlist(p)
  var[" "]<-unlist(ps)
  if(order){ var <- var[order(var["Variation Explained (%)"]),,drop = FALSE] }
  
  if(plot) {
  #par(omi = c(0,0.6,0,0.6)) #set outer margins to fix the y-axis label issue
  #plot the R2 as a horizontal barplot 
  plot1<-barplot(t(var[1]), las = 2, xaxt="n", xlab="Variation Explained (%)",horiz=TRUE)
  axis(side = 1)
  title(paste("Variation Explained: ", round(r_tot,3)*100, "%",p.sym(p_tot), sep=""), cex.main = 1, font.main = 1, line = 1)
  ## Add text at top of bars
  text(x = t(var[1]), y = plot1, label = as.matrix(var[3]), pos = 4, cex= 1, col = "black", xpd = TRUE)
  #par(omi = c(0,0,0,0)) #reset margins
  }
  
  #add total variation to table AFTER it's ploted
  var["Total",]<-c(round(r_tot,3)*100, round(p_tot, 4), p.sym(p_tot))
  
  #return a table of explained variation matching order in barplot
  if(order) {return(var[order(-var["Variation Explained (%)"]),,drop = FALSE])}
  else {return(var)}
  
}
