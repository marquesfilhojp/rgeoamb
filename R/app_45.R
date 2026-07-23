#' APP > 45°
#'
#'\strong{APP > 45°}
#'
#'@param x Entrada do arquivo matricial MDE.
#'
#'@examples
#'\dontrun{
#'library(terra)
#'library(rgeoamb)
#'dem <- terra::rast(system.file('ex/elev.tif', package = 'terra'))
#'app <- rgeoamb::app_45(dem)
#'plot(app)
#'}
#'@export
app_45 <- function(x){
  declividade <- terra::terrain(x, 'slope', neighbors = 8, unit = 'degrees')
  app <- terra::ifel(declividade >= 45, 1,0)
  return(app)
}
