library(shiny)
library(highcharter)

shinyUI(fluidPage(

	titlePanel("Art and R"),

	sidebarLayout(
		sidebarPanel(

	  		selectInput(
				"colspa", "Color space", choices = list("RGB" = "rgb", "HSV" = "hsv", "LAB" = "lab", "LCH" = "lch", "LUV" = "luv"), selected = 1
	  		),	

			actionButton("btn1", "Select Color Space"),

	  		conditionalPanel(
				condition = "", selectInput(
		  			"colchoice", "Color choice", choices = list("Red" = "r", "Green" = "g", "Blue" = "b"), selected = 1
				)
	  		),

			  actionButton("btn2", "Graph!")

			# conditionalPanel(
			# 	condition = "input.colspa == 'hsv'", selectInput(
			# 		"colchoice", "Color choice", choices = list("Hue" = "h", "Saturation" = "s", "Value" = "v"), selected = 1
			# 	)
			# ),

		),

		mainPanel(
	  		highchartOutput("distPlot", height = "500px")
		)
  	)
))