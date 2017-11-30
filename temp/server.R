library(shiny)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(httr)
library(jsonlite)

art.data <- read.csv(file = "./../data.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output, session) {

  observeEvent(input$colspa, {
	if(input$colspa == "rgb") {
	  myChoices <- c("Red" = "r", "Green" = "g", "Blue" = "b")
	}
	else if (input$colspa == "hsv") {
	  myChoices <- c("Hue" = "h", "Saturation" = "s", "Value" = "v")
	}
	else if (input$colspa == "lab") {
	  myChoices <- c("Luminance" = "l", "Red-Green" = "a", "Yellow-Blue" = "b")
	}
	else {
	  myChoices <- c("Lightness" = "l", "Chroma" = "c", "Hue" = "h")
	}
	updateSelectInput(session, "colchoice", choices = myChoices)
  })

	calculate <- eventReactive(input$btn, {
		col.str1 <- paste0(input$colspa, ".", input$colchoice, ".median")

		p <- ggplot(art.data, aes(x = year, y = art.data[[col.str1]], text = paste0("Artist: ", artist, "<br>", "Painting ", art), group=1)) + 
			geom_point(size = 2) + xlab("Year") + ylab(paste(toupper(input$colspa), toupper(input$colchoice), "Median")) + 
			stat_smooth(method = loess, se = FALSE) + theme_hc()

		ggplotly(p , tooltip = "text")
	})

	output$distPlot <- renderPlotly({
		calculate()
	})
})