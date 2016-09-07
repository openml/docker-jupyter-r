library(devtools)

install.packages("mlr", repos="http://cran.us.r-project.org")
install_github("IRkernel/repr")
install_github("mlr-org/farff", upgrade_dependencies=FALSE)
install_github("openml/r", upgrade_dependencies=FALSE)