## Load required packages
library(terra)
library(Kendall)
library(ggplot2)
library(maps)

## Read the NetCDF file and extract the temperature variable
r <- rast("cru_ts4.09.1901.2024.tmx.dat.nc", subds = "tmx")

## Calculate annual maximum temperature (Block Maxima)
time_vec <- time(r)
years <- format(time_vec, "%Y")
yearly_max <- tapp(r, years, fun = max, na.rm = TRUE)

## Perform Mann-Kendall trend test for each grid cell
mk_test <- function(x) {
  if (all(is.na(x))) return(NA)
  test <- MannKendall(x)
  return(ifelse(test$sl < 0.05 & test$tau > 0, 1, 0))  # Return 1 if there is a significant upward trend
}

trend_map <- app(yearly_max, fun = mk_test)

## Visualize the map, highlight grids with significant upward trend in red
df <- as.data.frame(trend_map, xy = TRUE, na.rm = TRUE)
colnames(df)[3] <- "trend"
world <- map_data("world")

cities <- data.frame(
  name = c("Paris", "Detroit"),
  x = c(2.3514, -83.0458),
  y = c(48.8575, 42.3314)
)

ggplot() +
  geom_raster(data = df, aes(x = x, y = y, fill = factor(trend))) +
  scale_fill_manual(values = c("0" = "white", "1" = "skyblue"),
                    labels = c("No Trend", "Significant Upward Trend"),
                    name = "Trend") +
  geom_polygon(data = world, aes(x = long, y = lat, group = group),
               fill = NA, color = "black", size = 0.2) +
  geom_point(data = cities, aes(x = x, y = y), shape = 8, size = 3, color = "red") +
  geom_text(data = cities, aes(x = c(-9.3514, -87.0458), 
                               y = c(48.8575, 41.3314), label = name),
            vjust = 1, size = 5, color = "red") +
  coord_quickmap() +
  labs(title = "Grids with Significant Upward Temperature Trend (Mann-Kendall, p < 0.05)",
       x = "Longitude", y = "Latitude") +
  theme_minimal()
