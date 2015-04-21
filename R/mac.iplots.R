###iplots package
### 1. install iplots in Mac
install.packages(c("JGR","Deducer","DeducerExtras","iplots"))
library(rJava)
library(JavaGD)
library(iplots)
Sys.setenv(NOAWT=1)
library(JGR)
Sys.unsetenv("NOAWT")
JGR()
#run the codes in the new console

library(MASS)
data(Cars93)
head(Cars93)
attach(Cars93)
imosaic(AirBags,Cylinders,Origin, type="flu")
iplot.opt(fillColor="yellow", borderColor="white",fillColorSel="green",borderColorSel="white")

#barchart
ibar(Cylinders)
ibar(Cylinders, iSpine=T)
levels(AirBags)
AirBagO <- ordered(AirBags, c("None","Driver only","Driver & Passenger"))

iplot.data(id=NULL)

iplot(Horsepower,  MPG.city)

# iplot size
iplot.size(width = 600, height = 400, plot = iplot.cur())

iplot.list()

## parallel coordinates plots
?ipcp

head(Cars93)
ipcp(MPG.city, MPG.highway, Weight)

### Mosaic Plot
## Mosaicplots
imosaic(AirBags,Cylinders, Origin)
?imosaic
imosaic(AirBags,Cylinders, Origin,type="multiple.barchart")
imosaic(AirBags,Cylinders, Origin,type="fluctuation")
# iplot.opt : add additional information to the plot
iplot.opt(fillColor="red",borderColor="white",fillColorSel="yellow",borderColorSel="black"
)

## Convension
# Interactive graphics benefits strongly from an interface which is highly consistent and
has a flat learning curve. The most important functionality within iPlots are the keyboard
shortcuts and modifier keys.
#.to query an object or plot canvas : mouse-over while <ctrl> is pressed
#.ctrl>+r : rotates plots
#.<command>-drag-box (MAC), middle mouse button zooms in and out


#================================
## Barcharts
ibar(Cylinders)
?ibar
ibar(Cylinders,isSpine=T)
#Bars can be reordered either by using the options in the "View" menu or by <alt>-
dragging a bar to its desired position.
#iPlots respect the order of a factor, so orderings from within R can be used to order the
categories in a barchart.
levels(AirBags)
AirBagsO <- ordered(AirBags,c("None", "Driver only", "Driver & Passenger"))
levels(AirBagsO)
ibar(AirBags)
ibar(AirBagsO)
#iplot.data : retireve data from a plot
iplot.data(id=NULL)

#================================
##Scatterplot
#(Scatterplots in iPlots can be used in the same way as the standard scatterplot in R)
iplot(Horsepower, MPG.city,xlab="Horsepower",ylab="MPG.City")
# change the point size to 5 and color the point by number of cylinders
# Unclass : returns (a copy of) its argument with its class attribute removed
iplot.opt(ptDiam=6,col=unclass(Cylinders),title="Horsepower vs. MPG.City
Scatterplot",rotateYLabelsBy=45,
          xlim=c(100,300),ylim=c(10,40))
#iplot.size : change the plot size
iplot.size(width=600, height=400, plot=iplot.cur())
iplot.data(id=NULL)
#iplot.list : returns all currently registered iplots (even if they are hidden)
iplot.list()

