#'APP > 45°
#'
#'Identifies Permanent Preservation Areas (APPs) in slope angles > 45°.
#'
#'@param x Input DEM raster file.
#'
#'@examples
#'library(terra)
#'library(rgeoamb)
#'dem <- terra::rast(system.file('ex/elev.tif', package = 'terra'))
#'app <- rgeoamb::app_45(dem)
#'plot(app)
#'@export
app_45 <- function(x){
  slope_angle <- terra::terrain(x, 'slope', neighbors = 8, unit = 'degrees')
  app <- terra::ifel(slope_angle >= 45, 1, NA)
  return(app)
}
