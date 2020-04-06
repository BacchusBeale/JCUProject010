#google maps gps
# https://www.google.com/maps/place/38%C2%B034'29.4%22N+121%C2%B028'56.1%22W/@38.574827,-121.4827992,19z/data=!3m1!4b1!4m14!1m7!3m6!1s0x809ac672b28397f9:0x921f6aaa74197fdb!2sSacramento,+CA,+USA!3b1!8m2!3d38.5815719!4d-121.4943996!3m5!1s0x0:0x0!7e2!8m2!3d38.5748256!4d-121.4822521
# pt1 is north of pt2
pt1.lat = 38.574337
pt1.long = -121.482464
pt2.lat = 38.574826
pt2.long =-121.482252
latdist = pt2.lat - pt1.lat
longdist = pt2.long - pt1.long

# Total distance: 57.88 m (189.90 ft)
roadlength = 189.90 #diagonal
# road width: Total distance: 12.41 m (40.73 ft)
roadwidth = 40.73
anglecos = roadwidth /roadlength
roadangle = acos(anglecos)

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
curbparking <- filter(vehicles, vehicles$zone_name=="CURBPARKING")
curbdata <- select(curbparking, "x", "bbox_xmin", 
                      "bbox_ymin", "classes", "is_parked")
curbdata <- mutate(curbdata, latitude=(latdist*(bbox_xmin - fovMinX)/fovWidth)-pt1.long,
longitude = (longdist*(bbox_ymin - fovMinY)/fovHeight)-pt2.lat)

write.csv(curbdata, "gpscurbdata.csv")
