library(MASS)
library(RgoogleMaps)
library(RColorBrewer)
source('colorRampPaletteAlpha.R')

# Read in the data
data <- read.csv(file="cl.csv",header=T)
head(data)
str(data)
data$log <- data$long
# Keep the lon and lat data
rawdata <- data.frame(as.numeric(data$log), as.numeric(data$lat))
str(rawdata)
head(rawdata)
names(rawdata) <- c("lon", "lat")
data <- as.matrix(rawdata)
head(data)
nrow(data)
# Rotate the lat-lon coordinates using a rotation matrix
# Trial and error lead to pi/15.0 = 12 degrees
theta = pi/15.0
m = matrix(c(cos(theta), sin(theta), -sin(theta), cos(theta)), nrow=2)
data <- as.matrix(data) %*% m
head(data)
# Reproduce William's original map
par(bg='black')
plot(data, cex=0.1, col="white", pch=16)

# Create heatmap with kde2d and overplot
k <- kde2d(data[,1], data[,2], n=200)
# Intensity from green to red
cols <- rev(colorRampPalette(brewer.pal(8, 'RdYlGn'))(100))
par(bg='white')
image(k, col=cols, xaxt='n', yaxt='n')
points(data)

# Mapping via RgoogleMaps
# Find map center and get map
center <- rev(sapply(rawdata, mean))
map <- GetMap("Los Angeles", zoom=10)
# Translate original data
coords <- LatLon2XY.centered(map, rawdata$lat, rawdata$lon, 30)
coords <- data.frame(coords)
head(coords)
# Rerun heatmap
k2 <- kde2d(coords$newX,coords$newY, n=10)

# Plot
PlotOnStaticMap(map)
image(k2, col=cols, add=T)
points(coords$newX, coords$newY)

