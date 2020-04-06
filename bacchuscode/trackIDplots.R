
vehicle1.file <-"C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-3-vehicles/chunk1-vehicles.csv"
chunk1.vehicles <- read.csv(vehicle1.file, header = T, sep = ",")

# header.names = names(chunk1.vehicles)
# summary(chunk1.vehicles)
# str(chunk1.vehicles)

# calculate parking times
library(dplyr)
xID <- select(chunk1.vehicles, "x", "trackedID","is_parked","bbox_xmin","bbox_ymin")
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
}

tmins = tsecs / 60
summary(tmins)

p1<-plot(x=trackID.list, y=tmins, main = "parking time in minutes- chunk 4")

p2<-plot(x=xpos, y=tmins, main = "parking position along roadside",xlab="min x position", ylab="parking time mins")

p3 <-plot(x=ypos, y=tmins, main = "parking position across roadside",xlab="min y position", ylab="parking time in zones")
