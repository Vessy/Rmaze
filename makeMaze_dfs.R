# Make a maze uzing a randomized version of depth-first search algorithm
# (recursive backtracker)

makeMaze_dfs <- function(gD = NA){
  
  if (!exists(deparse(substitute(gD))))
    stop("Name of the maze/graph not specified!")
  
  # Create empty node stack vector
  nodes_stack <- c()
  is_finised <- FALSE
  
  # Select the start cell/node the current and mark it as visited
  # We will use cell 1-1 as a start cell. This can easily be changed to allow other cells to be start cells
  #current_cell_name = paste("A", as.character(start_cell_x), as.character(start_cell_y), sep="_")
  current_cell_name = "A_1_1"
  
  while(!is_finised){
    
    # print (current_cell_name)
    
    # Mark this cell/node as visited (but not finished)
    igraph::V(gD)[which(igraph::V(gD)$name == current_cell_name )]$visited <- 1
    
    # Find all adjacent cells/nodes to start node
    v_adjacent <- igraph::neighbors(gD,  igraph::V(gD)[which(igraph::V(gD)$name == current_cell_name )], "all")
    
    # Find all adjacent nodes that were not visited before
    index_adjacent_unvisited <- which(igraph::V(gD)[igraph::V(gD)[v_adjacent]]$visited == 0)
    
    # If such nodes exist
    if (length(index_adjacent_unvisited) > 0){
      # Randomly select one of the unvisited neighbors
      randomly_select <- index_adjacent_unvisited[sample(1:length(index_adjacent_unvisited), 1)]
      
      # Remove the wall between the current cell and the chosen cell
      igraph::E(gD)[current_cell_name %--% v_adjacent[randomly_select]$name]$wall <- "OFF"
      
      # Push the current cell/node to the stack
      nodes_stack <- c(current_cell_name, nodes_stack)
      
      # Make the adjacent node the current node
      current_cell_name <- v_adjacent[randomly_select]$name
      
    } else {
      # Mark the cell as finished
      igraph::V(gD)[which(igraph::V(gD)$name == current_cell_name )]$visited <- 2
      
      # If stack is not empty, get an element
      if (length(nodes_stack) > 0){
        current_cell_name <- nodes_stack[1]
        
        nodes_stack <- nodes_stack[-1]
        
        
      } else {
        
        # If stack is empty, check if there are any other univisited cells/nodes
        choose_from <- igraph::V(gD)[which(igraph::V(gD)$visited == 0)]$name
        
        # If yes, select one node randomly
        if (length(choose_from) > 0){
          current_cell_name <- choose_from[sample(1:length(choose_from), 1)]
        } else {
          # If not, we are done
          is_finised <- TRUE
        }
        
      }
      
    }
  }
  gD
}
