# Import Single Run file

#' Import Run 
#' @description Import Run (Standard: GPX) to Data Frame
#' @param file path and file name.
#' @param type Type of log-file: currently, only gpx is supported.
#' @param track_progress T/F if data loading progress tracking is wished for
#' @return A data frame containing basic information about your run. 
#' \describe{
#'   \item{pointID}{ID for each track point}
#'   \item{ele}{elevation above sealevel in meters}
#'   \item{time}{time (in POSIXct-format)}
#'   \item{distance}{distance since the last trackpoint}
#'   \item{cumulative.distance}{cumulative distance since the beginnning}
#'   \item{x}{x-coordinate (longitude (East-West-Dimension))}
#'   \item{y}{y-coordinate (longitude (North-South-Dimension))}
#' }
#' @examples
#' \dontrun{
#' run <- import_run(file = 'data/2017-11-06.gpx',type = 'gpx')
#' head(run)
#' }
#' @section Remark:
#' So far, only the gpx-format from Sportstracker is implemented. 
#' @export
import_run <- function(file = 'data/2017-11-06.gpx',
                       type = 'gpx',
                       track_progress = TRUE){
  
  # So far, layer == "track_points" is implemented
  layer = 'track_points'
  #ogrListLayers(file)

  # Import OGR-layer file
  wp <- rgdal::readOGR(file, layer = layer,verbose = track_progress)
  wp$distance <- c(0,sp::spDists(wp, segments=TRUE))
  wp$cumulative.distance <- cumsum(wp$distance)
  wp$time <- lubridate::ymd_hms(wp$time)   
  
  # Data Management
  wp %<>%  
    as.data.frame() %>% 
    select(pointID = track_seg_point_id,
           ele,
           time,
           distance,
           cumulative.distance,
           x = coords.x1,
           y = coords.x2)
  
  return(wp)
}

#import_run()


## Import log file folder

#' Import log-file folder 
#' @description Import a folder of log files to a list. 
#' @param folderpath path of the folder containing the files.
#' @param type Type of log-files: currently, only gpx is supported.
#' @param track_progress T/F if data loading progress tracking is wished for
#' @return A list containing a data frame for each logfile. Each such data frame contains: 
#' \describe{
#'   \item{pointID}{ID for each track point}
#'   \item{ele}{elevation above sealevel in meters}
#'   \item{time}{time (in POSIXct-format)}
#'   \item{distance}{distance since the last trackpoint}
#'   \item{cumulative.distance}{cumulative distance since the beginnning}
#'   \item{x}{x-coordinate (longitude (East-West-Dimension))}
#'   \item{y}{y-coordinate (longitude (North-South-Dimension))}
#' }
#' @examples
#' \dontrun{
#' runlist <- import_logfolder(folderpath = 'data',type = 'gpx')
#' head(test[[1]])
#' }
#' @section Remark:
#' So far, only the gpx-format from Sportstracker is implemented. 
#' @export
import_logfolder <- function(folderpath = "data",
                             type = "gpx",
                             track_progress = TRUE){
  
  filevector <- 
    dir(folderpath)[stringr::str_detect(dir(folderpath),".gpx")] %>% 
    paste0(folderpath,"/",.)
    
  
  loglist <- 
    purrr::map(.x = filevector,
               .f = function(x) import_run(file = x,
                                           type = type,
                                           track_progress))
  
  return(loglist)
}


