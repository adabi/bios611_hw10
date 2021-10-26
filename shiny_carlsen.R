library(tidyverse)
library(rchess)
library(shiny)

games_df <- read.csv('./source_data/carlsen_games_sample.csv')

games_lst <- 
  games_df %>% 
  pull(game_id) %>% 
  unique() 


ui <- fluidPage(
  titlePanel("Magnus Carlsen Game Visualizer"),
  
  chessboardjsOutput('board', width=400),
  
  hr(),
  
  fluidRow(
    column(3,
           selectInput(inputId = "gameID",
                       label = "Choose a Game ID",
                       games_lst)
           ),
    column(3,
           actionButton('btn_fws', 'Next Move'),
           actionButton('btn_bck', 'Previous Move'))
  )
  
  )

server <- function(input,output,session){
  current_move <- 1
  v <- reactiveValues(data = games_df,
                      current_id = NULL,
                      current_move = NULL,
                      plot = NULL)
  
  observeEvent(input$gameID, {
    v$current_move <- 1
    gameid <- input$gameID
    v$current_id <- gameid
    game_fen <- v$data %>%
      filter(game_id == gameid) %>% 
      filter(move_no == 1) %>% 
      pull(fen)
    v$plot <-chessboardjs(game_fen)
      
  })
  
  observeEvent(input$btn_fws, {
    max_move <-
      v$data %>% 
      filter(game_id == v$current_id) %>% 
      pull(move_no) %>% 
      max()
    
    if (v$current_move < max_move){
      v$current_move <- v$current_move + 1
      game_fen <- v$data %>%
        filter(game_id == v$current_id) %>% 
        filter(move_no == v$current_move) %>% 
        pull(fen)
      v$plot <-chessboardjs(game_fen)
      
    }
  })
  
  observeEvent(input$btn_bck, {
    
    if (v$current_move > 1){
      v$current_move <- v$current_move - 1
      game_fen <- v$data %>%
        filter(game_id == v$current_id) %>% 
        filter(move_no == v$current_move) %>% 
        pull(fen)
      v$plot <-chessboardjs(game_fen)
      
    }
    
  })
  
  output$board <-
      renderChessboardjs({
        v$plot
      })
  
}

shinyApp(ui = ui, server=server, 
         options = list(port=8080, host="0.0.0.0"))