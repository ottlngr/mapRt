library(ggplot2)
library(dplyr)

mv_roads_df <- readRDS("./data/mv_roads_df.RDS")
mv_water_df <- readRDS("./data/mv_water_df.RDS")

rostock_roads_df <- mv_roads_df %>%
  filter(long >= 12.1010, long <= 12.1532, lat >= 54.0738, lat <= 54.1091) %>%
  filter(code <= 5160) %>%
  mutate(path_size = NA) %>%
  mutate(path_size = ifelse(code > 5110 & code < 5120, 1.0, path_size)) %>%
  mutate(path_size = ifelse(code > 5120 & code < 5130, 0.5, path_size)) %>%
  mutate(path_size = ifelse(code > 5130 & code < 5140, 0.4, path_size)) %>%
  mutate(path_size = ifelse(code > 5140 & code < 5150, 0.2, path_size)) %>%
  mutate(path_size = ifelse(code > 5150 & code < 5160, 0.1, path_size))

rostock_water_df <- mv_water_df %>%
  filter(long >= 12.1010, long <= 12.1532, lat >= 54.0738, lat <= 54.1091)


ggplot() + 
  geom_polygon(data = rostock_water_df, aes(x = long, y = lat, group = group), fill = "grey70") + 
  geom_path(data = rostock_roads_df, aes(x = long, y = lat, group = group, size = path_size)) + 
  coord_quickmap() +
  scale_size_identity() +
  theme_void()
  

