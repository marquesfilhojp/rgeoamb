#'Restricted Use Area (Área de Uso Restrito)
#'
#'Detects restricted use area in DEMs.
#'
#'@param x Input DEM raster file.
#'
#'@examples
#'library(terra)
#'library(rgeoamb)
#'dem <- terra::rast(system.file('ex/elev.tif', package = 'terra'))
#'restricted_use <- rgeoamb::restricted_use_area(dem)
#'plot(restricted_use)
#'@export
restricted_use_area <- function(x){
  slope_angle <- terra::terrain(x, 'slope', neighbors = 8, unit = 'degrees')
  area <- terra::ifel(slope_angle >= 25 & slope_angle <= 45, 1, 0)
  return(area)
}
