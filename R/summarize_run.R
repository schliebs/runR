#' SummarizeRun
#' @description Get summary statistics for run
#' @param run a run data frame returned by \code{import_run}.
#' @return A list with summary statistics.
#' \describe{
#'   \item{total_duration}{Total duration as \code{Formal Duration class}}
#'   \item{total_duration_seconds}{Total duration in seconds}
#'   \item{total_duration_hours}{Total duration in hours}
#'   \item{average_speed_kph}{Average speed in kilometers per hour}
#'   \item{total_distance}{The total distance in kilometers}
#' }
#' @examples
#' data(stuggi_running)
#' summariseRun(run = stuggi_running)
#' @export
summariseRun <- function(run = stuggi_running){
  
  total_duration <- (run$time[nrow(run)]-run$time[1]) %>% lubridate::as.duration()
  total_duration_seconds <- total_duration %>% as.numeric
  total_duration_hours <- total_duration_seconds/3600
  
  average_speed_kph <- max(run$cumulative.distance)/total_duration_hours
  total_distance <- max(run$cumulative.distance)
  
  summarylist <- 
    list(total_duration = total_duration,
         total_duration_seconds = total_duration_seconds,
         total_duration_hours = total_duration_hours,
         average_speed_kph = average_speed_kph,
         total_distance = total_distance)
  
  return(summarylist)
}
