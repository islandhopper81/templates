#!/usr/bin/evn Rscript

### Description
# [description]

### R Libraries
require("getopt", quietly=T)
require("ggplot2", quietly=T)
require("grid", quietly=T)
require("gridExtra", quietly=T)

### Defualt variables
verbose = FALSE

### Parameter variables
# The params matrix
# Each row is a parameter with 4 columns: 
#   1) long value, 
#   2) short value, 
#   3) argument type where 0 = no argument, 1 = required , 2 = optional
#   4) data type (logical, integer, double, complex, character)
# When you call this script the args are named like --verbose or -v
params = matrix(c(
  "data", "d", 1, "character",
  "out", "o", 1, "character",
  "verbose", "v", 0, "logical"
  ), byrow=TRUE, ncol=4)
opt = getopt(params)

# define parameter specified varaibles
if (! is.null(opt$verbose)) {
  verbose = opt$verbose
}


### Functions
main = function() {
	data = read.table(opt$data, header=T, sep="\t")
}

# run the main function to execute the program
main()
