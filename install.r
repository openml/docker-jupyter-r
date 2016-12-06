library(devtools)

packages = c(
	'OpenML',
	'mlr',
	'farff',
	'checkmate')
install.packages(packages)

install_github("IRkernel/repr")

# print installed packages versions
ip <- as.data.frame(installed.packages()[,c(1,3:4)])
rownames(ip) <- NULL
ip <- ip[is.na(ip$Priority),1:2,drop=FALSE]
print(ip, row.names=FALSE)