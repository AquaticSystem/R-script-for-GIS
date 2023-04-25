# R-script-for-GIS

### Intro

This script allows to convert NetCDF files to GeoTIFF files in a batch and crop to the provided extent. There is an option to provide an extent manually or from a shapefile.

The batch convertion idea is based on xuanlongma script ('<https://gist.github.com/xuanlongma/5874674>') with some modifications.

The original goal was to be able to take raw images from MODIS AQUA satellite in NetCDF format from Giovanni web-site, convert them to GeoTIFF format, and crop the area of interest. But most importantly do all of this in a batch for the entire dataset.

### Required Packages

-   Reading, writing, manipulating, analyzing and modeling of spatial data:

    -   raster

    -   ncdf4

    -   sf

-   working with data in pipes:

    -   dplyr

