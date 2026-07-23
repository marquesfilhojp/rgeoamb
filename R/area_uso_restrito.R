#' Área de Uso Restrito
#'
#'\strong{Área de Uso Restrito}
#'
#'@param x Entrada do arquivo matricial MDE.
#'
#'@examples
#'\dontrun{
#'library(terra)
#'library(rgeoamb)
#'dem <- terra::rast(system.file('ex/elev.tif', package = 'terra'))
#'uso_restrito <- rgeoamb::area_uso_restrito(dem)
#'plot(uso_restrito)
#'}
#'@export
area_uso_restrito <- function(x){
  declividade <- terra::terrain(x, 'slope', neighbors = 8, unit = 'degrees')
  area <- terra::ifel(declividade >= 25 & declividade <= 45, 1, 0)
  return(area)
}
