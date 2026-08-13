#'Drainage Basins (Bacias Hidrográficas)
#'
#'Identifies drainage basins in DEMs.
#'
#'@param x Input DEM raster file.
#'@param proj Performs geodesic reference frame transformations and projective transformations.
#'
#'@examples
#'library(terra)
#'library(rgeoamb)
#'dem <- terra::rast(system.file('ex/elev.tif', package = 'terra'))
#'db <- rgeoamb::drainage_basins(dem)
#'@export
drainage_basins <- function(x, proj){
  os <- Sys.info()["sysname"]
  if (os == "Windows") {
    saga <- Rsagacmd::saga_gis(saga_bin = "C:/Program Files/SAGA/saga_cmd.exe")
  } else if (os == "Linux") {
    saga <- Rsagacmd::saga_gis()
  } else {
    saga <- Rsagacmd::saga_gis() # Fallback para macOS/Darwin
  }
  basin_inverse <- saga$ta_compound$basic_terrain_analysis(elevation = x,
                                                           basins = tempfile(fileext = '.gpkg'))
  basins <- sf::st_transform(basin_inverse$basins)|>
    terra::vect()|>
    terra::project(proj)
  return(basins)
}
