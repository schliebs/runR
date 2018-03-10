#' Run2Map
#' @description Visualize Run2Map
#' @param data A run data frame returned by \code{import_run}.
#' @param ... Further Options passed into Leaflet's \code{addPolylines} function.
#' @return A ggplot object.
#' @examples
#' data(data = cc_skiing)
#' 
#' run2map(data = cc_skiing)
#' 
#' run2map(data = cc_skiing,
#'         color = "red",
#'         smoothFactor = 1)
#' 
#' # Add circle at starting point
#' run2map(data = cc_skiing) + 
#' addCircles(lng = cc_skiing$x[1],
#'            lat = cc_skiing$y[1],
#'            popup = "START")
#' @section Note:
#' You may customize this plot by either specifying more options within the function or adding other leaflet layers afterwards.
#' @export
run2map <- function(data = cc_skiing,...){
  
  track <- data %>% select(x,y)
  
  l <- 
    leaflet() %>% 
    addTiles() %>% 
    addPolylines(data = track,
                 lng = track$x,
                 lat = track$y,
                 ...);l
  
  return(l)
}

# library(leaflet)
# run2map(color = "red")

