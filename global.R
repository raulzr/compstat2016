library(Rcpp)
library(RcppArmadillo)

# Archivos Tarea 1
source("./Tarea1/tarea1_ui.R")
source("./Tarea1/tarea1_server.R")

# Archivos Tarea 2
source("./Tarea2/tarea2_ui.R")
source("./Tarea2/tarea2_server.R")

# Archivos Tarea 4
source("./Tarea4/tarea4_ui.R")
source("./Tarea4/tarea4_server.R")

tab_vino <- read.csv("./Tarea4/wine.csv")

# Archivos Tarea 5
source("./Tarea5/tarea5_ui.R")
source("./Tarea5/tarea5_server.R")
print("Estoy compilando el C++")
sourceCpp("./Tarea5/cpp_funs_cas.cpp")