
library(shiny)

# Define UI for application that plot a t-Student distribution
# and gives you the associated values of "x" for the required 
# confidence interval

shinyUI(fluidPage(
  
  # Application title
  titlePanel("t-Student distribution visualizer"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       h3('Inputs'),
       sliderInput("xrange",
                   label = "Minimum and Maximum X Values",
                   min = -8,
                   max = 8,
                   value = c(-4,4)),
       numericInput("dof",
                    label = "Degrees of freedom",
                    value = 12,
                    min = 1,
                    max = 1000,
                    step = 1),
       numericInput("CI",
                    label = HTML("Confidence Interval (1-&alpha;:)"),
                    min = 0.01,
                    max = 0.999,
                    value = 0.95,
                    step = 0.01),
       radioButtons ("normal",
                     label = "Compare with Normal distribution?",
                     choices = c("YES" = 1, "NO" = 2),
                     selected = 2),
       submitButton("Apply and submit")
    ),
 
    # Show a plot of the generated distribution
    mainPanel(
          h3('Results'),
          h4('Plot visualizer'),
          #verbatimTextOutput("xx"),
          #verbatimTextOutput("yy"),
            plotOutput("tplot"),
          h5('The "x" range associated with the desired Confidence Interval is:'),
            textOutput("CI"),
            textOutput("CI_n")
                
    )
  )
))
