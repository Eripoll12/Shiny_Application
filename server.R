#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.


library(shiny)
library(ggplot2)

# Define server logic required to perform the tasks
shinyServer(function(input, output) {
      x <- reactive({seq(from = input$xrange[[1]],
                         to = input$xrange[[2]],
                         by = 0.01)})
      y <- reactive({dt(x(), input$dof)})
      norm <- reactive({dnorm(x())})
      
      df <- reactive({data.frame(x(),y(), norm())})
      
      output$tplot <- renderPlot({
            if (input$normal == 2) {
                  ggplot(df(), aes(x=x())) +
                  geom_line(aes(y = y(), colour = "t-Student"), size=1.3) +
                  scale_colour_manual(values = c('orange')) +
                  theme_light() +
                  labs(x="x", y="density")
            } else {
                  ggplot(df(), aes(x=x())) +
                  geom_line(aes(y = y(), colour = "t-Student"), size=1.2) +
                  geom_line(aes(y = norm(), colour = "Normal"), size=1.2) +
                  scale_colour_manual(values = c('steelblue', "orange")) +
                  theme_light() +
                  labs(x="x", y="density")
            }
      })
      
      output$CI <- renderText({
            res <- qt((input$CI+(1-input$CI)/2),input$dof-1)
            paste("1. t-Student distribution: [", -round(res,4), ",", round(res,4), "]")
      })
      
      output$CI_n <- renderText({
            if (input$normal == 1) {
            res <- qnorm((input$CI+(1-input$CI)/2))
            paste("2. Normal distribution: [", -round(res,4), ",", round(res,4), "]")
            }
      })
  
})
