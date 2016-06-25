# rm(list = ls())

maze1 <- makeGraph(10, 10)
maze1 <- makeMaze_dfs(maze1)
plotMaze(maze1, 10, 10)

maze2 <- makeGraph(10, 10)
maze2 <- makeMaze_prim(maze2) 
plotMaze(maze2, 10, 10)

maze3 <- makeGraph(10, 10)
maze3 <- makeMaze_kruskal(maze3) 
plotMaze(maze3, 10, 10)
