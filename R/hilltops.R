#'Hilltops (APPs Topo de Morros)
#'
#'Identifies Permanent Preservation Areas (APPs) in hilltops.
#'
#'@param x Input DEM raster file.
#'@param proj Performs geodesic reference frame transformations and projective transformations.
#'
#'@examples
#'library(terra)
#'library(rgeoamb)
#'dem <- terra::rast(system.file('ex/elev.tif', package = 'terra'))
#'htps <- rgeoamb::hilltops(dem)
#'plot(htps)
#'@export
hilltops <- function(x, proj){
  dem_inverse <- x * -1
  saga <- Rsagacmd::saga_gis()
  basin_inverse <- saga$ta_compound$basic_terrain_analysis(elevation = dem_inverse,
                                                           basins = tempfile(fileext = '.gpkg'))
  basins <- sf::st_transform(basin_inverse$basins)|>
    terra::vect()
  slope <- x|>
    terra::project(proj)|>
    terra::terrain('slope', 8, 'degrees')
  zonal <- basins|>
    terra::project(proj)
  zonal_slope <- terra::zonal(slope, zonal, 'mean', as.polygons = F, na.rm = T)|>
    as.data.frame()
  zonal_max <- terra::zonal(x, zonal, 'max', as.polygons = F, na.rm = T)|>
    as.data.frame()
  zonal_min <- terra::zonal(x, zonal, 'min', as.polygons = F, na.rm = T)|>
    as.data.frame()
  zonal_range <- cbind(zonal_max, zonal_min)
  colnames(zonal_range) <- c('max', 'min')
  zonal_amplitude <- zonal_range|>
    dplyr::mutate(range = max - min)
  zonal_df <- cbind('id' = seq(1, nrow(zonal_slope), by = 1)|> as.integer(),
                    zonal_max|> round(2),
                    zonal_min|> round(2),
                    zonal_amplitude$range|> round(2),
                    zonal_slope|> round(2))
  colnames(zonal_df) <- c('id', 'max', 'min', 'range', 'slope')
  geometry <- sf::st_as_sf(zonal)
  zonal_data <- geometry$geometry%>%
    sf::st_as_sf(zonal_df, geometry = .)
  hill <- subset(zonal_data, zonal_data$range >= 100 | zonal_data$slope >= 25)
  hilltops <- hill|>
    dplyr::mutate(third = max - (range/3))
  hill_rast <- terra::rasterize(terra::vect(hilltops), x, field = "third")
  app <- terra::ifel(x > hill_rast, 1, NA)
  return(app)
}
