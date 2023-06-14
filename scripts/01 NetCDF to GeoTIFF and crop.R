#' Converting NetCDF files to GeoTIFF and crop to the provided extent (part 1.)
#' Or just crop and keep the same format (part 2.)
#' based on xuanlongma script ('https://gist.github.com/xuanlongma/5874674')
#' with modifications by Galina Shinkareva


# Packages required -----
if (!require(dplyr)) install.packages('dplyr')
if (!require(raster)) install.packages('raster')
if (!require(ncdf4)) install.packages('ncdf4')
if (!require(sf)) install.packages('sf')
library(raster)
library(ncdf4)
library(sf)

# 1. Batch converting and cropping -----
## Input directory -----
dir.nc <- 'data/input files_nc/' #provide directory with NetCDF files

## Get input filenames -----
files.nc <- list.files(dir.nc, full.names = TRUE, recursive = TRUE)

## Output directory -----
dir.output <- 'data/output files_geotiff/' #provide directory for GeoTIFF files

## Create output filenames -----
files.gtif <- gsub(".nc", "", basename(files.nc))

## Get a desired extent -----
### provide the extent manually -----
crop_extent <- as(extent(28, 36, -15, 3), 'SpatialPolygons') #here the extent is: 28°E, 15°S, 36°E, 3°N

### provide a shapefile to get an extent from -----
# crop_poly <- sf::st_read("data/yourshapefile.shp") #or provide a shapefile
# raster_crop_poly <- raster(crop_poly) #'GTiff', , sep = ''
# crop_extent <- as(extent(bbox(raster_crop_poly)), 'SpatialPolygons')


## Loop for converting and cropping -----

for (i in 1:length(files.nc)) {
     library(dplyr)
     r.nc <- raster(files.nc[i]) %>%
          crop(crop_extent)
     writeRaster(x = r.nc,
                 filename = paste(dir.output, files.gtif[i], '.tiff', sep = ''),
                 format = 'GTiff',
                 overwrite = TRUE)
}

# 2. Batch cropping, leaving the same format -----

## Input directory -----
dir.nc <- 'data/input files_nc/' #provide directory with NetCDF files

## Get input filenames -----
files.nc <- list.files(dir.nc, full.names = TRUE, recursive = TRUE)

## Output directory -----
dir.output <- dir.output <- 'data/output files_nc_cropped/' #provide directory for cropped files

## create output filenames -----
files.netCDF <- gsub(".nc", "", basename(files.nc))

## Get a desired extent -----
### provide the extent manually -----
crop_extent <- as(extent(28, 36, -15, 3), 'SpatialPolygons') #here the extent is: 28°E, 15°S, 36°E, 3°N

## Loop for cropping -----
for (i in 1:length(files.nc)) {
     library(dplyr)
     r.nc <- raster(files.nc[i]) %>%
          crop(crop_extent)
     writeRaster(x = r.nc,
                 filename = paste(dir.output, files.netCDF[i], '.nc', sep = ''),
                 format = 'CDF',
                 overwrite = TRUE)
}
