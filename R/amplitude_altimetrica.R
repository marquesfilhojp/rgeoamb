#' Amplitude Altimétrica
#'
#' \strong Cálcula a Amplitude Altimétrica.
#'
#' @param x Entrada do arquivo matricial do MDE.
#' @param escala Númerico. Efetua a escala espacial.
#'
#' @examples
#' library(terra)
#' library(rgeoamb)
#' dem <- terra::rast(system.file('ex/elev.tif, package = 'terra'))
#' amplitude <- rgeoamb::amplitude_altimetrica(x)
#' plot(amplitude)
#' @export
amplitude_alimetrica <- function(x){
  min <- terra::focal(x, escala, 'min')
  aa <- x - min
  return(aa)
}
