# Plot maze from the graph

plotMaze <- function(gD, nrows=0, ncols=0){
  
  if (!exists(deparse(substitute(gD))))
    stop("Name of the maze/graph not specified!")
  
  if (nrows <= 0)
    stop("Number of rows (hight) has to be larger than zero!")
  
  if (ncols <= 0)
    stop("Number of columns (width) has to be larger than zero!")
  
  # Add coordinates for the outside box
  # Figure how to incoorporate start and end cells
  # including checking if it is outside cell
  df <- data.frame(x1 = c(0, 1, 0, ncols), y1 = c(0, 0, nrows, 0), x2 = c(0, ncols, ncols-1, ncols), y2 = c(nrows,0, nrows, nrows))
  
  for (r in 1:nrows)
    for (c in 1:ncols){
      
      if (r < nrows)
        if (igraph::E(gD)[paste("A", as.character(r), as.character(c), sep="_") %--% paste("A", as.character(r+1), as.character(c), sep="_")]$wall == "ON")
          df <- rbind(df, data.frame(x1 = (c-1), y1 = r, x2 = c, y2 = r))
        
        
        if (c < ncols)
          if (igraph::E(gD)[paste("A", as.character(r), as.character(c), sep="_") %--% paste("A", as.character(r), as.character(c+1), sep="_")]$wall == "ON")
            df <- rbind(df, data.frame(x1 = c, y1 = (r-1), x2 = c, y2 = r))
    }
  
  m <- ggplot2::ggplot(data = df)
  m <- m + ggplot2::geom_segment(ggplot2::aes(x = x1, y = y1, xend = x2, yend = y2), data = df)
  m <- m + ggplot2::theme_bw()
  m + ggplot2::theme(axis.title=ggplot2::element_blank(), axis.text=ggplot2::element_blank(), axis.ticks=ggplot2::element_blank(),
                     panel.grid=ggplot2::element_blank() )
  

}
