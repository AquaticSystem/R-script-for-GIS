#### Converting NetCDF files to GeoTIFF and crop to the provided extent
#### based on xuanlongma script ('https://gist.github.com/xuanlongma/5874674')
#### with some modifications by Galia Shinkareva

# Packages required -----
if (!require(dplyr)) install.packages('dplyr')
if (!require(raster)) install.packages('raster')
if (!require(ncdf4)) install.packages('ncdf4')
if (!require(sf)) install.packages('sf')
library(raster)
library(ncdf4)
library(sf)


# Input directory -----
dir.nc <- 'data/input files_nc/' #provide directory with NetCDF files

## Get input filenames -----
files.nc <- list.files(dir.nc, full.names = TRUE, recursive = TRUE)

# Output directory -----
dir.output <- 'data/output files_geotiff/' #provide directory for GeoTIFF files

## Create output filenames -----
files.gtif <- gsub(".nc", "", basename(files.nc))


# Get a desired extent -----
crop_poly <- sf::st_read("data/shapefiles/Tanganyika.shp") #provide a shapefile to get an extent from
raster_crop_poly <- raster(crop_poly) #'GTiff', , sep = ''
crop_extent <- as(extent(bbox(raster_crop_poly)), 'SpatialPolygons')

# crop_extent <- as(extent(28, 35, -15, 3), 'SpatialPolygons') #or provide the extent manually, here it is: 28°E, 15°S, 35°E, 3°N 


# Batch converting and cropping -----

for (i in 1:length(files.nc)) {
     library(dplyr)
     r.nc <- raster(files.nc[i]) %>%
          crop(crop_extent)
     writeRaster(x = r.nc,
                 filename = paste(dir.output, files.gtif[i], '.tiff', sep = ''),
                 format = 'GTiff',
                 overwrite = TRUE)
}
