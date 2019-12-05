#read empop file, parse the first line and blow it out to its sequence.
library(tidyverse)

# read in the input file
inputFile <- read_lines(file.choose(), n_max = -1L, na = character())

# parse the first line of the file into a vector delimited by space
inputPos <- unlist(str_split(inputFile[1], "\\s"))

# strip the first character as well as any trailing space at the end of the line
if(length(inputPos) > 2){
  inputPos_1<-inputPos[2:(length(inputPos)-1)]
}else{
  inputPos_1<-inputPos[2]
}

#allPos  <- vector('numeric') #OR numeric()

# create a list of length of #of positions in the file.
allPos_L <- vector("list", length(inputPos_1))

# loop into the vector splitting each element to blow up from range 
# to the actual positions present
for (i in seq_along(inputPos_1)) {
  begin <- as.numeric(unlist(str_split(inputPos_1[[i]], "-"))[1])
  end <- as.numeric(unlist(str_split(inputPos_1[[i]], "-"))[2])
  #allPos <- append(allPos, seq(begin, end))
  allPos_L[[i]] <- seq(begin, end)
}

# unlist to convert to vector
allPos_expanded <- unlist(allPos_L)

