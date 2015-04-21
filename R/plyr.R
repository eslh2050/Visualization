# splite apply combine

library(plyr)
?baseball
head(baseball)

baberuth <- subset(baseball, id =="ruthba01")
baberuth <- transform(baberuth, cyear = year - min(year) +1)

baberuth$rbi_ab <- baberuth$rbi/baberuth$ab

library(ggplot2)

ggplot(baberuth, aes(x =cyear, y = rbi_ab)) + geom_line()


baseball_2 <- ddply(baseball, .(id), transform, cyear = max(year)-min(year)+1)

length(unique(baseball$id))

### split by year

pieces <- split(baseball[,"r"], baseball$year)

pieces[2]

avg <- NULL

for(i in seq(1:length(pieces)))
{
  avg[i] <- mean(pieces[[i]])
}

head(avg)

result <- matrix(ncol =2, nrow=length(avg))
result[,1] <- unique(baseball$year)
result[,2] <- avg
colnames(result) <- c("year", "avg_runs")
head(result)

result_ddply<- ddply(baseball, "year", summarize, runs = mean(r))

head(result_ddply)

head(baseball_2)

models <- dlply(baseball_2, .(id), lm, formula = r~ab)
head(models)

summary(models[[2]])

coefs <- ldply(models, coef)
head(coefs)

prediction <- ldply(models, predict, data.frame(ab=500))

baseball_2[c(93,326,337),]

head(prediction)


###
attach(baseball)

range(baseball$year)
data.05_07 <- subset(baseball, year >= 2005)

test_summarize <-ddply(data.05_07, c("id","team"), summarize, homeruns =sum(hr))

head(test_summarize)

test_transform <-ddply(data.05_07, c("id","team"), transform, homeruns =sum(hr))

head(test_transform)

###multiple colums
test_summarize_multiple <-ddply(data.05_07, c("id","year"), summarize, homeruns = sum(hr),
                                numofgames = sum(g),
                                meanhrs = homeruns/numofgames)

head(test_summarize_multiple)
attach(baseball)
test_summarise_multiple <- ddply(data.05_07, c("id", "team"), summarise,
                                 homeruns = sum(hr), numofgames = sum(g),
                                 meanhrs = homeruns/numofgames)
head(test_summarise_multiple)


test_mutate <-ddply(data.05_07, c("id","year"), mutate, homeruns = sum(hr),
                                numofgames = sum(g),
                                meanhrs = homeruns/numofgames)
head(test_mutate)


### Progress bar
##"tk"
test_progree_bar <- ddply(baseball, c("id","year"),summarize,
                          length(year),.progress ="text")

par(mfrow =c(1,3), mar=c(2,2,1,1),oma =c(3,3,0,0))
d_ply(test_transform,"year", transform, plot(homeruns,
                                                 main = unique(year),
                                                 type ="p"))

mtext("year", side = 1, outer =TRUE, line=1)
mtext("frequency", side = 2, outer =TRUE, line=1)

f <- function(x) if (x == 1) stop("Error") else 1
safe.f <- failwith(NA, f, quiet = TRUE)
llply(0:2, safe.f)

mdply(data.frame(a = 1:5, b = 1:5, c = 1:5), sum)
mlply(data.frame(a = 1:5, b = 1:5, c = 1:5), sum)
m_ply(data.frame(a = 1:5, b = 1:5, c = 1:5), sum)


par(mfrow=c(1,1))

healthdata <- read.csv("BRFSS.csv")
head(healthdata)

bmi <- function(weight, height,...)(weight/height^2)*703

bmi(195,76)

bmi_vec <- bmi(healthdata$weight, healthdata$height)
head(bmi_vec)

bmi_vec2 <- splat(bmi)(healthdata)

head(bmi_vec2)

all.equal(bmi_vec,bmi_vec2)

summary(bmi_vec)

mysummary <- function(x)each(min,mean,median,max,sd,var)(x)


colwise(mysummary, is.numeric)(healthdata)


library(dplyr)
?baseball
attach(baseball)
W = subset(baseball, year >= 2005)
hrpergame1 = ddply(W, c("id", "team"), summarise,
                   homeruns = sum(hr),
                   numofgames = sum(g),
                   hrpergame = round(homeruns/numofgames,2))

subset = select(filter(baseball, year >= 2005), id, hr, g)
grouped_data = group_by(subset, id)
hrpergame2 = summarise(grouped_data,
                       homeruns = sum(hr),
                       numofgames = sum(g),
                       hrpergame = homeruns/numofgames)

arrange(hrpergame2, desc(hrpergame))

baseball%>%
  filter(year >= 2005)%>%
  select(id, hr, g)%>%
  group_by(id)%>%
  summarise(homeruns = sum(hr),
            numofgames = sum(g),
            hrpergame = homeruns/numofgames)%>%
  arrange(desc(hrpergame))
















