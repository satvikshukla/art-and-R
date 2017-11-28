library(shiny)
library(plotly)

shinyUI(fluidPage(

  titlePanel("Art and R"),

  sidebarLayout(
	sidebarPanel(

		selectInput(
			"colspa", "Color space", choices = list("RGB" = "rgb", "HSV" = "hsv", "LAB" = "lab", "LCH" = "lch"), selected = 1
		),

		conditionalPanel(
			condition = "input.colspa == 'hsv'", selectInput(
				"colchoice", "Color choice", choices = list("Hue" = "h", "Saturation" = "s", "Value" = "v"), selected = 1
			)
		),
		conditionalPanel(
			condition = "input.colspa == 'lab'", selectInput(
				"colchoice", "Color choice", choices = list("Lightness" = "l", "Green-Red" = "a", "Blue-Yellow" = "b"), selected = 1
			)
		),
		conditionalPanel(
			condition = "input.colspa == 'lch'", selectInput(
				"colchoice", "Color choice", choices = list("Lightness" = "l", "Chroma" = "c", "Hue" = "h"), selected = 1
			)
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