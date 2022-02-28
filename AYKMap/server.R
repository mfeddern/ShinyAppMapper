data1<- read.csv(file = 'ADFGDataSummary.csv')   #aerial survey and escapement dataset
data2<- read.csv(file = 'ADFG_ASL.csv')         # ASL data set
data <- left_join(data1, data2[,3:10], by = "Location", all= FALSE)%>% #merging dataset
          filter_at(vars(First_Year,Last_Year),all_vars(!is.na(.)))   # only keeping ASL data that has accompanying survey data

server = function(session, input, output) {
#Creating a reactive dataset that can be filtered by the slider and the radio buttons from the ui  
  filtered_data <- reactive({ 
  

   
   #assigning the correct filtering for management area 
   if(input$Management_Area == "Yukon (US)"){
     data <- data %>% filter(Management_Area == "Yukon")
   }else{
     if(input$Management_Area == "Yukon (CA)"){
       data<-  data %>% filter(Management_Area == "Yukon - Canada")
     }else{
       if(input$Management_Area == "Kuskokwim"){
         data<-  data %>% filter(Management_Area == "Kuskokwim")
       }else{
         if(input$Management_Area == "Kotzebue"){
           data<-  data %>% filter(Management_Area == "Kotzebue")
         }else{
           if(input$Management_Area == "Norton Sound"){
             data<-  data %>% filter(Management_Area == "Norton Sound/Port Clarence")
             }else{
               data
             }
           }
         }
       }
     }
   
    #assigning the correct filtering for survey type  
       if(input$Project_Type == "Escapement Counts"){
          data <- data %>% filter(Project_Type == "Escapement")
        }else{
          if(input$Project_Type == "Aerial Survey"){
           data<-  data %>% filter(Project_Type == "Aerial Survey")
          }else{
            data
          }
        }
})
  

  #creating the output data table that will be filtered by the slider and the buttons  
  output$my_datatable <- renderDT({
    
    filtered_data() %>% 
       datatable( rownames = FALSE,  class = "display", fillContainer = T, 
                  options = list( scrollX = TRUE, 
                                 paging = FALSE))
  })
  
  pal <- colorFactor(c("navy", "red"), domain = c("Escapement", "Aerial Survey"))  
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
      as.list(filtered_data()$Latitude[c(unique(input$my_datatable_rows_selected))])
    })
    
    selected_longs <- eventReactive(input$my_datatable_rows_selected, {
      as.list(filtered_data()$Longitude[c(unique(input$my_datatable_rows_selected))])
    })
    
    selected_location <- eventReactive(input$my_datatable_rows_selected, {
      as.list(filtered_data()$Location[c(unique(input$my_datatable_rows_selected))])
    })
    
    selected_management <- eventReactive(input$my_datatable_rows_selected, {
      as.list(filtered_data()$Management_Area[c(unique(input$my_datatable_rows_selected))])
    })
    
    selected_type <- eventReactive(input$my_datatable_rows_selected, {
      as.list(filtered_data()$Project_Type[c(unique(input$my_datatable_rows_selected))])
    })
    
    selected_avg <- eventReactive(input$my_datatable_rows_selected, {
      as.list(filtered_data()$Avg_Count[c(unique(input$my_datatable_rows_selected))])
    })
    
    selected_nyears <- eventReactive(input$my_datatable_rows_selected, {
      as.list(filtered_data()$Number_of_Years[c(unique(input$my_datatable_rows_selected))])
    })
    
    
    # this is the data that will be passed to the leaflet in the addCircleMarkers argument,
    # as well as the popups when the points are hovered over
    map_df <- reactive({
      tibble(lat = unlist(selected_lats()),
             lng = unlist(selected_longs()),
             location = unlist(selected_location()),
             management = unlist(selected_management()),
             nyears = unlist(selected_nyears()),
             average = unlist(selected_avg()),
             type = unlist(selected_type()))
    })
    leafletProxy("my_leaflet", session) %>% 
      clearMarkers() %>% 
      addCircleMarkers(
        data = map_df(),
        lng = ~lng,
        lat = ~lat,
        stroke = TRUE,
        color = ~pal(type),
        radius = 1,
        weight = ~nyears/2,
        fillOpacity = 0.4,
        popup = paste0("Name: ", map_df()$location, "<br>",
                       "Region: ", map_df()$management, "<br>",
                       "Data Type: ", map_df()$type, "<br>",
                       "Average Return: ", map_df()$average, "<br>",
                       "# Years of Escapement Data: ", map_df()$nyears)
                       
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
