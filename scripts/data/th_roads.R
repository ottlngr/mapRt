library(rgdal)
library(ggplot2)
library(rgeos)
library(dplyr)

path <- shp_paths$thueringen
layer <- "gis_osm_roads_free_1"

th_roads_shp <- readOGR(dsn = path, layer = layer, stringsAsFactors = FALSE)
saveRDS(th_roads_shp, "./data/th_roads_shp.RDS")

th_roads_shp@data$id <- rownames(th_roads_shp@data)
th_roads_points <- fortify(th_roads_shp, region = "id")
th_roads_df <- merge(th_roads_points, th_roads_shp@data, by="id")
saveRDS(th_roads_df, "/data/th_roads_df.RDS")