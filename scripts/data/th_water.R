library(rgdal)
library(ggplot2)
library(rgeos)
library(dplyr)

path <- shp_paths$thueringen
layer <- "gis_osm_water_a_free_1"

th_water_shp <- readOGR(dsn = path, layer = layer, stringsAsFactors = FALSE)
saveRDS(th_water_shp, "./data/th_water_shp.RDS")

th_water_shp@data$id <- rownames(th_water_shp@data)
th_water_points <- fortify(th_water_shp, region = "id")
th_water_df <- merge(th_water_points, th_water_shp@data, by="id")
saveRDS(th_water_df, "./data/th_water_df.RDS")
