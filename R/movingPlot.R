#' Run2MovingMap
#' @description Visualize Run2MovingMap
#' @param data A run data frame returned by \code{import_run}.
#' @param ... Further Options passed into Leaflet's \code{addPolylines} function.
#' @return A ggplot object.
#' @examples
#' \dontrun{
#' data("stuggi_running")
#' head(run)
#' }
#' @section Note:
#' Creating this animated plot takes rather long.
#' @export
Run2MovingMap <- function(data = stuggi_running,...){
  
  gg <- 
    ggplot(data = data,
         aes(x = x,
             y = y)) + 
    geom_point()+
    #geom_line()+
    geom_point(aes(frame = runtime),size = 5,color = "red")
  
  gganimate::gganimate(gg,filename = "test.gif")
  
  return(gg)
}

# library(leaflet)
# run2map(color = "red")

