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
				condition = "", selectInput(
		  			"colchoice", "Sub-choice", choices = list("Red" = "r", "Green" = "g", "Blue" = "b"), selected = 1
				)
	  		),

			actionButton("btn", "Graph!")
		),

		mainPanel(
	  		plotlyOutput("distPlot")
		)
  	)
))