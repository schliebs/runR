# install.packages("rdwd")
# https://cran.r-project.org/web/packages/rdwd/vignettes/rdwd.html

library(rdwd)

# select a dataset (e.g. last year's daily climate data from Potsdam City):
link <- selectDWD("Potsdam", res="daily", var="kl", per="recent")

# Actually download that dataset, returning the local storage file name:
file <- dataDWD(link, read=FALSE)

# Read the file from the zip folder:
clim <- readDWD(file)

# Inspect the data.frame:
str(clim)

# Get close stations
x <- 
  nearbyStations(lat = 47.65, 
               lon = 9.47, 
               radius = 20, 
               res = NA, 
               var = NA, 
               per = NA,
               mindate = NA, 
               hasfileonly = TRUE,
               statname = "nearbyStations target location", 
               quiet = FALSE)
names(x)

y = x %>% 
  arrange(dist,desc(bis_datum)) %>% 
  filter(per == "recent",
         var == "air_temperature") %>% 
  head(1)

findID("Potsdam")
findID("Friedrichshafen")


file <- dataDWD(y$url,read=FALSE, dir=tempdir(), quiet=TRUE)
clim <- readDWD(file)

# Inspect the data.frame:
str(clim)
