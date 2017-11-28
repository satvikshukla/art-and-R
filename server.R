library(shiny)
library(broom)
library(dplyr)
library(highcharter)

art.data <<- read.csv(file = "data1.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {

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
})