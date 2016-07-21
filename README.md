# Rmaze

## Installation

To install the Rmaze package, run the following command:

```
devtools::install_github("Vessy/Rmaze")
library("Rmaze")
```

## Description

Rmaze is a package that provides options to generate and plot mazes in R. 

Currently, the package provides options to create a maze using the recursive backtracker, Kruskal's, and Prim's algorithms. These algorithms create "perfect" mazes, i.e., mazes without loops and without inaccessible areas. Such mazes have exactly one solution (there is exactly one path from each maze cell to another maze cell).

All mazes are represented in a form of connected graphs, where the edges represent possible wall sites and the nodes represent maze cells. All graph manipulations are based on the functions provided in the [igraph](https://cran.r-project.org/web/packages/igraph/index.html) package.

![A maze generated using a recursive backtracker algorithm (randomized version of depth-first search algorithm)](http://www.vesnam.com/Rblog/wp-content/uploads/2016/07/maze_ex1.jpeg)

The package also provides options to plot step-by-step maze generating process and the maze solution.

<div style="width:400px; height=400px">
![A step-by-step illustration of maze creation using using a recursive backtracker algorithm. White cells are unvisited maze cells, red cells are the maze cells on stack, and the blue cells are the maze cells that have been visited and removed from the stack)](http://www.vesnam.com/Rblog/wp-content/uploads/2016/07/dfs_sbs_ex2.jpeg)
</div>

The maze solution is defined as the shortest path between the start and end maze cells:

<div style="width:400px; height=400px">
![A maze solution](http://www.vesnam.com/Rblog/wp-content/uploads/2016/07/maze_ex1_sol.jpeg)
</div>

Finally, the package provides an option to create imperfect mazes. These mazes are created by randomly adding or removing specified percentages of maze walls from the perfect mazes. In the process of randomization, the algorithm ensures that the added and removed walls do not interfere with the existence of the maze solution. The imperfect mazes contain loops, inaccessible areas, and may have more than one solution.

<div style="width:400px; height=400px">
![An imperfect maze created by randomly adding or removing 20% of walls ](http://www.vesnam.com/Rblog/wp-content/uploads/2016/07/maze_ex1_imp.jpeg)
</div>

<div style="width:400px; height=400px">
![A solution for the imperfect maze](http://www.vesnam.com/Rblog/wp-content/uploads/2016/07/maze_ex1_imp_sol.jpeg)
</div>

## Shiny

To run a Shiny app showcasing the basic Rmaze features, run the following command:

```  
Rmaze::runExample()
``` 

<div style="width:400px; height=400px">
![Shiny app showcasing the basic Rmaze features](http://www.vesnam.com/Rblog/wp-content/uploads/2016/07/shiny_ex1.jpg)
</div>    

## Questions or help
To report a bug, problem, or question, please open an issue.

## Additional resources

To learn more about mazes, see:

[http://www.jamisbuck.org/presentations/rubyconf2011/index.html](http://www.jamisbuck.org/presentations/rubyconf2011/index.html)

[http://weblog.jamisbuck.org/2011/2/7/maze-generation-algorithm-recap](http://weblog.jamisbuck.org/2011/2/7/maze-generation-algorithm-recap)

[http://www.astrolog.org/labyrnth/algrithm.htm](http://www.astrolog.org/labyrnth/algrithm.htm)

[https://en.wikipedia.org/wiki/Maze_generation_algorithm](https://en.wikipedia.org/wiki/Maze_generation_algorithm)
