#'Relative Relief (Amplitude Altimétrica)
#'
#'Calculates Relative Relief in DEMs.
#'
#'@param x Input DEM raster file.
#'@param scale Numeric. Number of neighbor cells for multiscalar analysis.
#'
#'@examples
#' library(terra)
#' library(rgeoamb)
#' dem <- terra::rast(system.file('ex/elev.tif', package = 'terra'))
#' rr <- rgeoamb::relative_relief(dem)
#' plot(rr)
#'@export
relative_relief <- function(x){
  min <- terra::focal(x, scale, 'min')
  max <- terra::focal(x, scale, 'max')
  rr <- max - min
  return(rr)
}
