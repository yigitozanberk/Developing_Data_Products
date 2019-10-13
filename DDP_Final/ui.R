#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(plotly)
library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict Income from Rating, Balance, and Student Status"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderBal", "What is the Balance of the person?", 0, 1999, value = 1000),
            sliderInput("sliderRat", "What is the Rating of the person?", 100, 980, value = 600),
            checkboxInput("isStudent", "is the person a student?", value = FALSE),
            submitButton("Submit") # New!
        ),
        mainPanel(
            tabsetPanel(type = "tabs", 
                        tabPanel("Plot", 
                            plotlyOutput("plot1"),
                            h3("Predicted Income(In $10.000):"),
                            textOutput("pred1"),
                            h3("Model Coefficients:"),
                            textOutput("pred2"),
                            textOutput("pred3"),
                            textOutput("pred4"),
                            textOutput("pred5"),
                            textOutput("pred6")
                        ),
                        tabPanel("Documentation",
                                 htmlOutput("documentation"))
                        
            )
        )
    )
))