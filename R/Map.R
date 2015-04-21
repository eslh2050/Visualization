### Load Packages

library(ggplot2)
library(maps)


### Plot the USA map with the states
states_map <- map_data("state")
class(states_map)

head(states_map)

ggplot(states_map, aes(x = long, y =lat, group = group)) +
  geom_polygon(fill = "white", color = "black")

world_map <- map_data("world")

ggplot(world_map, aes(x = long, y =lat, group = group)) +
  geom_polygon(fill = "white", color = "black")

Lebanon <- map_data("world", region = "Lebanon")

ggplot(Lebanon, aes(x = long, y =lat, group = group)) +
  geom_polygon(fill = "white", color = "black")

far_East <- map_data("world", region = c("Japan","China","North Korea","South Korea"))

ggplot(far_East, aes(x = long, y =lat, group = group)) +
  geom_polygon(fill = "white", color = "black")

countryNames <- unique(world_map$region)
head(sort(countryNames))

#### Choropleth Maps

head(USArrests)
?USArrests

crimes <- data.frame(state =tolower(rownames(USArrests)), USArrests)
head(crimes)

head(states_map)

library(plyr)

crime_map <- merge(states_map, crimes, by.x = "region", by.y = "state")
head(crime_map)

### rearrange by group and order

crime_map = arrange(crime_map, group, order)
head(crime_map)

ggplot(crime_map, aes(x = long, y = lat, group = group, fill = Assault)) +
  geom_polygon(color = "black")





##### look at google maps
library(ggmap)

qmap("University of Southern California", zoom = 15)

qmap("University of Southern California", zoom = 15, maptype = "satellite")

qmap("University of Southern California", zoom = 15, maptype = "roadmap")


### utility function in group

geocode("white house")

revgeocode(c(-77.03653,38.89768))


#### Crime data in Houston

qmap("Houston")


### focus on crime data in downtown Houston

gglocator(2)
head(crime)


dt_crime <- subset(crime, lon >= -95.54 & lon <= -95.14 &
                     lat >= 29.61 & lat <= 29.95)

### focus on violent crime

levels(dt_crime$offense)

violent_crimes <- subset(dt_crime, offense%in% c("aggravated assault", "murder","rape", "rubbery"))

violent_crimes

head(violent_crimes)

HoustonMap <- qmap("Houston", zoom = 14)


HoustonMap +
  geom_point(data = violent_crimes,
             aes(x = lon, y = lat, color = offense))



### binning with alpha blending

HoustonMap + 
  stat_bin2d(data = violent_crimes,
             aes(x = lon, y =lat, color =offense),
                  bins = 25, alpha = 0.4) +
   facet_wrap(~day)


































