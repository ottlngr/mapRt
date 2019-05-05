library(rgdal)
library(ggplot2)
library(rgeos)
library(dplyr)

path <- shp_paths$mecklenburg_vorpommern
layer <- "gis_osm_roads_free_1"

mv_roads_shp <- readOGR(dsn = path, layer = layer, stringsAsFactors = FALSE)
saveRDS(mv_roads_shp, "mv_roads_shp.RDS")

mv_roads_shp@data$id <- rownames(mv_roads_shp@data)
mv_roads_points <- fortify(mv_roads_shp, region = "id")
mv_roads_df <- merge(mv_roads_points, mv_roads_shp@data, by="id")
saveRDS(mv_roads_df, "mv_roads_df.RDS")