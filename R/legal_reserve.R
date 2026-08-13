#'Legal Reserve (Reserva Legal)
#'
#'Checks if the property area complies with the Brazilian Forest Code.
#'
#' @param x Input vector object for the property area.
#' @param y Input vector object for the legal reserve.
#'
#'@examples
#'library(sf)
#'library(rgeoamb)
#'area_imovel <- sf::read_sf(system.file('ex/area_imovel.shp', package = 'sf'))
#'lr <- sf::read_sf(system.file('ex/lr.tif', package = 'sf'))
#'plr <- rgeoamb::legal_reserve(property_area, lr)
#'plot(plr)
#'@export
legal_reserve <- function(x, y){
  ai <- sf::st_area(x)/10000
  lr <- round(sf::st_area(y)/10000, 3)
  ai_20_percent <- round(x * 0.2, 3)
  if (y >= ai_20_percent) {
    cat('Legal Reserve >= 20% -', 'Proposed Legal Reserve Area:', y, 'ha',
        'and 20% Threshold of Property Area:', ai_20_percent, 'ha\n')
  } else {
    cat('Legal Reserve < 20% -', 'Proposed Legal Reserve Area:', y, 'ha',
        'and 20% Threshold of Property Area:', ai_20_percent, 'ha\n')
  }
  aidf <- as.numeric(ai_20_percent)|>
    as.data.frame()
  lrdf <- as.numeric(y)|>
    as.data.frame()
  df <- cbind('id' = 1, aidf, lrdf)
  colnames(df) <- c('id', 'property_area', 'legal_reserve')
  data <-  sf::st_as_sf(df, property_area$geometry)
  return(data)
}
