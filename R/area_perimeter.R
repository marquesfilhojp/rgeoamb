#'Area and Perimeter
#'
#'Calculates the area in square meters, square kilometers, and hectares, as well as the perimeter.
#'
#'@param aoi Area of interest. Must be an `sf` object.
#'
#'@examples
# 'library(sf)
# 'library(rgeoamb)
#' aoi <- sf::read_sf(system.file('ex/aoi.shp', package = 'sf'))|>
#'        subset(ex == 'area of interest')
#' ap <- rgeoamb::area_perimeter(aoi)
#' print(ap)
#' @export
area_perimeter <- function(aoi){
  m2 <- sf::st_transform(aoi, crs = 'EPSG:31983')%>%
    sf::st_area()
  area_m2 <- as.data.frame(m2)
  ha <- sf::st_transform(aoi, crs = 'EPSG:31983')%>%
    sf::st_area()/10000
  area_ha <- as.data.frame(ha)
  km2 <- sf::st_transform(aoi, crs = 'EPSG:31983')%>%
    sf::st_area()/1000000
  perimeter <- sf::st_perimeter(aoi)
  perimeter <- as.data.frame(perimeter)
  area_km2 <- as.data.frame(km2)
  ap <- cbind(area_m2 %>% round(2), area_ha %>% round(2),
              area_km2 %>% round(2), perimeter %>% round(2))
  colnames(ap) <- c('area_m2', 'area_ha', 'area_km2', 'perimeter')
  y <- aoi$geometry %>%
    sf::st_as_sf(ap, geometry = .)
  return(y)
}
