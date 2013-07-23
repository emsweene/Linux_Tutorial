temp <- commandArgs(TRUE)
number<-as.numeric(temp[1])

x <- matrix(c(1,2,3), 15, 15) * number

write(x, file = paste(number, "output", sep = "_"))