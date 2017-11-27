library(shiny)
library(highcharter)

art.data <- read.csv("./../data1.csv", stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
  titlePanel("Art and R"),
  
  sidebarLayout(
	sidebarPanel(
	  
	  selectInput(
		"colspa", "Color space", choices = list("RGB" = "rgb", "HSV" = "hsv", "LAB" = "lab", "LCH" = "lch", "LUV" = "luv"), selected = 1
	  ),
	  
	  conditionalPanel(
		condition = "input.colspa == 'rgb'", selectInput(
		  "rgbchoice", "Color choice", choices = list("Red" = "r", "Green" = "g", "Blue" = "b"), selected = 1
		)
	  )
	),
	
	mainPanel(
	  highchartOutput("distPlot", height = "500px")
	)
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

	output$distPlot <- renderHighchart({
		 str1 <- paste0(input$colspa, ".", input$rgbchoice, ".avg")
	   hc <- highchart() %>% hc_add_series(data = art.data, type = "scatter", mapping = hcaes(x = year, y = rgb.b.avg)) %>% hc_add_theme(hc_theme_elementary())

	   hc
	 
	})
}

# Run the application 
shinyApp(ui = ui, server = server)

