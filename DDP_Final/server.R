#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(plotly)
library(shiny)
library(ISLR)
shinyServer(function(input, output) {
    model <- lm(Income ~ Balance*Rating + Student, data = Credit)
    sumCoef = summary(model)$coefficients
    #sliderBal
    #sliderRat
    #isStudent - checkbox
    modelpred <- reactive({
        BalInput <- input$sliderBal
        RatInput <- input$sliderRat
        if(input$isStudent)
        predict(model, newdata = data.frame(Balance = BalInput, Rating = RatInput , Student = "Yes"))
        else 
            predict(model, newdata = data.frame(Balance = BalInput, Rating = RatInput, Student = "No"))
    })
    
    output$plot1 <- renderPlotly({
        BalInput <- input$sliderBal
        RatInput <- input$sliderRat
        
        plot_ly(Credit, x = ~Rating, y = ~model$residuals, type = "scatter", 
                    mode = "markers",
                    color = ~factor(Student), size = ~Balance,
                    text = ~paste("Income: ", Income, "<br>Balance: ", Credit$Balance))

    })
    
    output$pred1 <- renderText({
        modelpred()
    })
    output$pred2 <- renderText({
        paste("Intercept: ", round(sumCoef[1,1], 5))
    })
    output$pred3 <- renderText({
        paste("Rating Coef: ", round(sumCoef[2,1], 5))
    })
    output$pred4 <- renderText({
        paste("Balance Coef: ", round(sumCoef[3,1], 5))
    })
    output$pred5 <- renderText({
        paste("StudentYes Coef: ", round(sumCoef[4,1], 5))
    })
    output$pred6 <- renderText({
        paste("Rating:Balance Coef: ", round(sumCoef[5,1],5))
    })
    output$documentation <- renderUI({
        str1 <- "Data Source: Credit Card Balance Data (accessed using R Package ISLR)"
        str2 <- ""
        str3 <- "Input 1: Select balance value"
        str4 <- "Input 2: Select rating value"
        str5 <- "Input 3: Select student status"
        str6 <- ""
        str7 <- "Output: Predicted Income level of the person based on unput values"
        str8 <- ""
        str9 <- "ui.R code: https://github.com/yigitozanberk/Developing_Data_Products/blob/master/DDP_Final/ui.R"
        str10 <- ""
        str11 <- "server.R code: https://github.com/yigitozanberk/Developing_Data_Products/blob/master/DDP_Final/server.R"
        str12 <- ""
        HTML(paste(str1, str2, str3, str4, str5, str6, str7, str8, str9, str10, str11, 
                   str12, sep = '<br/>'))
    })

})