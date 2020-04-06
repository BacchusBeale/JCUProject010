
vfile <- "C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-3-vehicles/chunk1-vehicles.csv"
vehicles <- read.csv(vfile, header = T, sep = ",")

# fov=field of view
fovMinX=min(vehicles$bbox_xmin)
fovMinY=min(vehicles$bbox_ymin)
fovMaxX=max(vehicles$bbox_xmax)
fovMaxY=max(vehicles$bbox_ymax)
fovWidth=fovMaxX-fovMinX
fovHeight=fovMaxY-fovMinY 

library(dplyr)
cardata = filter(vehicles, vehicles$classes=="car")
# calculate avg car size
carlength = cardata$bbox_xmax - cardata$bbox_xmin
summary(carlength)
caravglength = mean(carlength)

curbdata = filter(vehicles, vehicles$zone_name=="CURBPARKING")
# find curb length
curblength = max(curbdata$bbox_xmax) - min(curbdata$bbox_xmin)

# find avg number car spaces on curb
avgcarspaces = curblength/caravglength

#length of stay
# calculate parking times
xID <- select(vehicles, "x", "trackedID","is_parked","bbox_xmin","bbox_ymin", "zone_name")
parked <- filter(xID, xID$is_parked=="True")
trackID.list <- unique(parked$trackedID)
trackID.list <- sort(trackID.list)

n <- length(trackID.list)
tsecs <- numeric(length = n)
xpos <- numeric(length = n)
ypos <- numeric(length = n)
zone <- character(length = n)
index = seq(from=1,to=n,by=1)

for (i in index) {
  id <- trackID.list[i]
  byID <- filter(parked, parked$trackedID==id)
  xbyID <- byID$x
  xmin <- min(xbyID)
  xmax <- max(xbyID)
  t <- xmax - xmin
  tsecs[i] <- t
  # x y pos
  xpos[i] = byID$bbox_xmin # along the road
  ypos[i] = byID$bbox_ymin # across the road zones
  zone[i] = byID$z
}

tmins = tsecs / 60
summary(tmins)

jpeg(filename = "Parkingtimes.jpg", width = 480, height = 480)
p1<-plot(x=trackID.list, y=tmins, main = "parking time in minutes")
dev.off()

jpeg(filename = "ParkingPositionX.jpg", width = 480, height = 480)
p2<-plot(x=xpos, y=tmins, main = "parking position along roadside",xlab="min x position", ylab="parking time mins")
dev.off()

jpeg(filename = "ParkingPositionY.jpg", width = 480, height = 480)
p3 <-plot(x=ypos, y=tmins, main = "parking position across roadside",xlab="min y position", ylab="parking time in zones")
dev.off()

jpeg(filename = "ParkTimeVSZoneBoxplot.jpg", width = 480, height = 480)
boxdata = data.frame(parktime=tmins, curbposition=xmin)
boxplot(boxdata$parktime ~ boxdata$curbposition, data = boxdata, xlab = "time", ylab="curb position")
dev.off()

# number of vehicles in curb over time

# count double parked over time

# count objects not in correct zone eg bike on road or walkway