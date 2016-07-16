#' Create a maze uzing a randomized Prim's algorithm.
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
#' maze1 <- makeMaze_prim(maze1)
#' plotMaze(maze1, 10, 10)
#'
#' @export

makeMaze_prim <- function(gD=NA, stepBystep = FALSE, nrows=0, ncols=0, inShiny = FALSE){

  if (!inShiny){
    if (!exists(deparse(substitute(gD))))
      stop("A maze/graph object with the specified name does not exist!")
  }

  # Create empty vector of edges
  edge_list <- c()

  # Select the start cell/node the current and mark it as visited
  # We will use cell 1-1 as a start cell. This can easily be changed to allow other cells to be start cells
  #current_cell_name = paste("A", as.character(start_cell_x), as.character(start_cell_y), sep="_")
  current_cell_name = "A_1_1"

  # Mark this cell/node as part of the maze
  igraph::V(gD)[which(igraph::V(gD)$name == current_cell_name )]$visited <- 2

  # Find all adjacent cells/nodes to start node
  v_adjacent <- igraph::neighbors(gD,  igraph::V(gD)[which(igraph::V(gD)$name == current_cell_name )], "all")

  # Add all edges with walls ON in the edge list
  for (i in 1:length(v_adjacent)){
    #if (igraph::E(gD)[current_cell_name %--% v_adjacent[i]$name]$wall == "ON")
      edge_list <- c(edge_list, paste(current_cell_name, v_adjacent[i]$name, sep=" %--% "))
  }

  while(length(edge_list) > 0){

    if (stepBystep){
      print(stepByStepMAze(gD, nrows, ncols))
    }

    # Randomly select a wall/edge from the list
    random_edge <- sample(1:length(edge_list), 1)

    # Check if there exist one unvisited cell on one of the two sides of the chosen wall
    get_nodes <- unlist(stringr::str_split(edge_list[random_edge], " %--% "))

    if ((igraph::V(gD)[which(igraph::V(gD)$name == get_nodes[1])]$visited == 0) ||
        (igraph::V(gD)[which(igraph::V(gD)$name == get_nodes[2])]$visited == 0)){

      # If such node exist
      # Remove the wall
      # igraph::E(gD)[edge_list[random_edge]]$wall <- "OFF"
      # We have to do it this way, because of the format issues
      igraph::E(gD)[get_nodes[1] %--% get_nodes[2]]$wall <- "OFF"

      # Add unvisited cell/node to the maze and the edges to the wall/edge list
      if (igraph::V(gD)[which(igraph::V(gD)$name == get_nodes[1])]$visited == 0){

        igraph::V(gD)[which(igraph::V(gD)$name == get_nodes[1])]$visited <- 2

        # Find all adjacent cells/nodes to start node
        v_adjacent <- igraph::neighbors(gD,  igraph::V(gD)[which(igraph::V(gD)$name == get_nodes[1])], "all")

        # Add all edges with walls ON in the edge list
        for (i in 1:length(v_adjacent)){
          #if (igraph::E(gD)[get_nodes[1] %--% v_adjacent[i]$name]$wall == "ON")
            edge_list <- c(edge_list, paste(get_nodes[1], v_adjacent[i]$name, sep=" %--% "))
        }
      }

      if (igraph::V(gD)[which(igraph::V(gD)$name == get_nodes[2] )]$visited == 0){
        igraph::V(gD)[which(igraph::V(gD)$name == get_nodes[2])]$visited <- 2

        # Find all adjacent cells/nodes to start node
        v_adjacent <- igraph::neighbors(gD,  igraph::V(gD)[which(igraph::V(gD)$name == get_nodes[2])], "all")

        # Add all edges with walls ON in the edge list
        for (i in 1:length(v_adjacent)){
          #if (igraph::E(gD)[get_nodes[2] %--% v_adjacent[i]$name]$wall == "ON")
            edge_list <- c(edge_list, paste(get_nodes[2], v_adjacent[i]$name, sep=" %--% "))
        }
      }
    }

    # Remove the edge from the list
    edge_list <- edge_list[-random_edge]
  }
  gD
}
