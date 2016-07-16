ui <- shinyUI(fluidPage(

   # Application title
   titlePanel("Building mazes in R"),

   fluidRow(
     column(4,

      wellPanel(
         h4("Define maze:"),
         sliderInput("width", "Maze width", 5, 100, 10, step = 1),
         sliderInput("hight", "Maze hight", 5, 100, 10, step = 1),

         selectInput("method", "Select maze generation method",
                     c("Recursive backtracker" = "rbt",
                       "Kruskal's algorithm" = "ka",
                       "Prim's algorithm" = "pa")),

         checkboxInput(inputId = "imperfect",
                       label = strong("Create imperfect maze"),
                       value = FALSE),

         actionButton("gmButton", "Generate maze")
       )),

   column(8,
    mainPanel(
      wellPanel(
        h4("Maze:"),
          plotOutput("plotMaze")
      ))))
 )
)
