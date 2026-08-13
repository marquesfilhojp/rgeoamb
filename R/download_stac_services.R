#'Download STAC Image Collections from Planetary Computer
#'
#'Query, filter, sign, and download satellite assets from Microsoft's
#'Planetary Computer STAC API using a spatial area of interest.
#'
#'@param collections Character. Name of the STAC collection(s) (e.g., `"sentinel-2-l2a"` or `"landsat-c2-l2"`).
#'@param date_time Character. ISO 8601 formatted date or date-time range (e.g., `"2023-01-01/2023-12-31"`).
#'@param aoi An `sf` object representing the spatial area of interest.
#'@param cloud_cover Numeric. Maximum allowed cloud cover percentage (0 to 100).
#'@param bands Character vector. Names of the asset/band names to select (e.g., `c("B04", "B08")`).
#'@param output_dir Character. Directory path where raster files will be saved.
#'@examples
#'\dontrun{
#'library(pacman)
#'p_load(sf, rgeoamb)
#'aoi <- sf::read_sf('ex/aoi.shp')
#'data <- rgeoamb::download_stac_services('landsat-c2-l2', '2021-01-01/2021-12-31', aoi, 10, c('nir08', 'red'), 'ex/image')
#'print(data)
#'}
#'@export
download_stac_services <- function(collections, date_time, aoi, cloud_cover, bands, output_dir){
  s_obj <- rstac::stac("https://planetarycomputer.microsoft.com/api/stac/v1/")
  y <- aoi|>
    sf::st_transform('EPSG:4326')|>
    sf::st_bbox()
  xmin <- as.numeric(y[1])
  ymin <- as.numeric(y[2])
  xmax <- as.numeric(y[3])
  ymax <- as.numeric(y[4])
  it_obj <- s_obj |>
    rstac::stac_search(collections = collections,
                datetime = date_time,
                bbox = c(xmin, ymin, xmax, ymax),
                limit = 100)|>
    rstac::post_request()|>
    rstac::items_filter(properties[["eo:cloud_cover"]] < !!cloud_cover)|>
    rstac::items_sign(sign_fn = rstac::sign_planetary_computer())|>
    rstac::assets_select(asset_names = bands)
  print(rstac::items_length(it_obj))
  print(rstac::items_assets(it_obj))
  files <- rstac::assets_download(items = it_obj,
                                  output_dir = output_dir,
                                  overwrite = T)
  return(files)
}
