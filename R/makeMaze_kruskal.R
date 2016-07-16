#' Create a maze uzing a randomized Kruskal's algorithm.
#'
#' @param gD an existing maze graph object.
#' @param stepBystep a flag that will allow a step by step plot of maze creation
#' @param nrows maze hight (number of rows); required only for the step by step plot; default value set to 0.
#' @param ncols maze width (number of columns); required only for the step by step plot; default value set to 0.
#' @param inShiny a flag that marks whether the function is called from a shiny app or console
#'
#' @return Given a connected maze graph (with all walls on), this function creates a maze (removes some walls)
#'  using depth-first search algorithm (recursive backtracker), and returns the resulting maze graph.
#'
#' @examples
#' maze1 <- makeGraph(10, 10)
#' maze1 <- makeMaze_kruskal(maze1)
#' plotMaze(maze1, 10, 10)
#'
#' @export


makeMaze_kruskal <- function(gD=NA, stepBystep = FALSE, nrows=0, ncols=0, inShiny = FALSE){

  if (!inShiny){
    if (!exists(deparse(substitute(gD))))
      stop("A maze/graph object with the specified name does not exist!")
  }

  # Assign each cell/node to a set (we will use visited atribute to keep track of set id and node id as a set id)
  igraph::V(gD)$visited <- 1:igraph::vcount(gD)

  # Create a vector of all edges
  edge_list <- igraph::E(gD)

  while(length(edge_list) > 0){

    if (stepBystep){
      print(stepByStepMAze(gD, nrows, ncols))
    }

    # Randomly select a wall/edge from the list
    random_edge <- sample(1:length(edge_list), 1)

    # Check if cells/nodes divided by this wall belong to the same or different sets
    get_nodes <- unlist(stringr::str_split(igraph::as_ids(edge_list[random_edge]), "\\|"))

    if (igraph::V(gD)[which(igraph::V(gD)$name == get_nodes[1])]$visited != igraph::V(gD)[which(igraph::V(gD)$name == get_nodes[2])]$visited){
      # Merge these two sets together
      igraph::V(gD)[which(igraph::V(gD)$visited == igraph::V(gD)[which(igraph::V(gD)$name == get_nodes[2])]$visited)]$visited <- igraph::V(gD)[which(igraph::V(gD)$name == get_nodes[1] )]$visited

      #Remove the wall between the cells
      igraph::E(gD)[edge_list[random_edge]]$wall <- "OFF"
    }

    # Remove the edge from the list
    edge_list <- edge_list[-random_edge]
  }
  gD
}
