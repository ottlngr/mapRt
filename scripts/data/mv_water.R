library(rgdal)
library(ggplot2)
library(rgeos)
library(dplyr)

path <- shp_paths$mecklenburg_vorpommern
layer <- "gis_osm_water_a_free_1"

mv_water_shp <- readOGR(dsn = path, layer = layer, stringsAsFactors = FALSE)
saveRDS(mv_roads_shp, "./data/mv_water_shp.RDS")

mv_water_shp@data$id <- rownames(mv_water_shp@data)
mv_water_points <- fortify(mv_water_shp, region = "id")
mv_water_df <- merge(mv_water_points, mv_water_shp@data, by="id")
saveRDS(mv_water_df, "./data/mv_water_df.RDS")
