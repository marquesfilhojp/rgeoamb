#'Water Mask (Máscara d'água)
#'
#'Detects and extracts water bodies (masks) from spatial raster data.
#'
#'@param green Input raster object for the green band input.
#'@param nir Input raster object for the near-infrared (NIR) band input.
#'@param amm Numeric. Minimum Mappable Area constraint.
#'@param t1 Numeric. First threshold value to extract water bodies.
#'@param t2 Numeric. Second threshold value to extract water bodies.
#'@param t3 Numeric. Step interval between thresholds to extract water bodies.
#'
#'@examples
#'library(terra)
#'library(rgeoamb)
#'green <- terra::rast(system.file('ex/green.tif', package = 'terra'))
#'nir <- terra::rast(system.file('ex/nir.tif', package = 'terra'))
#'wm <- rgeoamb::water_mask(green, nir, 5, 0.1, 0.10, 0.1)
#'plot(wm)
#'@export
water_mask <- function(green, nir, amm, t1, t2, t3){
  ndwi <- (green - nir)/(green + nir)
  ndwi_amm <- terra::focal(ndwi, amm, 'modal')
  ndwi_threshold <- terra::ifel(ndwi >= seq(t1, t2, by = t3), 1, 0)
  return(ndwi_threshold)
}
