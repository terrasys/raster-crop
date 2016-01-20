#source("raster-crop.R")
#######################################################################################################
#######################################################################################################
#######################################################################################################
#Subsetting of one-band raster files and cloud filter
#######################################################################################################
#######################################################################################################
#######################################################################################################
#packages
#######################################################################################################
loadandinstall <- function(mypkg) {if (!is.element(mypkg,
                                                   installed.packages()[,1])){install.packages(mypkg)};
  library(mypkg, character.only=TRUE)}
pk <- c("raster","rgdal","maptools","sp")
for(i in pk){loadandinstall(i)}
#######################################################################################################
#Interactive choosing of working directory
#######################################################################################################
w.dir <- file.path(choose.dir(default = "", caption = "Choose working directory"))
raster.dir <- "_data/_starfm/"
vector.dir <- "_data/_vector/"
result.dir <- "_result"
#######################################################################################################
#threshold for cloud cover
#######################################################################################################
TH <- 30
#######################################################################################################
#import shape
#######################################################################################################
setwd(file.path(w.dir,vector.dir))
list.files(pattern="*.*\\.shp$")
vector.shp <- list.files(pattern="*.*\\.shp$")
shape <- readOGR(file.path(w.dir,vector.dir), substr(vector.shp,1,nchar(vector.shp)-4))
#######################################################################################################
#Definition of possible data  formates
#######################################################################################################
Filters <- matrix(c("bin", "*.bin","tif", "*.tif", "asc", "*.asc", "flt", "*.flt",
                    "SAGA", "*.sdat", "All files", "*"),
                  6, 2, byrow = TRUE)
rownames(Filters) <- c("bin","tif", "asc","flt","SAGA","All files")
print(noquote(rownames(Filters)))
ft <- readline(prompt = "Enter a file format: ")
#######################################################################################################
#import raster
#######################################################################################################
setwd(file.path(w.dir,raster.dir))
pattern.ls <- list.files(pattern=paste("*.*\\.",noquote(Filters[[c(ft),1]]),"$",sep=""))
pattern.ls
#reading raster and conversation to RASTER object
for (i in pattern.ls){
  setwd(file.path(w.dir,raster.dir))
  ndvi <- raster(i)
#crop
  ndvi.crop <- crop(ndvi, extent(shape),cellnumbers=TRUE)
  CL <- freq(ndvi.crop,value=-9999)*100/sum(freq(ndvi.crop)[,2])
#export
setwd(file.path(w.dir,result.dir))
if(CL < TH)
writeRaster(ndvi.crop, filename=paste('testsite_',i,sep=""), format="ascii", overwrite=TRUE)
}