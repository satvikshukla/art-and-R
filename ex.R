library(dplyr)
library(stringr)

stat <- read.csv("stats.csv", stringsAsFactors = FALSE, header = FALSE)
col <- stat[, 1]
df <- data.frame(matrix(ncol = 63, nrow = 0))
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
	str <- col[i]
    j <- (i - 1) %% 61
    if (j == 0) {
    	col[i] <- str_extract(str, "([a-z]|[A-Z]|[0-9]| |\\p{L})*;")
    	str.to.add <- gsub(";", "", col[i])
    	v <- c(v, str.to.add)
    }
    if (j == 0) {
    	col[i] <- str_extract(str, ";([a-z]|[A-Z]| |\\p{L})*")
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
write.csv(df, "data.csv", row.names = FALSE)