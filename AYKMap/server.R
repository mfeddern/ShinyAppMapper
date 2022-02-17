data <- read.csv(file = 'DataInventory.csv')


server = function(session, input, output) {
#Creating a reactive dataset that can be filtered by the slider and the radio buttons from the ui  
  filtered_data <- reactive({ 
      data<- data %>%
      filter(asl == input$ASL)%>%
      filter(productivity == input$Productivity)%>%
      filter(yrs_data >= input$n_years)
      
      if(input$Aerial.check == TRUE & input$Weir.check == TRUE){
        data %>% filter(Aerial == "Yes" & Weir == "Yes")
        }else{
          if(input$Aerial.check == TRUE){
          data %>% filter(Aerial == "Yes")
       }else{
         if(input$Weir.check == TRUE){
        data %>% filter(Weir == "Yes")
      }else{
        data
      }
       }
        }

    
  })

  #creating the output data table that will be filtered by the slider and the buttons  
  output$my_datatable <- renderDT({
    
    filtered_data() %>% 
      datatable()
    
  })
  
  
  # base map that we will add points to with leafletProxy(), using a proxy means the map does not need to be redrawn
  output$my_leaflet <- renderLeaflet({
    
    leaflet() %>% 
      addProviderTiles(
        provider = providers$CartoDB.Positron,
        options = providerTileOptions(
          noWrap = FALSE
        )
      ) %>% 
      setView(
        lat = 62.8883491, #the map can zoom, but this is the default area it is centered on
        lng = -160.5594136,
        zoom = 4
      )
    
  })
  
  #this initiates and event that allows selected rows in the data table to pop up on the map, using the "clear all" 
  #and 'select all" action button initiated in the ui
  
  observeEvent(input$my_datatable_rows_selected, {
    
    selected_lats <- eventReactive(input$my_datatable_rows_selected, {
      as.list(filtered_data()$lat[c(unique(input$my_datatable_rows_selected))])
    })
    
    selected_longs <- eventReactive(input$my_datatable_rows_selected, {
      as.list(filtered_data()$long[c(unique(input$my_datatable_rows_selected))])
    })
    
    selected_productivity <- eventReactive(input$my_datatable_rows_selected, {
      as.list(filtered_data()$productivity[c(unique(input$my_datatable_rows_selected))])
    })
    
    selected_asl <- eventReactive(input$my_datatable_rows_selected, {
      as.list(filtered_data()$asl[c(unique(input$my_datatable_rows_selected))])
    })
    
    selected_region <- eventReactive(input$my_datatable_rows_selected, {
      as.list(filtered_data()$region[c(unique(input$my_datatable_rows_selected))])
    })
    
    selected_yrs_data <- eventReactive(input$my_datatable_rows_selected, {
      as.list(filtered_data()$yrs_data[c(unique(input$my_datatable_rows_selected))])
    })
    
    selected_productivity_index <- eventReactive(input$my_datatable_rows_selected, {
      as.list(filtered_data()$productivity_index[c(unique(input$my_datatable_rows_selected))])
    })
    
    # this is the data that will be passed to the leaflet in the addCircleMarkers argument,
    # as well as the popups when the points are hovered over
    map_df <- reactive({
      tibble(lat = unlist(selected_lats()),
             lng = unlist(selected_longs()),
             asl = unlist(selected_asl()),
             yrs_data = unlist(selected_yrs_data()),
             region = unlist(selected_region()),
             productivity = unlist(selected_productivity()),
             productivity_index = unlist(selected_productivity_index()))
    })
    
    leafletProxy("my_leaflet", session) %>% 
      clearMarkers() %>% 
      addCircleMarkers(
        data = map_df(),
        lng = ~lng,
        lat = ~lat,
        fillColor = "blue",
        stroke = TRUE,
        color = "white",
        radius = 6,
        weight = 1,
        fillOpacity = 0.4,
        popup = paste0("Name: ", map_df()$productivity_index, "<br>",
                       "Productivity Data: ", map_df()$productivity, "<br>",
                       "Age Data: ", map_df()$asl, "<br>",
                       "# Years of Escapement Data: ", map_df()$yrs_data, "<br>",
                       "Region: ", map_df()$region)
      )
    
  })
  
  # create a proxy to modify datatable without recreating it completely
  DT_proxy <- dataTableProxy("my_datatable")
  
  # clear row selections when clear_rows_button is clicked
  observeEvent(input$clear_rows_button, {
    selectRows(DT_proxy, NULL)
  })
  
  # clear markers from leaflet when clear_rows_button is clicked
  observeEvent(input$clear_rows_button, {
    clearMarkers(leafletProxy("my_leaflet", session))
  })
  
  # select all rows when select_all_rows_button is clicked
  observeEvent(input$select_all_rows_button, {
    selectRows(DT_proxy, input$my_datatable_rows_all)
  })
  
}
