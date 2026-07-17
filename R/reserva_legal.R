#' Reserva Legal
#'
#'\strong Cálcula se a área do imóvel condiz com o código florestal.
#'
#'@param x Entrada do arquivo vetorial da área do ímovel.
#'@param y Entrada do arquivo vetorial da reserva legal.
#'
#'@examples
#'library(sf)
#'library(rgeoamb)
#'area_imovel <- sf::read_sf(system.file('ex/area_imovel.shp, package = 'sf'))
#'rl <- sf::read_sf(system.file('ex/rl.tif, package = 'sf'))
#'rlp <- rgeoamb::reserva_legal(area_imovel, rl)
#'plot(rlp)
#'@export
reserva_legal <- function(x, y){
  ai <- sf::st_area(x)/10000
  rl <- round(sf::st_area(y)/10000, 3)
  ai_20_percent <- round(x * 0.2, 3)
  if(rl %>% as.numeric() >= ai_20_percent |> as.numeric()){
    cat('Reserva Legal > 20% -', 'Área da Reserva Legal Proposta:', y, 'ha',
        'e Percentual de 20% da Área do Imóvel',  ai_20_percent, 'ha')
  } else{
    cat('Reserva Legal < 20% -', 'Área da Reserva Legal Proposta', y, 'ha',
        'e Percentual de 20% da Área do Imóvel',  ai_20_percent, 'ha')
  }
  aidf <- as.numeric(ai_20_percent)|>
    as.data.frame()
  rldf <- as.numeric(y)|>
    as.data.frame()
  df <- cbind('id' = 1, aidf, rldf)
  colnames(df) <- c('id', 'area_imovel', 'reserva_legal')
  data <-  sf::st_as_sf(df, area_imovel$geometry)
  return(data)
}
