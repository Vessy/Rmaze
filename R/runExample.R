#' A function to start a Shiny app that comes with the package.
#' Code from: http://www.r-bloggers.com/supplementing-your-r-package-with-a-shiny-app-2/
#'
#' @examples
#' Rmaze::runExample()
#'
#' @export

runExample <- function() {
  appDir <- system.file("shiny-examples", "myapp", package = "mazeR")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mazeR`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
