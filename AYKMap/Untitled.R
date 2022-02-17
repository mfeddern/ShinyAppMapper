data <- read.csv(file = 'DataInventory.csv')


ui<-fluidPage(
  theme = shinytheme("flatly"),
  #Application Title
  titlePanel("AYK Chinook Salmon Datasets"),
  
  #Adding a side panel to filter through the data
  sidebarLayout(
    sidebarPanel(
      
      radioButtons(inputId = "Productivity", 
                   label= "Productivity:",
                   choices=unique(data$productivity)),
      
      radioButtons(inputId = "ASL", 
                   label= "Age Data:",
                   choices=unique(data$asl)),
      sliderInput("n_years",
                  "Minimum Years of Data:",
                  min = 1,
                  max = 50,
                  value = 1)
    ),
    
    
    #What to include in the main panel (here it is the map)
    mainPanel("Data Inventory",leafletOutput("AYK"),
              dataTableOutput("table")
              
    )
    
  )
)



server <- function(input, output, session) {
  
  
  #creating a reactive object that filters base on the selecetion of ASL data 
  #creating a reactive object that filters base on the selecetion of ASL data 
  asl_data <- reactive({
    data %>%
      filter(asl == input$ASL)%>%
      filter(productivity == input$Productivity)%>%
      filter(yrs_data >= input$n_years)
  })
  
  output$table<- DT::renderDataTable(
    asl_data(), selection = 'single'
  )
  
  
  # map
  output$AYK <- renderLeaflet({
    qMap <-leaflet(data = asl_data()) %>%
      setView(lng = -160.5594136, lat = 62.8883491, zoom = 4)%>%
      addTiles() %>%
      addMarkers(popup=~as.character(asl_data()$productivity_index), 
                 layerId = as.character(asl_data()$productivity_index))
    qMap
  })
  
  
  
  # to keep track of previously selected row
  prev_row <- reactiveVal() 
  # new icon style
  highlight_icon = makeAwesomeIcon(icon = 'flag', markerColor = 'red', iconColor = 'white') #creating the icon that will pop up
  observeEvent(eventExpr = input$table_rows_selected, {
    row_selected = asl_data()[input$table_rows_selected,] #the input is a row selected from the filtered table
    proxy <- leafletProxy('AYK', data=asl_data()) #proxy is the map
    print(row_selected)
    proxy %>% #adds a highlighted icon where the row selected is
      addAwesomeMarkers(popup=as.character(row_selected$productivity_index),
                        layerId = as.character(row_selected$productivity_index),
                        lng=row_selected$long, 
                        lat=row_selected$lat,
                        icon = highlight_icon)
    
    # if the row is not longer selected then the prev row object is replaced with the original color
    if(!is.null(prev_row()))
    {
      proxy %>%
        addMarkers(popup=as.character(prev_row()$productivity_index), 
                   layerId = as.character(prev_row()$productivity_index),
                   lng=prev_row()$long, 
                   lat=prev_row()$lat)
    }
    
    
    # set new value to reactiveVal, which makes the next selected row the new prvious row
    prev_row(row_selected)
  })
  
  
  
  
  
}
