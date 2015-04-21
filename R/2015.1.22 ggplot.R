## load the packages

library(ggplot2)
library(gcookbook)

### look at the diamond datasets

?diamonds
class(diamonds)
## produce a barchart for "cut"

ggplot(diamonds,aes(x = cut)) + 
  geom_bar()

str(diamonds)

## if you use numerical variable, then geom_bar will produce a histgram
ggplot(diamonds,aes(x = carat)) + 
  geom_bar()

### look at BOD dataset

?BOD 
BOD
str(BOD)

ggplot(BOD, aes(x = factor(Time), y = demand)) +
  geom_bar(stat="identity",width=0.5)

ggplot(BOD, aes(x = factor(Time), y = demand)) +
  geom_bar(stat="identity",width=0.5, color = "red", fill = "darkgrey")

### grouping barchart togather

## stacked bar chart
ggplot(diamonds, aes(x = cut,fill = clarity)) + 
  geom_bar()

## dodged bar chart
ggplot(diamonds, aes(x = cut,fill = clarity)) + 
  geom_bar(position = "dodge")

## add some spaces
ggplot(diamonds, aes(x = cut,fill = clarity)) + 
  geom_bar(position = position_dodge(0.99))

### change the color of the bars

## look at us population change dataset 

?uspopchange
attach(uspopchange)
head(uspopchange)

### subset dataset, and focus on the top 10 states with respect to changes
newpopchange <- uspopchange[order(Change, decreasing =T),]
mysubset <- newpopchange[1:10,]
mysubset

## another way

upc <- subset(uspopchange, rank(Change) >40)

ggplot(upc, aes(x= reorder(Abb, Change), y = Change, fill = Region)) + geom_bar(stat= "identity") +
  scale_fill_manual(values = c("pink","lightblue")) + xlab("State")

### horizontal Bar Chart

ggplot(upc, aes(x= reorder(Abb, Change), y = Change, fill = Region)) + geom_bar(stat= "identity") +
  scale_fill_manual(values = c("pink","lightblue")) + xlab("State") + coord_flip()

ggplot(upc, aes(x= reorder(Abb, Change), y = Change, fill = Region)) + geom_bar(stat= "identity") +
  scale_fill_manual(values = c("pink","lightblue")) + xlab("State") + 
  geom_text(aes(label = Change), vjust=-0.5,color = "blue")

### look ar the Climate Dataset

?climate

nrow(climate)
head(climate)

subclimate <- subset(climate, Source=="Berkeley" & Year >= 1900)

Pos <- subclimate$Anomaly10y >=0

subclimate <- cbind(subclimate, Pos)

ggplot(subclimate, aes(x=Year, y =Anomaly10y, fill=Pos)) + geom_bar(stat = "identity") +
  scale_fill_manual(values = c("lightblue","red"),guide = FALSE)












