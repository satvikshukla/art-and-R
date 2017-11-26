library(shiny)
library(plotly)

shinyUI(fluidPage(

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
		plotlyOutput("distPlot")
	)
  )
))