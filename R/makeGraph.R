#' Create a connected maze graph that represents a rectangular grid.
#' Nodes represent cells and edges betweem nodes represent wall sites.
#' All walls are initially on.
#'
#' @param nrows maze height (number of rows); default value set to 0.
#' @param ncols maze width (number of columns); default value set to 0.
#'
#' @return This function creates and returns a maze graph that represents a rectangular grid
#'  that matches user specified maze dimensions. Nodes in the graph will be named in the
#'  format Aij, where i corresponds to a row number  and j corresponds to a column number.
#'
#' @examples
#' maze1 <- makeGraph(10, 10)
#' maze1 <- makeMaze_dfs(maze1)
#' plotMaze(maze1, 10, 10)
#'
#' @export

makeGraph <- function(nrows=0, ncols=0){

  if (nrows <= 0)
    stop("Number of rows (height) has to be larger than zero!")

  if (ncols <= 0)
    stop("Number of columns (width) has to be larger than zero!")

  # Create list of edges
  df_hlp = data.frame(node1=c(), node2=c())

  for (i in 1:nrows)
    for (j in 1:ncols){

      if (i < nrows)
        df_hlp <- rbind(df_hlp,
                        data.frame(node1 = paste("A", as.character(i), as.character(j), sep="_"),
                                   node2 = paste("A", as.character(i+1), as.character(j), sep="_")))

      if (j < ncols)
        df_hlp <- rbind(df_hlp,
                        data.frame(node1 = paste("A", as.character(i), as.character(j), sep="_"),
                                   node2 = paste("A", as.character(i), as.character(j+1), sep="_")))
    }

  # Create undirected graph from the edge list (data frame)
  gD <- igraph::simplify(igraph::graph.data.frame(df_hlp, directed=FALSE))

  # Set edge attribute (wall - meaning a wall between cells)
  gD <- igraph::set_edge_attr(gD , "wall", value = "ON")

  # Set node attributes (visited - a flag that will be used in traversing the graph)
  gD <- igraph::set_vertex_attr(gD , "visited", value = 0)


  # Return the graph
  gD
}
