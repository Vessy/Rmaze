server <- shinyServer(function(input, output) {

  maze <- eventReactive(input$gmButton, {

    width <- input$width
    height <- input$height
    method <- input$method

    g <- makeGraph(width, height)

    myMaze <- switch(method,
                     "rbt" = makeMaze_dfs(g, inShiny=TRUE),
                     "ka" = makeMaze_kruskal(g, inShiny=TRUE),
                     "pa" = makeMaze_prim(g, inShiny=TRUE))

    if (input$imperfect) {
      myMaze <- makeImperfect(myMaze, inShiny=TRUE)
    }

    myMaze

  })

  output$plotMaze <- renderPlot({
    width <- isolate(input$width)
    height <- isolate(input$height)
    plotMaze(maze(), width, height, inShiny=TRUE)

  })

})

