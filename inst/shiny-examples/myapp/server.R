server <- shinyServer(function(input, output) {

  maze <- reactive({
    input$gmButton

    width <- isolate(input$width)
    height <- isolate(input$hight)
    method <- isolate(input$method)

    g <- isolate(makeGraph(width, height))

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

