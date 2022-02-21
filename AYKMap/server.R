data <- read.csv(file = 'DataInventory.csv')


server = function(session, input, output) {
#Creating a reactive dataset that can be filtered by the slider and the radio buttons from the ui  
  filtered_data <- reactive({ 
      data %>%
        filter(yrs_data >= input$n_years)

    #assigning the correct filtering for age data  
       if(input$ASL == "Yes"){
          data <- data %>% filter(asl == "Yes")
        }else{
          if(input$ASL == "No"){
           data<-  data %>% filter(asl == "No")
          }else{
            data
          }
        }
  

    #assinging correct data filtering for the productivity      
     if(input$Productivity == "Yes"){
       data <- data %>% filter(productivity == "Yes")
      }else{
        if(input$Productivity == "No"){
          data <- data %>% filter(Productivity == "No")
        }else{
          data
        }
      }
    
    
    ## If statements to properly select data type using check boxes
    if(input$Aerial.check == TRUE & input$Weir.check == TRUE & input$Sonar.check == TRUE& input$Genetic.check == TRUE & input$Tower.check == TRUE){
      data %>% filter(Aerial == "Yes" & Weir == "Yes"& Sonar == "Yes"& Genetic == "Yes"& Tower == "Yes")
    }else{
    if(input$Aerial.check == TRUE & input$Weir.check == TRUE & input$Sonar.check == TRUE& input$Genetic.check == TRUE & input$Tower.check == FALSE){
      data %>% filter(Aerial == "Yes" & Weir == "Yes"& Sonar == "Yes"& Genetic == "Yes")
    }else{
      if(input$Aerial.check == TRUE & input$Weir.check == TRUE & input$Sonar.check == TRUE & input$Genetic.check == FALSE& input$Tower.check == FALSE){
        data %>% filter(Aerial == "Yes" & Weir == "Yes"& Sonar == "Yes")
      }else{
        if(input$Aerial.check == TRUE & input$Weir.check == TRUE & input$Genetic.check == TRUE & input$Sonar.check == FALSE& input$Tower.check == FALSE){
          data %>% filter(Aerial == "Yes" & Weir == "Yes"& Genetic == "Yes")
        }else{
          if(input$Aerial.check == TRUE & input$Sonar.check == TRUE & input$Genetic.check == TRUE& input$Weir.check == FALSE& input$Tower.check == FALSE){
            data %>% filter(Aerial == "Yes" & Sonar == "Yes"& Genetic == "Yes")
          }else{
            if(input$Weir.check == FALSE & input$Aerial.check == FALSE& input$Genetic.check == TRUE& input$Sonar.check == FALSE& input$Tower.check == FALSE){
              data %>% filter(Genetic == "Yes")
            }else{     
              if(input$Weir.check == FALSE & input$Aerial.check == FALSE& input$Genetic.check == FALSE& input$Sonar.check == TRUE& input$Tower.check == FALSE){
                data %>% filter(Sonar == "Yes")
              }else{ 
                if(input$Weir.check == TRUE & input$Aerial.check == FALSE& input$Genetic.check == TRUE& input$Sonar.check == FALSE& input$Tower.check == FALSE){
                  data %>% filter(Weir == "Yes"&Genetic=="Yes")
                }else{  
                  if(input$Weir.check == TRUE & input$Aerial.check == FALSE& input$Genetic.check == FALSE& input$Sonar.check == TRUE& input$Tower.check == FALSE){
                    data %>% filter(Weir == "Yes"&Sonar=="Yes")
                  }else{
                    if(input$Weir.check == FALSE & input$Aerial.check == TRUE& input$Genetic.check == FALSE& input$Sonar.check == TRUE& input$Tower.check == FALSE){
                      data %>% filter(Aerial == "Yes"&Sonar=="Yes")
                    }else{
                      if(input$Weir.check == FALSE & input$Aerial.check == TRUE& input$Genetic.check == TRUE& input$Sonar.check == FALSE& input$Tower.check == FALSE){
                        data %>% filter(Aerial == "Yes"&Genetic=="Yes")
                      }else{
                        if(input$Weir.check == FALSE & input$Aerial.check == FALSE& input$Genetic.check == TRUE& input$Sonar.check == TRUE& input$Tower.check == FALSE){
                          data %>% filter(Sonar == "Yes"&Genetic=="Yes")
                        }else{
            
     if(input$Aerial.check == TRUE & input$Weir.check == TRUE& input$Genetic.check == FALSE& input$Sonar.check == FALSE& input$Tower.check == FALSE){
        data %>% filter(Aerial == "Yes" & Weir == "Yes")
        }else{
          if(input$Aerial.check == TRUE & input$Weir.check == FALSE& input$Genetic.check == FALSE& input$Sonar.check == FALSE& input$Tower.check == FALSE){
          data %>% filter(Aerial == "Yes")
       }else{
         if(input$Weir.check == TRUE & input$Aerial.check == FALSE& input$Genetic.check == FALSE& input$Sonar.check == FALSE& input$Tower.check == FALSE){
        data %>% filter(Weir == "Yes")
      }else{
        #here we are adding all of the tower true optuions
        if(input$Aerial.check == FALSE & input$Weir.check == TRUE & input$Sonar.check == TRUE& input$Genetic.check == TRUE & input$Tower.check == TRUE){
          data %>% filter( Weir == "Yes"& Sonar == "Yes"& Genetic == "Yes"& Tower == "Yes")
        }else{ 
          if(input$Aerial.check == TRUE & input$Weir.check == FALSE & input$Sonar.check == TRUE& input$Genetic.check == TRUE & input$Tower.check == TRUE){
          data %>% filter(Aerial == "Yes"& Sonar == "Yes"& Genetic == "Yes"& Tower == "Yes")
        }else{
          if(input$Aerial.check == TRUE & input$Weir.check == TRUE & input$Sonar.check == FALSE& input$Genetic.check == TRUE & input$Tower.check == TRUE){
            data %>% filter(Aerial == "Yes" & Weir == "Yes"& Genetic == "Yes"& Tower == "Yes")
          }else{
            if(input$Aerial.check == TRUE & input$Weir.check == TRUE & input$Sonar.check == TRUE& input$Genetic.check == FALSE & input$Tower.check == TRUE){
              data %>% filter(Aerial == "Yes" & Weir == "Yes"& Sonar == "Yes"& Tower == "Yes")
            }else{
              
              if(input$Aerial.check == FALSE & input$Weir.check == FALSE & input$Sonar.check == TRUE& input$Genetic.check == TRUE & input$Tower.check == TRUE){
                data %>% filter( Sonar == "Yes"& Genetic == "Yes"& Tower == "Yes")
              }else{
                if(input$Aerial.check == FALSE & input$Weir.check == TRUE & input$Sonar.check == FALSE& input$Genetic.check == TRUE & input$Tower.check == TRUE){
                  data %>% filter(Weir == "Yes"& Genetic == "Yes"& Tower == "Yes")
                }else{
                  if(input$Aerial.check == FALSE & input$Weir.check == TRUE & input$Sonar.check == TRUE& input$Genetic.check == FALSE & input$Tower.check == TRUE){
                    data %>% filter(Weir == "Yes"& Sonar == "Yes"& Tower == "Yes")
                  }else{
                    if(input$Aerial.check == TRUE & input$Weir.check == FALSE & input$Sonar.check == FALSE& input$Genetic.check == TRUE & input$Tower.check == TRUE){
                      data %>% filter(Aerial == "Yes" & Genetic == "Yes"& Tower == "Yes")
                    }else{
                      if(input$Aerial.check == TRUE & input$Weir.check == FALSE & input$Sonar.check == TRUE& input$Genetic.check == FALSE & input$Tower.check == TRUE){
                        data %>% filter(Aerial == "Yes" & Sonar == "Yes"&  Tower == "Yes")
                      }else{
                        if(input$Aerial.check == TRUE & input$Weir.check == TRUE & input$Sonar.check == FALSE& input$Genetic.check == FALSE & input$Tower.check == TRUE){
                          data %>% filter(Aerial == "Yes" & Weir == "Yes"& Tower == "Yes")
                        }else{
                          
                          if(input$Aerial.check == FALSE & input$Weir.check == FALSE & input$Sonar.check == FALSE& input$Genetic.check == TRUE & input$Tower.check == TRUE){
                            data %>% filter( Genetic == "Yes"& Tower == "Yes")
                          }else{
                            if(input$Aerial.check == FALSE & input$Weir.check == TRUE & input$Sonar.check == FALSE& input$Genetic.check == FALSE & input$Tower.check == TRUE){
                              data %>% filter(Weir == "Yes"&  Tower == "Yes")
                            }else{
                              if(input$Aerial.check == FALSE & input$Weir.check == FALSE & input$Sonar.check == TRUE& input$Genetic.check == FALSE & input$Tower.check == TRUE){
                                data %>% filter( Sonar == "Yes"&  Tower == "Yes")
                              }else{
                                if(input$Aerial.check == TRUE & input$Weir.check == FALSE & input$Sonar.check == FALSE& input$Genetic.check == FALSE & input$Tower.check == TRUE){
                                  data %>% filter(Aerial == "Yes" & Tower == "Yes")
                                }else{
                                  if(input$Aerial.check == FALSE & input$Weir.check == FALSE & input$Sonar.check == FALSE& input$Genetic.check == FALSE & input$Tower.check == TRUE){
                                    data %>% filter( Tower == "Yes")
                                  }else{
        
          data 
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
        }
      
                     }
                  }
                }
              }
            }
          }
        }
      }
              }
            }
          }
        }
      }
    }
    }
  })

  #creating the output data table that will be filtered by the slider and the buttons  
  output$my_datatable <- renderDT({
  
    names<- c("Region", "River", "Name", "Productivity Index", "Age Data",
              "Years Escapement",  "Data Type",
              "Longitude", "Latitiude", "Location Notes", "First Brood", "Last Brood", "References",
              "Harvest", "Weir", "Aerial", "Genetic", "Sonar", "Years of Age")
    
    filtered_data() %>% 
       datatable( rownames = FALSE,  class = "display", fillContainer = T, 
                  options = list( scrollX = TRUE, 
                                 paging = FALSE))
    
   
                
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
    
    selected_datatype <- eventReactive(input$my_datatable_rows_selected, {
      as.list(filtered_data()$Data.Type[c(unique(input$my_datatable_rows_selected))])
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
             datatype = unlist(selected_datatype()),
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
        fillColor = 'blue',
        stroke = TRUE,
        color = "white",
        radius = 6,
        weight = 1,
        fillOpacity = 0.4,
        popup = paste0("Name: ", map_df()$productivity_index, "<br>",
                       "Region: ", map_df()$region, "<br>",
                       "Data Type: ", map_df()$datatype, "<br>",
                       "Productivity Data: ", map_df()$productivity, "<br>",
                       "Age Data: ", map_df()$asl, "<br>",
                       "# Years of Escapement Data: ", map_df()$yrs_data)
                       
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
