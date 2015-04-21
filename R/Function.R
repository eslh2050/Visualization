library(gcookbook)
library(ggplot2)

?uspopage
head(uspopage)
str(uspopage)

ggplot(uspopage, aes(x = Year, y= Thousands, fill = AgeGroup)) +
  geom_area() 

ggplot(uspopage, aes(x = Year, y= Thousands, fill = AgeGroup)) +
  geom_area(apha = 0.4, color = "black") +  
              scale_fill_brewer(palette = "Blues", 
                    breaks= rev(levels(uspopage$AgeGroup))) +
  ylab("Population in Thousands")

ggplot(uspopage, aes(x = Year, y= Thousands, fill = AgeGroup)) +
  geom_area(apha = 0.4) +  
  scale_fill_brewer(palette = "Blues", 
                    breaks= rev(levels(uspopage$AgeGroup))) +
  ylab("Population in Thousands") +
  geom_line(position = "stack")

library(plyr)

uspopage_prop <- ddply(uspopage, "Year", transform, percent = Thousands/sum(Thousands))

ggplot(uspopage_prop, aes(x = Year, y= percent, fill = AgeGroup)) +
  geom_area(apha = 0.4) +  
  scale_fill_brewer(palette = "Blues", 
                    breaks= rev(levels(uspopage$AgeGroup))) +
  ylab("Percent") +
  geom_line(position = "stack")

x <- 0.3

if (x > 1){
  print("I am fabulous")
} else if(x <1) {
  print("I am not fab")
}

### FOR LOOPS

for(i in 1:6){
  print(i)
}

# Next

for( i in 1:100){
  if(i <= 50){
    next
  }
  print(i)
}

###Functions in R

add2 <- function(x,y){
  if(!is.numeric(x) | !is.numeric(y)){
    return("Arguements should be numeric!")
  }
  x+y
}

add2("c", 10)

### Write a function that takes a numeric vextor as an argument and prints number>10

aboveN <- function(x,n){
  for(i in 1:length(x)){
    if(is.numeric(x[i]) & x[i]>n){
      print(x[i])
    }
  }
}

a <- 1:20
a
b <- aboveN(a, 14)

aboveN <- function(x,n){
  
  vec <- NULL
  j = 1
  for(i in 1:length(x)){
    if(is.numeric(x[i]) & x[i]>n){
      vec[j] <- x[i]
      j <- j +1
    }
  }
  return(vec)
}

a <- 1:20
a
b <- aboveN(a, 14)
b

aboveN <- function(x,n=10){
  
  vec <- NULL
  j = 1
  for(i in 1:length(x)){
    if(is.numeric(x[i]) & x[i]>n){
      vec[j] <- x[i]
      j <- j +1
    }
  }
  return(vec)
}

a <- 1:20
a
b <- aboveN(a)
b

### define a dataframe

df = data.frame(x1 = rnorm(10),
                x2 = rnorm(10))

df$x1[5] = NA

### write a function that computes the mean of all colums in a given data frame

avg <- function(x){
  
}

