#================================
### Parallel plots
# 1-Parallel coordinates plot
?ipcp
#It clearly shows nuanced relationships between several different data points, and it is
much like a scatterplot, but scaled to encompass many different axes.
# list of at least two variables or a data frame
ipcp(MPG.city, Weight)
ipcp(MPG.city, MPG.highway, Weight)
# Additional parameters:
# alterningLabels: Whether labels should be placed alternately at the top and at the
bottom. Default is TRUE.
ipcp(MPG.city, MPG.highway, Weight, alterningLabels = F)
# We can also select options in the tags to make changes to the graph
# View/Rotate, Alternating labels, show dots, show axes
# Color of the (optional) axes
ipcp(MPG.city, MPG.highway, Weight, alterningLabels = F, COL_AXES = "red")
# iplot.opt : add additional information to the plot
iplot.opt(borderColor = "blue", title = "MPG & Weight")
#===========================
#2-Parallel Boxplot
?ibox
# x is the variable the you want to look at, y is optional
# if y is not specified, a regular boxplot as we used before
# if y is specified, it is a x-by-y boxplot
head(Cars93)
# 1) make a parallel boxplot for two MPG variable
ibox(Cars93[7:8])
# 2) create a x-by-y boxplot, both x and y must be of the same length.
ibox(Price, Manufacturer)
# makeup the graph
iplot.opt(fillColor = "pink", fillColorSel = "yellow", title = "Price by Manufacturer")
# right click the graph: sort by


#=============================
## Histograms
?ihist
ihist(Horsepower)
#Binwith and anchorpoint can either be changed interactively by <alt>-dragging the
leftmost interval border (anchorpoint) or any other bin break (binwidth), or by explicitly
specifying the two parameters via iplot.opt() or when creating the plot.
ihist(Horsepower)
iplot.opt(anchor = 25, binw = 25, fillColor = "blue", borderColor = "white", fillColorSel =
            "yellow", title = "Histogram of Horsepower")
# we can also use mouse: right click the graph
# increase/decrease binwidth; move anchor left/right
#==============================
## Interactive Map
?imap
#load the map library
library(maps)
# use map function to create an object of "map", but do not plot it here
m <- map('state', fill = TRUE, plot=FALSE)
# then use imap
imap(m)
#=====================================
Selections and colorbrushing
#Intro to iplots: provides interactive mosaic plots, bar plots, box plots,
#You can select and identify observations using the mouse,
#and highlighting observations in one graph will automatically highlight the same
observations in all other open graphs.
###You can also use the mouse to obtain information about graphic objects
###such as points, bars, lines, and box plots.
attach(mtcars)
cylinders <- factor(cyl)
gears <- factor(gear)
transmission <- factor(am)

ihist(mpg)
ibar(gears)
iplot(mpg, wt)
ibox(mtcars[c("mpg", "wt", "qsec", "disp", "hp")])
ipcp(mtcars[c("mpg", "wt", "qsec", "disp", "hp")])
imosaic(transmission, cylinders)
detach(mtcars)
## we are using different kinds of plots showing the same factors, and we can acquire
information
## by clicking the mouse and using select function.
##1. Click on the three-gear bar in the Barchart (gears) window.
###The bar will turn red. In addition, ALL CARS with three-gear engines will be
highlighted in the other graph windows.
##2. Mouse down and drag to select a rectangular region of points in the Scatter plot
(wt vs mpg) window.
###These points will be highlighted and the corresponding observations in every other
graph window will also turn red.
###3. Hold down the Ctrl key and move the mouse pointer over a point, bar, box plot, or
line in one of the graphs.
###Details about that object will appear in a pop-up window.
###4. Right-click on any object and note the options that are offered in the context
MENU.
###For example, you can right-click on the Boxplot (mpg) window and change the graph
to a parallel coordinates plot (PCP).
###5. You can drag to SELECT more than one object (point, bar, and so on) or use
Shift-click to select noncontiguous objects.
###Try selecting both the three- and five-gear bars in the Barchart (gears) window.
###6. use selection function
iset.select(gear>3)
# select all cases for cars with more than 3 gears.
###7. use color brush
###Selections are a transient attribute of the data. Whenever a new selection is defined,
the old selection state is overwritten.

