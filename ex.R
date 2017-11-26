library("dplyr")
library("stringr")
library("readr")
library("ggplot2")

stat <- read_csv("stats1.csv", col_names = c("X1"))
col <- stat$X1
df <- data.frame(matrix(ncol = 63, nrow = 0), stringsAsFactors = FALSE)
df.colnames <-  c("artist", "art", "year",
				  "hsv.h.avg", "hsv.h.median", "hsv.h.min", "hsv.h.max", 
				  "hsv.s.avg", "hsv.s.median", "hsv.s.min", "hsv.s.max", 
				  "hsv.v.avg", "hsv.v.median", "hsv.v.min", "hsv.v.max", 
				  "lab.a.avg", "lab.a.median", "lab.a.min", "lab.a.max", 
				  "lab.b.avg", "lab.b.median", "lab.b.min", "lab.b.max", 
				  "lab.l.avg", "lab.l.median", "lab.l.min", "lab.l.max", 
				  "lch.c.avg", "lch.c.median", "lch.c.min", "lch.c.max", 
				  "lch.h.avg", "lch.h.median", "lch.h.min", "lch.h.max", 
				  "lch.l.avg", "lch.l.median", "lch.l.min", "lch.l.max", 
				  "luv.l.avg", "luv.l.median", "luv.l.min", "luv.l.max", 
				  "luv.u.avg", "luv.u.median", "luv.u.min", "luv.u.max", 
				  "luv.v.avg", "luv.v.median", "luv.v.min", "luv.v.max", 
				  "rgb.b.avg", "rgb.b.median", "rgb.b.min", "rgb.b.max", 
				  "rgb.g.avg", "rgb.g.median", "rgb.g.min", "rgb.g.max", 
				  "rgb.r.avg", "rgb.r.median", "rgb.r.min", "rgb.r.max")
colnames(df) <- df.colnames
v <- vector()
for (i in 1:length(col)) {
	str <- iconv(col[i], to='ASCII//TRANSLIT')
	j <- (i - 1) %% 61
	if (j == 0) {
		col[i] <- str_extract(str, "([a-z]|[A-Z]| )*;")
		str.to.add <- gsub(";", "", col[i])
		v <- c(v, str.to.add)
	}
	if (j == 0) {
		col[i] <- str_extract(str, ";([a-z]|[A-Z]|[0-9]| |'|. |(|)|)*")
		str.to.add <- gsub(";", "", col[i])
		v <- c(v, str.to.add)
	}
	if (j == 0) {
		col[i] <- str_extract(str, ";[0-9]+")
		str.to.add <- gsub(";", "", col[i])
		v <- c(v, str.to.add)
	}
	else if (j == 1) {
		col[i] <- str_extract(col[i], " [0-9]* ")
		v <- c(v, col[i])
	}
	else if (j == 60) {
		col[i] <- str_extract(col[i], "-?[0-9]*$")
		v <- c(v, col[i])
		vec.df <- as.data.frame(t(v))
		colnames(vec.df) <- df.colnames
		df <- rbind(df, vec.df)
		v <- vector()
	}
	else {
		col[i] <- str_extract(col[i], "-?[0-9]*$")
		v <- c(v, col[i])
	}
}
df <- cbind(df[,1:3], lapply(df[,4:63], as.numeric))
df <- df %>% mutate(year = as.numeric(as.character(year))) %>% arrange(year)
temp <- complete.cases(df[,df.colnames])
df <- df[temp, ]
write_csv(df, "data1.csv")
p1 <- ggplot(df, aes(x = year, y = rgb.b.median)) + geom_point(size = 1)
p2 <- ggplot(df, aes(x = year, y = rgb.b.median)) + geom_boxplot(aes(group = year))
p3 <- ggplot(df, aes(x = year, y = rgb.b.median)) + geom_point(alpha = .1)
p4 <- ggplot(df, aes(x = year, y = rgb.b.median)) + geom_point(size = 1) + stat_smooth(method = lm)
p5 <- ggplot(df, aes(x = year, y = rgb.b.median)) + geom_point(size = 1) + stat_smooth(method = loess, level = 0.99)