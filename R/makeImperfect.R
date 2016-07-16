#' Given a perfect maze graph, create an imperfect maze graph.
#'
#' @param gD an existing maze graph object.
#' @param ptc percentage of walls to randomly add or remove; default value is 10(percent).
#' @param inShiny a flag that marks whether the function is called from a shiny app or console.
#'
#' @return A maze graph object containing an imperfect maze.
#'
#' @examples
#' maze1 <- makeGraph(10, 10)
#' maze1 <- makeMaze_dfs(maze1)
#' plotMaze(maze1, 10, 10)
#' maze1 <- makeImperfect(maze1)
#' plotMaze(maze1, 10, 10)
#'
#' @export

makeImperfect <- function(gD = NA, ptc = 20, inShiny = FALSE){

  if (!inShiny){
    if (!exists(deparse(substitute(gD))))
      stop("A maze/graph object with the specified name does not exist!")
  }

  # Find the shortest path between the start and end maze cells
  # (currently, those cells are A_1_1 and A_nrows_ncols)

  # First, we need to create a subgraph that contains only edges
  # with no walls (i.e., cells where a path between two cells exist)
  gD_hlp <- igraph::subgraph.edges(gD, igraph::E(gD)[igraph::E(gD)$wall == "OFF"], delete.vertices = FALSE)

  # Now, we will find the shortest path between the start end end maze cells
  # Basically, this is the maze solution
  sp_start_end <- igraph::shortest_paths(gD_hlp, igraph::V(gD_hlp)[1], igraph::V(gD_hlp)[igraph::vcount(gD_hlp)], mode="all", output="epath")

  # Next, we will calculate number of walls that will be flipped
  to_flip <- round(igraph::ecount(gD)*ptc/100)


  # And now we will flip the required number of walls
  while(to_flip > 0){

    # Get a random edge
    rand_edge <- sample(igraph::ecount(gD), 1)

    # Check if that edge is in the shortest path list of edges
    if (!(igraph::as_ids(igraph::E(gD)[rand_edge]) %in% igraph::as_ids(sp_start_end$epath[[1]]))){

      #If not, flip it
      if (igraph::E(gD)[rand_edge]$wall == "ON"){
        igraph::E(gD)[rand_edge]$wall = "OFF"
      } else {
        igraph::E(gD)[rand_edge ]$wall = "ON"
      }

      to_flip <- to_flip - 1

    }
  }

  gD
}