###A persistent color attribute can be defined using color brushing within iPlots.
# set colors according to gears
iplot.opt(col=unclass(gear))
###A second option for using color brushing is to apply rainbow colors over the range of
a continuous variable.
###The menu command "View > Set Colors (rainbow)" will set the color scheme.
#=====================================
## iObjects Toolkit
### Every iPlot can have an arbitrary number of additional graphical objects attached,
such as lines, rectangles, polygons or labels. Those objects, called iObjects, appear in
the plot graphics and are programmable as of shape, position and color.
## read the iplots, data
library(rJava)
library(iplots)
library(MASS)
data(Cars93)
attach(Cars93)
1. iabline
These functions add a straight line to the current iPlot.
iplot(Horsepower, MPG.city,xlab="Horsepower",ylab="MPG.City")
iabline(lm(MPG.city~ Horsepower), col = "#800000")
2. iobj.rm()
Remove the current iobjects
iplot(Horsepower, MPG.city,xlab="Horsepower",ylab="MPG.City")
iabline(lm(MPG.city~ Horsepower), col = "#800000")
iobj.rm()
3. ilines
It takes given coordinates and joins the corresponding points with line segments. The
resulting iObject is a polygon or a polyline.The color of the lines can be specified as well
as the fill color of the enclosed area.
ilines(x=Horsepower, y= MPG.city, plot = iplot.cur())

ilines(x=Horsepower, y= MPG.city, col="#FFFF00", fill="#"NULL, visible=NULL, plot =
       iplot.cur())
ilines(x=Horsepower, y= MPG.city, col="#FFFF00", fill=NULL, visible=NULL, plot =
         iplot.cur())
4. itext
itext(Horsepower,MPG.city,plot = iplot.cur())
# create a default lowess smoother
l <- lowess(Horsepower, MPG.city)
# use ilines() to add the smoother to the iplot()
ilines(l)
# we like to have it a bit rougher, so we remove the first smooth
iobj.rm()
# and rerun the lowess and plot it again.
l <- lowess(Horsepower, MPG.city, f=0.5)
ilines(l)
ilines(l,col="#0000FF")
#=====================================
Interactive Graphics
The base installation of R provides limited interactivity with graphs. You can modify
graphs by issuing additional program statements, but there's little that you can do to
modify them or gather new information from them using the mouse. However, there are
contributed packages that greatly enhance your ability to interact with the graphs you
create - playwith, latticist, iplots, and rggobi.
- Interacting with Plots
# R offers two basic functions to interact with plots, identify() for identifying points and
locator() for coordinating locations in plots.
# The identify() function can be used to return the position of the closest data point
when the mouse button is pressed. It searches the coordinates given in x and y for the
point closest to the click. If this point is close enough to the click, its index will be
returned as part of the value of the call. Let's see an example for identifying data points
on the scatterplots.
?identify
data(Cars93)
attach(Cars93)

plot(Horsepower, MPG.city, xlab = "Horsepower", ylab = "MPG.city")
identify(Horsepower, MPG.city, labels = seq_along(Horsepower), n=3)
# "x=" specifies the x-coords of the plotted points, "y=" specifies the y-coords, "labels="
is a character vector of labels to be used, and "n=" specifies the number of points to be
labeled (default is number of values in x).
# R is now waiting for you to click on any 3 data points on the scatterplot. When you do,
the points will be labeled with the closest x-coords index number. (If we hadn't specified
                                                                    "labels=", the labels would be the index number of the case in the data frame.)
                                                                    # The locator() function returns the coordinates of a mouse click made on a graph. It
                                                                    does not return the coordinates of a data point. So by clicking on these points, we will
                                                                    get the approximate data values.
                                                                    ?locator
                                                                    plot(Horsepower, MPG.city, xlab = "Horsepower", ylab = "MPG.City")
                                                                    locator(n = 2, type = "l")
                                                                    # Center the cross cursor over the point you want to identify and click the left mouse
                                                                    button. Click on the other point (you've asked to identify two points) and R will return
information about those points.
# type "l" or "o": points are joined by lines
# locator() will remain active until it locates as many mouse clicks as you asked for, or
until you tell it to stop. So be sure you give it a number as an argument when you use
this function.






