library(shiny)
library(plotly)
library(ggthemes)

art.data <- read.csv("data1.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {

	output$distPlot <- renderPlotly({
		col.str <- paste0(input$colspa, ".", input$rgbchoice, ".median")
		#p <- ggplot(art.data, aes(x = year, y = art.data[[col.str]], text = paste0(artist, "<br>", art))) + geom_point(size = 1) + stat_smooth(method = loess, se = FALSE) + theme_hc()
		#ggplotly(p , tooltip = "text")
		q <- ggplot(art.data, aes(x = year, y = art.data[[col.str]])) + geom_point(size = 1) + stat_smooth(method = loess, se = FALSE) + theme_hc()
		ggplotly(q)
		# hchart(art.data, "scatter", hcaes(x = year, y = hsv.h.median))
  })
})