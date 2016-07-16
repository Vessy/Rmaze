server <- shinyServer(function(input, output) {

  maze <- eventReactive(input$gmButton, {

    width <- input$width
    height <- input$hight
    method <- input$method

    g <- makeGraph(width, height)

    myMaze <- switch(method,
                     "rbt" = makeMaze_dfs(g, inShiny=TRUE),
                     "ka" = makeMaze_kruskal(g, inShiny=TRUE),
                     "pa" = makeMaze_prim(g, inShiny=TRUE))

  })

  output$plotMaze <- renderPlot({
    width <- isolate(input$width)
    height <- isolate(input$hight)
    plotMaze(maze(), width, height, inShiny=TRUE)

  })

})

