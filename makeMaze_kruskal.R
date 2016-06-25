# Make a maze uzing a randomized version of depth-first search algorithm

makeMaze_kruskal <- function(gD){
  
  if (!exists(deparse(substitute(gD))))
    stop("Name of the maze/graph not specified!")
  
  # Assign each cell/node to a set (we will use visited atribute to keep track of set id and node id as a set id)
  igraph::V(gD)$visited <- 1:igraph::vcount(gD)
  
  # Create a vector of all edges
  edge_list <- igraph::E(gD)
  
  while(length(edge_list) > 0){
    
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
