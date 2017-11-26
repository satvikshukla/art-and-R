library(shiny)
library(plotly)

art.data <- read.csv("data1.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {

	output$distPlot <- renderPlotly({
		col.str <- paste0(input$colspa, ".", input$rgbchoice, ".avg")
		print(length(art.data$year))
		print(length(art.data[[col.str]]))
		print(art.data$year)
		print(art.data[[col.str]])
		print(min(art.data$year))
		print(max(art.data$year))
		print(min(art.data[[col.str]]))
		print(max(art.data[[col.str]]))
		p <- ggplot(art.data, aes(x = year, y = art.data[[col.str]], text = paste0(artist, "<br>", art))) + geom_point(size = 1) + stat_smooth(method = loess, se = FALSE)
		ggplotly(p , tooltip = "text")
  })
})