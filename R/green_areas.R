#'Green Areas
#'
#'Detects and extracts green areas from spatial raster data.
#'
#'@param nir Input raster object for the near-infrared (NIR) band input.
#'@param red Input raster object for the red band input.
#'@param amm Numeric. Minimum Mappable Area constraint.
#'@param t1 Numeric. First threshold value to extract green areas.
#'@param t2 Numeric. Second threshold value to extract green areas.
#'@param t3 Numeric. Step interval between thresholds to extract green areas.
#'
#'@examples
#'library(terra)
#'library(rgeoamb)
#'nir <- terra::rast(system.file('ex/nir.tif', package = 'terra'))
#'red <- terra::rast(system.file('ex/red.tif', package = 'terra'))
#'ga <- rgeoamb::green_areas(nir, red, 5, 0.33, 0.40, 0.01)
#'plot(ga)
#'@export
green_areas <- function(nir, red, mma, l1, l2, l3){
  ndvi <- (nir - red)/(nir + red)
  ndvi_mma <- terra::focal(ndvi, mma, 'modal')
  ndvi_threshold <- terra::ifel(ndwi_amm >= seq(t1, t2, by = t3), 1, 0)
  return(ndvi_threshold)
}
