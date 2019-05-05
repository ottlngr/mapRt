library(ggplot2)
library(dplyr)

mv_roads_df <- readRDS("./data/mv_roads_df.RDS")

mv_roads_df %>%
  filter(long >= 12.1025, long <= 12.1532, lat >= 54.0738, lat <= 54.1091) %>%
  filter(code <= 5160) %>%
  mutate(code_class = NA) %>%
  mutate(code_class = ifelse(code > 5110 & code < 5120, "major", code_class)) %>%
  mutate(code_class = ifelse(code > 5120 & code < 5130, "minor", code_class)) %>%
  mutate(code_class = ifelse(code > 5130 & code < 5140, "links", code_class)) %>%
  mutate(code_class = ifelse(code > 5140 & code < 5150, "very small", code_class)) %>%
  mutate(code_class = ifelse(code > 5150 & code < 5160, "tiny", code_class)) %>%
  mutate(size = NA) %>%
  mutate(size = ifelse(code_class == "major", 1, size)) %>%
  mutate(size = ifelse(code_class == "minor", 0.5, size)) %>%
  mutate(size = ifelse(code_class == "links", 0.4, size)) %>%
  mutate(size = ifelse(code_class == "very small", 0.2, size)) %>%
  mutate(size = ifelse(code_class == "tiny", 0.1, size)) %>%
  ggplot() + 
  aes(x = long, y = lat, group = group, size = size) + 
  geom_path() +
  coord_quickmap() +
  scale_size_identity() +
  theme_void()
