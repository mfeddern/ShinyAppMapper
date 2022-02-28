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
      
      radioButtons(inputId = "Management_Area", #radio button for whether there is ASL data
                   label= "Management Area:",
                   c("Yukon (US)" = "Yukon (US)",
                     "Yukon (CA)" = "Yukon (CA)",
                     "Kuskokwim" = "Kuskokwim",
                     "Norton Sound" = "Norton Sound",
                     "Kotzebue" = "Kotzebue",
                     "All Areas" = "All"),
                   selected="All"),
      
  radioButtons(inputId = "Project_Type", #radio button for whether there is ASL data
               label= "Survey Type:",
               c("Escapement Counts" = "Escapement Counts",
                 "Aerial Survey" = "Aerial Survey",
                 "All Data" = "All"),
               selected="All"),
 
 
   sliderInput("Number_of_Years", #slider for the minimum number of escapement observations
              "Minimum Number of Years of Survey Observations:",
              min = 0,
              max = 60,
              step=1,
              value = 1),
  
  sliderInput("Avg_Count", #radio button for the minimum escapement size
              "Minimum Average Return:",
              min = 0,
              max = 5000,
              step= 20,
              value = 20),
  
  sliderInput("Min_ASL", #radio button for the minimum escapement size
              "Minimum Number of Years for ASL Data:",
              min = 0,
              max = 60,
              step= 1,
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
