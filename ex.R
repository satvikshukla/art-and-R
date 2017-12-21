library("dplyr")
library("stringr")

# read file
stat <- read.csv("stats.csv", stringsAsFactors = FALSE)

# select column of interest
col <- stat[[1]]

# create dataframe with required parameters
df <- data.frame(matrix(ncol = 51, nrow = 0))
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
				  "rgb.b.avg", "rgb.b.median", "rgb.b.min", "rgb.b.max", 
				  "rgb.g.avg", "rgb.g.median", "rgb.g.min", "rgb.g.max", 
				  "rgb.r.avg", "rgb.r.median", "rgb.r.min", "rgb.r.max")

# set column names of resulting dataset
colnames(df) <- df.colnames

#create empty vector
v <- vector()

# lop over entire column
for (i in 1:length(col)) {

	# translate accented characters
	str <- iconv(col[i], to='ASCII//TRANSLIT')
	j <- (i - 1) %% 49

	# store artist name
	if (j == 0) {
		col[i] <- str_extract(str, "([a-z]|[A-Z]| )*;")
		str.to.add <- gsub(";", "", col[i])
		v <- c(v, str.to.add)
	}

	# store art name
	if (j == 0) {
		col[i] <- str_extract(str, ";([a-z]|[A-Z]|[0-9]| |'|. |(|)|)*")
		str.to.add <- gsub(";", "", col[i])
		v <- c(v, str.to.add)
	}

	# store art year
	if (j == 0) {
		col[i] <- str_extract(str, ";[0-9]+")
		str.to.add <- gsub(";", "", col[i])
		v <- c(v, str.to.add)
	}

	# store hsv h average
	if (j == 0) {
		col[i] <- str_extract(str, " [0-9]* ")
		v <- c(v, col[i])
	}

	# join all info about one art to resultant dataframe
	else if (j == 48) {
		col[i] <- str_extract(str, "-?[0-9]*$")
		v <- c(v, col[i])
		vec.df <- as.data.frame(t(v))
		colnames(vec.df) <- df.colnames
		df <- rbind(df, vec.df)
		v <- vector()
	}

	# store all other color parameters except hsv h avg and rgb r max
	else {
		col[i] <- str_extract(str, "-?[0-9]*$")
		v <- c(v, col[i])
	}
}

# remove rows with empty values
temp <- complete.cases(df[,df.colnames])
df <- df[temp, ]

# remove last column
df <- df[, 1:51]

# write to file
write.csv(df, "data.csv", row.names = FALSE)