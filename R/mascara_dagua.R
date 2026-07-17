#' Máscara d'água
#'
#'\strong Máscara d'água
#'
#'@param x Entrada do arquivo matricial da banda verde (green).
#'@param y Entrada do arquivo matricial da banda do infravermelho (nir).
#'@param amm Númerico. Depende da função Área Mínima Mapeável
#'@param l1 Númerico. Primeiro intervalo para determinar a extração de corpos hídricos.
#'@param l2 Númerico. Segundo Intervalo para determinar a extração de corpos hídricos.
#'@param l3 Númerico. Intervalos entre os limiares para determinar a extração de corpos hídricos.
#'
#'@examples
#'library(terra)
#'library(rgeoamb)
#'green <- terra::rast(system.file('ex/green.tif, package = 'terra'))
#'nir <- terra::rast(system.file('ex/nir.tif, package = 'terra'))
#'wm <- rgeoamb::mascara_dagua(green, nir, 5, 0.1, 0.10, 0.1)
#'plot(wm)
#'@export
mascara_dagua <- function(x, y, amm, l1, l2, l3){
  ndwi <- (x - y)/(x + y)
  ndwi_amm <- terra::focal(ndwi, amm, 'modal')
  ndwi_threshold <- terra::ifel(ndwi >= seq(l1, l2, by = l3), 1, 0)
  return(ndwi_threshold)
}
