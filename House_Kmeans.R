#Data set: bostonhousing.csv
#Group the observations in this dataset in classes, using a k-means cluster analysis. The
#clustering variables should be all the variables in the dataset, except chas. (You can try
#with various numbers of clusters, to see which of them gives the best results).

House <-read.csv('bostonhousing.csv', stringsAsFactors = F)
House$chas <-NULL

##Remove missing values 
House <-na.omit(House)

#Create a matrix with all clustering variables 

House2 <- cbind(House$crim, House$zn, House$indus, House$nox, 
                House$rm, House$age, House$dis, House$rad, 
                House$tax, House$ptratio, House$lstat, House$medv)
#Standardize the clustering variables
House2 <-scale(House2)

colnames(House2) <- c("crim", "zn", "indus", "nox", "rm", "age", "dis", 
                      "rad", "tax", "ptratio", "lstat", "medv")

View(House2)

House2 <-as.data.frame(House2)

## Run K-means with 3 clusters 
model <- kmeans(House2, 3)

## Clustering vector 
member3 <-model$cluster

House2 <- cbind(House2, member3)

View(House2)

#Compute summary stats
library(dplyr)

Summ <- House2 %>% group_by(member3) %>%
  summarize_each(funs(mean), crim, zn, indus, nox, rm, age, dis, 
                 rad, tax, ptratio, lstat, medv)
View(Summ)




