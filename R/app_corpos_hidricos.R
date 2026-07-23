#' APP Corpos Hídricos
#'
#'\strong{APP Corpos Hídricos}
#'
#'@param green Entrada do arquivo matricial da banda verde (green)
#'@param nir Entrada do arquivo matricial da banda do infravermelho (nir)
#'@param limiar Númerico. Limiar para determinar a extração de corpos hídricos
#'@param buffer Númerico. Área de influência.
#'
#'@examples
#'\dontrun{
#'library(terra)
#'library(rgeoamb)
#'green <- terra::rast(system.file('ex/green.tif', package = 'terra'))
#'nir <- terra::rast(system.file('ex/nir.tif', package = 'terra'))
#'app_ch <- rgeoamb::app_corpos_hídricos(green, nir, 0.1)
#'plot(app_ch)
#'}
#'@export
app_corpos_hidricos <- function(green, nir, limiar){
  ndwi <- (green - nir)/(green + nir)
  ndwi_threshold <- terra::ifel(ndwi >= l, 1, 0)|>
    terra::focal(5, 'modal')|>
    terra::as.polygons()|>
    sf::st_as_sf()|>
    spatialEco::sf_dissolve('focal_modal')|>
    subset(focal_modal == 1)
  ndvi_area <- sf::st_area(ndwi_threshold)/10000
  if(ndvi_area|> as.numeric() >= 20){
    ai <- sf::st_buffer(ndwi_threshold, 100)
  }
  app <- sf::st_difference(ai, ndwi_threshold)
  return(app)
}
