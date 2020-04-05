vfile1 <-"C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-4-vehicles/chunk1-vehicles.csv"
vfile2 <-"C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-4-vehicles/chunk2-vehicles.csv"
vfile3 <-"C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-4-vehicles/chunk3-vehicles.csv"
vfile4 <-"C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-4-vehicles/chunk4-vehicles.csv"

bfile1 <-"C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-4-bicycles/chunk1-bicycles.csv"
bfile2 <-"C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-4-bicycles/chunk1-bicycles.csv"
bfile3 <-"C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-4-bicycles/chunk1-bicycles.csv"
bfile4 <-"C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-4-bicycles/chunk1-bicycles.csv"

pfile1 <-"C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-4-Pedestrian/chunk1-pedestrian.csv"
pfile2 <-"C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-4-Pedestrian/chunk2-pedestrian.csv"
pfile3 <-"C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-4-Pedestrian/chunk3-pedestrian.csv"
pfile4 <-"C:/AAA/data/CITY OF SACREMENTO DATA/CSV/Chunk1-4-Pedestrian/chunk4-pedestrian.csv"

filelist = list(vfile1,vfile2,vfile3,vfile4,
                bfile1,bfile2,bfile3,bfile4,
                pfile1,pfile2,pfile3,pfile4)

vehicles <- read.csv(file, header = T, sep = ",")
