library(utils)
library(stats)
library(utils)
library(datasets)
library(graphics)
library(shiny)
library(grDevices)
library(methods)
library(leaflet)
library(dplyr)
library(shinycssloaders)
library(rgdal)
library(plotly)
library(htmltools)
library(DT)
library(shinyjs)
library(shinythemes)
library(rsconnect)


ui = fluidPage(theme = shinytheme("flatly"),
  sidebarLayout(
    sidebarPanel(  
      br(),
      strong("Data Type:"),
      br(),
      
      checkboxInput(inputId = "Weir.check", label = "Weir", value = TRUE),
      
      
      checkboxInput(inputId = "Aerial.check", label = "Aerial", value = TRUE),
      
  radioButtons(inputId = "ASL", #radio button for whether there is ASL data
               label= "Age Data:",
               c("Yes" = "Yes",
                 "No" = "No")),
  
  radioButtons(inputId = "Productivity", #radio button for whether there is productivity index
               label= "Productivity Data:",
               choices=unique(data$productivity)),
  
 
 
   sliderInput("n_years", #radio button for the minimum number of escapement observations
              "Minimum Years of Escapement Data:",
              min = 1,
              max = 30,
              value = 1),
  actionButton(
    "select_all_rows_button",
    "Select All Table Rows"
  ),
  
  actionButton(
    "clear_rows_button",
    "Clear Table Selections"
    
  )

  
    ),
  
  mainPanel(
        leafletOutput(
          "my_leaflet"
        ),
   
        DTOutput(
          "my_datatable"
        )
      )
    )
  )
