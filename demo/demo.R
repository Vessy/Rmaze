# rm(list = ls())

maze1 <- makeGraph(10, 10)
maze1 <- makeMaze_dfs(maze1)
plotMaze(maze1, 10, 10)
plotMazeSolution(maze1, 10, 10)

maze1 <- makeImperfect(maze1)
plotMaze(maze1, 10, 10)
plotMazeSolution(maze1, 10, 10)

maze2 <- makeGraph(10, 10)
maze2 <- makeMaze_prim(maze2)
plotMaze(maze2, 10, 10)

maze3 <- makeGraph(10, 10)
maze3 <- makeMaze_kruskal(maze3)
plotMaze(maze3, 10, 10)

maze4 <- makeGraph(5, 5)
maze4 <- makeMaze_dfs(maze4, stepBystep = TRUE, nrows=5, ncols=5)
plotMaze(maze4, 10, 10)

maze5 <- makeGraph(5, 5)
maze5 <- makeMaze_prim(maze5, stepBystep = TRUE, nrows=5, ncols=5)
plotMaze(maze5, 10, 10)

maze6 <- makeGraph(10, 10)
maze6 <- makeMaze_kruskal(maze6, stepBystep = TRUE, nrows=10, ncols=10)
plotMaze(maze6, 10, 10)

