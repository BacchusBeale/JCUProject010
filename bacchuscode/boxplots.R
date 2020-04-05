library(ggplot2)
library(gridExtra)
colours <- c("red", "green", "blue")

jpeg(filename = "walkway.jpg", width = 480, height = 480)
p1 <- barplot(t(as.matrix(walkwayTable)), main = "Walkway",
              xlab = "vehicle",
              ylab = "vehicle count",
              col = "cyan",
              horiz = TRUE)
dev.off()

jpeg(filename = "curb.jpg", width = 480, height = 480)
p2 <- barplot(t(as.matrix(curbTable)), main = "curb",
              xlab = "vehicle",
              ylab = "vehicle count",
              col = "darkred",
              horiz = F)

dev.off()
jpeg(filename = "bikelane.jpg", width = 480, height = 480)
p3 <- barplot(t(as.matrix(bikeTable)), main = "bike lane",
              xlab = "vehicle",
              ylab = "vehicle count",
              col = "blue",
              horiz = F)

dev.off()
jpeg(filename = "road1.jpg", width = 480, height = 480)
p4 <- barplot(t(as.matrix(road1Table)), main = "road lane 1",
              xlab = "vehicle",
              ylab = "vehicle count",
              col = "green",
              horiz = F)

dev.off()
jpeg(filename = "road2.jpg", width = 480, height = 480)
p5 <- barplot(t(as.matrix(road2Table)), main = "road lane 2",
              xlab = "vehicle",
              ylab = "vehicle count",
              col = "orange",
              horiz = F)
dev.off()

#grid.arrange(p1,p2,p3,p4,p5, nrow=1)

