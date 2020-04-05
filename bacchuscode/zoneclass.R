file <-"C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-4-Pedestrians/chunk1-pedestrians.csv"
vehicles <- read.csv(file, header = T, sep = ",")

summary(vehicles)
str(vehicles)

library(dplyr)
frame_min = 1
frame_max = max(vehicles$frame_num)
frameID.list <- seq(1,frame_max,1)

n <- length(frameID.list)

bikelane <- 'BICYCLEPATH'
busCountBL <- integer(length = n)
carCountBL <- integer(length = n)
truckCountBL <- integer(length = n)
personBL <- integer(length = n)
bikeBL <- integer(length = n)

roadlane1 <- 'ROADLANE-1'
busCountRL1 <- integer(length = n)
carCountRL1 <- integer(length = n)
truckCountRL1 <- integer(length = n)
personRL1 <- integer(length = n)
bikeRL1 <- integer(length = n)

roadlane2 <- 'ROADLANE-2'
busCountRL2 <- integer(length = n)
carCountRL2 <- integer(length = n)
truckCountRL2 <- integer(length = n)
personRL2 <- integer(length = n)
bikeRL2 <- integer(length = n)

curb <-'CURBPARKING'
busCountCB <- integer(length = n)
carCountCB <- integer(length = n)
truckCountCB <- integer(length = n)
personCB <- integer(length = n)
bikeCB <- integer(length = n)

walkway <-'PEDESTRIANWALKWAY'
busCountWY <- integer(length = n)
carCountWY <- integer(length = n)
truckCountWY <- integer(length = n)
personWY <- integer(length = n)
bikeWY <- integer(length = n)

nvehicles <- nrow(vehicles)

for (r in 1:nvehicles) {
  f <-  vehicles[r, "frame_num"]
  objectType <- vehicles[r, "classes"]
  objectType <- as.character(objectType)
  zone <- vehicles[r, "zone_name"]
  zone <- as.character(zone)
  
  print(paste("f",f, sep = ":"))
  print(paste("obj",objectType, sep = ":"))
  print(paste("zone",zone, sep = ":"))
  if (f>1) {
    print(paste("carCountCB[f]",carCountCB[f-1], sep = ":"))
  }
  
  switch (objectType,
    "car" = {
      print("car")
      print(zone)
      switch (zone,
        'PEDESTRIANWALKWAY' = {
          print("walkway")
          carCountWY[f] <-carCountWY[f] +1
          
        },
        'BICYCLEPATH' = {
          print("bike")
          carCountBL[f] <-carCountBL[f] +1
          },
        'ROADLANE-1' = {carCountRL1[f] <-carCountRL1[f] +1},
        'ROADLANE-2' = {carCountRL2[f] <-carCountRL2[f] +1},
        'CURBPARKING' = {
          print("curb")
          print(carCountCB[f])
          carCountCB[f] <-carCountCB[f] +1
          print(carCountCB[f])
          }
      )
    },
    
    "bus" = {
      switch (zone,
              'PEDESTRIANWALKWAY' = {busCountWY[f] <-busCountWY[f] +1 },
              'BICYCLEPATH' = {busCountBL[f] <-busCountBL[f] +1},
              'ROADLANE-1' = {busCountRL1[f] <-busCountRL1[f] +1},
              'ROADLANE-2' = {busCountRL2[f] <-busCountRL2[f] +1},
              'CURBPARKING' = {busCountCB[f] <-busCountCB[f] +1}
      )
    },
    
    "truck"= {
      switch (zone,
              'PEDESTRIANWALKWAY' = {truckCountWY[f] <-truckCountWY[f] +1 },
              'BICYCLEPATH' = {truckCountBL[f] <-truckCountBL[f] +1},
              'ROADLANE-1' = {truckCountRL1[f] <-truckCountRL1[f] +1},
              'ROADLANE-2' = {truckCountRL2[f] <-truckCountRL2[f] +1},
              'CURBPARKING' = {truckCountCB[f] <-truckCountCB[f] +1}
      )},
    
      "person"= {
        switch (zone,
                'PEDESTRIANWALKWAY' = {personWY[f] <-personWY[f] +1 },
                'BICYCLEPATH' = {personBL[f] <-personBL[f] +1},
                'ROADLANE-1' = {personRL1[f] <-personRL1[f] +1},
                'ROADLANE-2' = {personRL2[f] <-personRL2[f] +1},
                'CURBPARKING' = {personCB[f] <-personCB[f] +1}
        )
        },
    
        "bicycle"= {
          switch (zone,
                  'PEDESTRIANWALKWAY' = {bikeWY[f] <-bikeWY[f] +1 },
                  'BICYCLEPATH' = {bikeBL[f] <-bikeBL[f] +1},
                  'ROADLANE-1' = {bikeRL1[f] <-bikeRL1[f] +1},
                  'ROADLANE-2' = {bikeRL2[f] <-bikeRL2[f] +1},
                  'CURBPARKING' = {bikeCB[f] <-bikeCB[f] +1}
          )
          }
    
    ) #end switch classes
    
}# for row


walkwayTable <- data.frame(car=carCountWY, bus=busCountWY, truck=truckCountWY,
                           person=personWY, bike=bikeWY)

curbTable <- data.frame(car=carCountCB, bus=busCountCB, truck=truckCountCB,
                        person=personCB, bike=bikeCB)

bikeTable <- data.frame(car=carCountBL, bus=busCountBL, truck=truckCountBL,
                        person=personBL, bike=bikeBL)

road1Table <- data.frame(car=carCountRL1, bus=busCountRL1, truck=truckCountRL1,
                         person=personRL1, bike=bikeRL1)

road2Table <- data.frame(car=carCountRL2, bus=busCountRL2, truck=truckCountRL2,
                         person=personRL2, bike=bikeRL2)

write.csv(walkwayTable, "walkway_pedestrians.csv")
write.csv(curbTable, "curb_pedestrians.csv")
write.csv(bikeTable, "bikelane_pedestrians.csv")
write.csv(road1Table, "road1_pedestrians.csv")
write.csv(road2Table, "road2_pedestrians.csv")

library(ggplot2)
library(gridExtra)

jpeg(filename = "walkwaypedestrians.jpg", width = 480, height = 480)
p1 <- barplot(t(as.matrix(walkwayTable)), main = "Walkway",
              xlab = "frame num",
              ylab = "count",
              horiz = F)
dev.off()

jpeg(filename = "curbpedestrians.jpg", width = 480, height = 480)
p2 <- barplot(t(as.matrix(curbTable)), main = "curb",
              xlab = "frame num",
              ylab = "count",
              horiz = F)

dev.off()
jpeg(filename = "bikelanepedestrians.jpg", width = 480, height = 480)
p3 <- barplot(t(as.matrix(bikeTable)), main = "bike lane",
              xlab = "frame num",
              ylab = "count",
              horiz = F)

dev.off()
jpeg(filename = "road1pedestrians.jpg", width = 480, height = 480)
p4 <- barplot(t(as.matrix(road1Table)), main = "road lane 1",
              xlab = "frame num",
              ylab = "count",
              horiz = F)

dev.off()
jpeg(filename = "road2pedestrians.jpg", width = 480, height = 480)
p5 <- barplot(t(as.matrix(road2Table)), main = "road lane 2",
              xlab = "frame num",
              ylab = "count",
              horiz = F)
dev.off()


