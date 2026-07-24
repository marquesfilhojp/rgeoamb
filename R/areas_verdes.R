#' Detecção de Áreas Verdes
#'
#'\strong{Detecção de Áreas Verdes}
#'
#'@param nir Entrada do arquivo matricial da banda do infravermelho (nir).
#'@param red Entrada do arquivo matricial da banda do vermelho (nir).
#'@param amm Númerico. Depende da função Área Mínima Mapeável.
#'@param l1 Númerico. Primeiro intervalo para determinar a extração das áreas verdes.
#'@param l2 Númerico. Segundo Intervalo para determinar a extração das áreas verdes.
#'@param l3 Númerico. Intervalos entre os limiares para determinar a extração das áreas verdes.
#'
#'@examples
#'\dontrun{
#'library(terra)
#'library(rgeoamb)
#'nir <- terra::rast(system.file('ex/nir.tif', package = 'terra'))
#'red <- terra::rast(system.file('ex/red.tif', package = 'terra'))
#'av <- rgeoamb::mascara_vegetacao(nir, red, 5, 0.33, 0.40, 0.01)
#'plot(av)
#'}
#'@export
areas_verdes <- function(nir, red, amm, l1, l2, l3){
  ndvi <- (nir - red)/(nir + red)
  ndvi_amm <- terra::focal(ndvi, amm, 'modal')
  ndvi_threshold <- terra::ifel(ndwi_amm >= seq(l1, l2, by = l3), 1, 0)
  return(ndvi_threshold)
}
