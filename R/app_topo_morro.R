#' APP Topo de Morro
#'
#'\strong APP Topo de Morro
#'
#'@param x Entrada do arquivo matricial MDE.
#'
#'@examples
#'library(terra)
#'library(rgeoamb)
#'dem <- terra::rast(system.file('ex/elev.tif, package = 'terra'))
#'app_tm <- rgeoamb::app_topo_morro(dem)
#'plot(app_tm)
#'@export
app_topo_morro <- function(x){
  dem_inverse <- x * -1
  basin_inverse <- Rsagacmd::saga$ta_compound$basic_terrain_analysis(elevation = dem_inverse, basins = 'DEM/basin.gpkg')
  slope <- terra::terrain(dem, 'slope', 8, 'degrees')
  zonal <- terra::vect('DEM/basin.gpkg')
  zonal_slope <- terra::zonal(slope, zonal, 'mean', as.polygons = F, na.rm = T)|>
    as.data.frame()
  zonal_max <- terra::zonal(dem, zonal, 'max', as.polygons = F, na.rm = T)|>
    as.data.frame()
  zonal_min <- terra::zonal(dem, zonal, 'min', as.polygons = F, na.rm = T)|>
    as.data.frame()
  zonal_range <- cbind(zonal_max, zonal_min)
  colnames(zonal_range) <- c('max', 'min')
  zonal_amplitude <- zonal_range|>
    dplyr::mutate(range = max - min)
  zonal_df <- cbind('id' =  seq(1, 219, by = 1)|> as.integer(), zonal_max|> round(2), zonal_min|> round(2),
                    zonal_amplitude$range|> round(2),  zonal_slope|> round(2))
  colnames(zonal_df) <- c('id', 'max', 'min', 'range', 'slope')
  geometry <- sf::st_as_sf(zonal)
  zonal_data <- geometry$geometry%>%
    sf::st_as_sf(zonal_df, geometry = .)
  app_topo <- subset(zonal_data, zonal_data$range >= 100 | zonal_data$slope >= 25)
  app_topo_morro <- app_topo|>
    dplyr::mutate(terco = max - (range/3))
  return(app_topo_morro)
}
