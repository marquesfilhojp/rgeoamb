#'Water Bodies (APPs Corpos Hídricos)
#'
#'Identifies Permanent Preservation Areas (APPs) in water bodies.
#'
#'@param green Input raster object for the green band input.
#'@param nir Input raster object for the near-infrared (NIR) band input.
#'@param threshold Numeric. Threshold used to extract water bodies.
#'@param buffer Numeric. Buffer distance (zone of influence).
#'
#'@examples
#'library(terra)
#'library(rgeoamb)
#'green <- terra::rast(system.file('ex/green.tif', package = 'terra'))
#'nir <- terra::rast(system.file('ex/nir.tif', package = 'terra'))
#'wb <- rgeoamb::water_bodies(green, nir, 0.1)
#'plot(wb)
#'@export
water_bodies <- function(green, nir, threshold, buffer){
  ndwi <- (green - nir)/(green + nir)
  ndwi_threshold <- terra::ifel(ndwi >= threshold, 1, 0)|>
    terra::focal(5, 'modal')|>
    terra::as.polygons()|>
    sf::st_as_sf()|>
    spatialEco::sf_dissolve('focal_modal')|>
    subset(focal_modal == 1)
  ndvi_area <- sf::st_area(ndwi_threshold)/10000
  if(ndvi_area|> as.numeric() >= 20){
    ai <- sf::st_buffer(ndwi_threshold, 100)
  }
  wb <- sf::st_difference(ai, ndwi_threshold)
  return(wb)
}
