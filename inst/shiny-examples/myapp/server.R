server <- shinyServer(function(input, output) {

 eventReactive(input$gmButton, {

    maze <- makeGraph(input$width, input$hight)

    switch (input$method,
             "rbt" = { maze <- makeMaze_dfs(maze, inShiny=TRUE)},
             "ka" = { maze <- makeMaze_kruskal(maze, inShiny=TRUE)},
             "pa" = { maze <- makeMaze_prim(maze, inShiny=TRUE)}
     )

     output$plotMaze <- renderPlot({
       plotMaze(maze, input$width, input$hight, inShiny=TRUE)
     })
   })
})

