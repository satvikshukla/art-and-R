library(shiny)
library(highcharter)
library(broom)
library(dplyr)

art.data <- read.csv("./../data1.csv", stringsAsFactors = FALSE)

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
	  ),

		conditionalPanel(
			condition = "input.colspa == 'hsv'", selectInput(
				"hsvchoice", "Color choice", choices = list("Hue" = "h", "Saturation" = "s", "Value" = "v"), selected = 1
			)
		)
	),

	mainPanel(
	  highchartOutput("distPlot", height = "500px")
	)
  )
)


server <- function(input, output) {

	output$distPlot <- renderHighchart({
		str1 <<- paste0(input$colspa, ".", input$rgbchoice, ".avg")
		
		modlss <- loess(art.data[[str1]] ~ year, data = art.data)
		fit <- augment(modlss) %>% arrange(year)
		
		#head(data)
		#head(fit)
		
		hc <- highchart() %>% 
			hc_add_series(art.data, "scatter", hcaes(x = year, y = art.data[[str1]])) %>% 
			hc_add_theme(hc_theme_elementary()) %>%
			hc_add_series(fit, type = "spline", hcaes(x = year, y = .fitted), name = "Fit",
						  id = "fit")# %>% 
			#hc_add_series(fit, type = "arearange",
			#			  hcaes(x = year, low = .fitted - .se.fit*2, high = .fitted + .se.fit*2),
			#			  linkedTo = "fit")
		
		hc

	})
}

# Run the application
shinyApp(ui = ui, server = server)