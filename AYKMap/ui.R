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
               titlePanel("AYK Chinook Salmon Data"),
  sidebarLayout(
    sidebarPanel(  
      h1("Query Data"),
      br(),
      strong("Data Type:"),
      br(),
      
      checkboxInput(inputId = "Weir.check", label = "Weir", value = FALSE),
      checkboxInput(inputId = "Aerial.check", label = "Aerial", value = FALSE),
      checkboxInput(inputId = "Sonar.check", label = "Sonar", value = FALSE),
      checkboxInput(inputId = "Tower.check", label = "Counting Tower", value = FALSE),
      checkboxInput(inputId = "Genetic.check", label = "Genetic", value = FALSE),
      
  radioButtons(inputId = "ASL", #radio button for whether there is ASL data
               label= "Age Data:",
               c("Yes" = "Yes",
                 "No" = "No",
                 "All Data" = "All"),
               selected="All"),
  
  radioButtons(inputId = "Productivity", #radio button for whether there is productivity index
               label= "Productivity Data:",
               choices= c("Yes" = "Yes",
                 "No" = "No",
                 "All Data" = "All"),
               selected="All"),
  
 
 
   sliderInput("n_years", #radio button for the minimum number of escapement observations
              "Minimum Number of Years of Escapement Observations:",
              min = 0,
              max = 30,
              value = 0),
  actionButton(
    "select_all_rows_button",
    "View Selection on Map"
  ),
  
  actionButton(
    "clear_rows_button",
    "Clear Map Selection"
    
  )

  
    ),
  
  mainPanel(
    h2("Map of Data"),
        leafletOutput(
          "my_leaflet"
        ),
    
 
    h2("Data Inventory"),
        DTOutput(
          "my_datatable"
        )
      )
    )
  )
