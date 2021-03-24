# summary of project

direc_1 <- "simulation/output"
direc_2 <- "simulation/simulation_2/output"
direc_3 <- "simulation/output_new/output"
direc_4 <- "simulation/output"


gee_na <- gee_co <- gee_co2 <- NULL
rf_na <- rf_co1 <- rf_co2 <- NULL
kgee_na <- kgee_co1 <- kgee_co2 <- NULL

setwd(direc_1)
load("gee_na_data.RData")
load("gee_co_data.RData")
load("rf_na_data.RData")
load("rf_co1_data.RData")
load("rf_co2_data.RData")

gee_na = gee_na_data[, 1:500]
gee_co <- gee_co_data[, 1:500]
rf_na <- rf_na_data[, 1:500]
rf_co1 <- rf_co1_data[, 1:500]
rf_co2 <- rf_co2_data[, 1:500]

# setwd(direc_2)
# load("gee_na_data.RData")
# load("gee_co_data.RData")
# load("rf_na_data.RData")
# load("rf_co1_data.RData")
# load("rf_co2_data.RData")


# gee_na = cbind(gee_na, gee_na_data)
# gee_co <- cbind(gee_co, gee_co_data)
# rf_na <- cbind(rf_na, rf_na_data)
# rf_co1 <- cbind(rf_co1, rf_co1_data)
# rf_co2 <- cbind(rf_co2, rf_co2_data)

setwd(direc_4)
load("kgee_co1__data.RData")
load("kgee_na__data.RData")
load("kgee_co2__data.RData")
load("kgee_curve__data.RData")
load("data_have.RData")
load("gee_co2_data.RData")

kgee_na <- kgee_na_data[, 1:100]
kgee_co1 <- kgee_co1_data[, 1:100]
kgee_co2 <- kgee_co2_data[, 1:100]
kgee_curve <- kgee_curve_data[, 1:100]
gee_co2 <- gee_co2_data[, 1:500]



# 
# setwd(direc_3)
# file_names=as.list(dir(path = '.', pattern="gee_na_*"))
# length(file_names)
# file_names = lapply(file_names, function(x) paste0('./', x))
# for(i in 1:10){
#   load(unlist(file_names)[i])
#   gee_na <- cbind(gee_na, gee_na_data)
# }
# 
# file_names=as.list(dir(path = '.', pattern="gee_co_*"))
# length(file_names)
# file_names = lapply(file_names, function(x) paste0('./', x))
# for(i in 1:10){
#   load(unlist(file_names)[i])
#   gee_co <- cbind(gee_co, gee_co_data)
# }
# 
# file_names=as.list(dir(path = '.', pattern="gee_co2_*"))
# length(file_names)
# file_names = lapply(file_names, function(x) paste0('./', x))
# for(i in 1:10){
#   load(unlist(file_names)[i])
#   gee_co2 <- cbind(gee_co2, gee_co2_data)
# }
# 
# file_names=as.list(dir(path = '.', pattern="rf_na_*"))
# length(file_names)
# file_names = lapply(file_names, function(x) paste0('./', x))
# for(i in 1:10){
#   load(unlist(file_names)[i])
#   rf_na <- cbind(rf_na, rf_na_data)
# }
# 
# file_names=as.list(dir(path = '.', pattern="rf_co1_*"))
# length(file_names)
# file_names = lapply(file_names, function(x) paste0('./', x))
# for(i in 1:10){
#   load(unlist(file_names)[i])
#   rf_co1 <- cbind(rf_co1, rf_co1_data)
# }
# 
# file_names=as.list(dir(path = '.', pattern="rf_co2_*"))
# length(file_names)
# file_names = lapply(file_names, function(x) paste0('./', x))
# for(i in 1:10){
#   load(unlist(file_names)[i])
#   rf_co2 <- cbind(rf_co2, rf_co2_data)
# }
# 
# file_names=as.list(dir(path = '.', pattern="kgee_na_*"))
# length(file_names)
# file_names = lapply(file_names, function(x) paste0('./', x))
# for(i in 1:10){
#   load(unlist(file_names)[i])
#   kgee_na <- cbind(kgee_na, kgee_na_data)
# }
# 
# file_names=as.list(dir(path = '.', pattern="kgee_co1_*"))
# length(file_names)
# file_names = lapply(file_names, function(x) paste0('./', x))
# for(i in 1:10){
#   load(unlist(file_names)[i])
#   kgee_co1 <- cbind(kgee_co1, kgee_co1_data)
# }
# 
# file_names=as.list(dir(path = '.', pattern="kgee_co2_*"))
# length(file_names)
# file_names = lapply(file_names, function(x) paste0('./', x))
# for(i in 1:10){
#   load(unlist(file_names)[i])
#   kgee_co2 <- cbind(kgee_co2, kgee_co2_data)
# }






lowerA = 0
upperA <- pi
A_list <- seq(lowerA, upperA, length = 100)
A_cos_list <- cos(A_list)


par(mar=c(4,6,2,2), mfrow=c(2,2))
range_gee <- range(c(gee_na[, 125], A_cos_list, gee_co2[, 125], gee_co[, 125]))
plot(A_list, A_cos_list, type = "l", ylim = range_gee,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 125000 individuals", col = "red")
lines(A_list, gee_na[, 125], lty = 3, lwd =2, col = "blue")
lines(A_list, gee_co[,125], lty = 4, lwd =2, col = "orange")
lines(A_list, gee_co2[,125], lty = 5, lwd =2, col = "purple")

range_gee <- range(c(gee_na[, 250], A_cos_list, gee_co2[, 250], gee_co[, 250]))
plot(A_list, A_cos_list, type = "l", ylim = range_gee,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 250000 individuals", col = "red")
lines(A_list, gee_na[, 250], lty = 3, lwd =2, col = "blue")
lines(A_list, gee_co[,250], lty = 4, lwd =2, col = "orange")
lines(A_list, gee_co2[,250], lty = 5, lwd =2, col = "purple")

range_gee <- range(c(gee_na[, 375], A_cos_list, gee_co2[, 375], gee_co[, 375]))
plot(A_list, A_cos_list, type = "l", ylim = range_gee,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 375000 individuals", col = "red")
lines(A_list, gee_na[, 375], lty = 3, lwd =2, col = "blue")
lines(A_list, gee_co[,375], lty = 4, lwd =2, col = "orange")
lines(A_list, gee_co2[,375], lty = 5, lwd =2, col = "purple")

range_gee <- range(c(gee_na[, 500], A_cos_list, gee_co2[, 500], gee_co[, 500]))
plot(A_list, A_cos_list, type = "l", ylim = range_gee,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 500000 individuals", col = "red")
lines(A_list, gee_na[, 500], lty = 3, lwd =2, col = "blue")
lines(A_list, gee_co[,500], lty = 4, lwd =2, col = "orange")
lines(A_list, gee_co2[,500], lty = 5, lwd =2, col = "purple")

par(mar=c(4,6,2,2), mfrow=c(2,2))
range_rf <- range(c(rf_na[, 125], A_cos_list, rf_co1[,125], rf_co2[, 125]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 125000 individuals", col = "red")
lines(A_list, rf_na[,125], lty = 3, lwd =2, col = "blue")
lines(A_list, rf_co1[,125], lty = 4, lwd =2, col = "orange")
lines(A_list, rf_co2[,125], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(rf_na[, 250], A_cos_list, rf_co1[,250], rf_co2[, 250]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 250000 individuals", col = "red")
lines(A_list, rf_na[,250], lty = 3, lwd =2, col = "blue")
lines(A_list, rf_co1[,250], lty = 4, lwd =2, col = "orange")
lines(A_list, rf_co2[,250], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(rf_na[, 375], A_cos_list, rf_co1[,375], rf_co2[, 375]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 375000 individuals", col = "red")
lines(A_list, rf_na[,375], lty = 3, lwd =2, col = "blue")
lines(A_list, rf_co1[,375], lty = 4, lwd =2, col = "orange")
lines(A_list, rf_co2[,375], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(rf_na[, 500], A_cos_list, rf_co1[,500], rf_co2[, 500]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 500000 individuals", col = "red")
lines(A_list, rf_na[,500], lty = 3, lwd =2, col = "blue")
lines(A_list, rf_co1[,500], lty = 4, lwd =2, col = "orange")
lines(A_list, rf_co2[,500], lty = 5, lwd =2, col = "purple")

#########################

par(mar=c(4,6,2,2), mfrow=c(2,2))
range_rf <- range(c(rf_na[, 125], A_cos_list, rf_co1[,125]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 125000 individuals", col = "red")
lines(A_list, rf_na[,125], lty = 3, lwd =2, col = "blue")
lines(A_list, rf_co1[,125], lty = 4, lwd =2, col = "orange")
#lines(A_list, rf_co2[,125], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(rf_na[, 250], A_cos_list, rf_co1[,250]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 250000 individuals", col = "red")
lines(A_list, rf_na[,250], lty = 3, lwd =2, col = "blue")
lines(A_list, rf_co1[,250], lty = 4, lwd =2, col = "orange")
#lines(A_list, rf_co2[,250], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(rf_na[, 375], A_cos_list, rf_co1[,375]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 375000 individuals", col = "red")
lines(A_list, rf_na[,375], lty = 3, lwd =2, col = "blue")
lines(A_list, rf_co1[,375], lty = 4, lwd =2, col = "orange")
#lines(A_list, rf_co2[,375], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(rf_na[, 500], A_cos_list, rf_co1[,500]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 500000 individuals", col = "red")
lines(A_list, rf_na[,500], lty = 3, lwd =2, col = "blue")
lines(A_list, rf_co1[,500], lty = 4, lwd =2, col = "orange")
#lines(A_list, rf_co2[,500], lty = 5, lwd =2, col = "purple")


#########################

par(mar=c(4,6,2,2), mfrow=c(2,2))
range_rf <- range(c(rf_na[, 125], A_cos_list))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 125000 individuals", col = "red")
lines(A_list, rf_na[,125], lty = 3, lwd =2, col = "blue")
#lines(A_list, rf_co1[,125], lty = 4, lwd =2, col = "orange")
#lines(A_list, rf_co2[,125], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(rf_na[, 250], A_cos_list))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 250000 individuals", col = "red")
lines(A_list, rf_na[,250], lty = 3, lwd =2, col = "blue")
#lines(A_list, rf_co1[,250], lty = 4, lwd =2, col = "orange")
#lines(A_list, rf_co2[,250], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(rf_na[, 375], A_cos_list))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 375000 individuals", col = "red")
lines(A_list, rf_na[,375], lty = 3, lwd =2, col = "blue")
#lines(A_list, rf_co1[,375], lty = 4, lwd =2, col = "orange")
#lines(A_list, rf_co2[,375], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(rf_na[, 500], A_cos_list))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 500000 individuals", col = "red")
lines(A_list, rf_na[,500], lty = 3, lwd =2, col = "blue")
#lines(A_list, rf_co1[,500], lty = 4, lwd =2, col = "orange")
#lines(A_list, rf_co2[,500], lty = 5, lwd =2, col = "purple")


##################
par(mar=c(4,6,2,2), mfrow=c(2,2))
range_rf <- range(c(kgee_na[, 25], A_cos_list, kgee_co1[, 25], kgee_co2[, 25]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 125000 individuals", col = "red")
lines(A_list, kgee_na[,25], lty = 3, lwd =2, col = "blue")
lines(A_list, kgee_co1[,25], lty = 4, lwd =2, col = "orange")
lines(A_list, kgee_co2[,25], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(kgee_na[, 50], A_cos_list, kgee_co1[, 50], kgee_co2[, 50]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 250000 individuals", col = "red")
lines(A_list, kgee_na[,50], lty = 3, lwd =2, col = "blue")
lines(A_list, kgee_co1[,50], lty = 4, lwd =2, col = "orange")
lines(A_list, kgee_co2[,50], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(kgee_na[, 75], A_cos_list, kgee_co1[,75], kgee_co2[,75]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 375000 individuals", col = "red")
lines(A_list, kgee_na[,75], lty = 3, lwd =2, col = "blue")
lines(A_list, kgee_co1[,75], lty = 4, lwd =2, col = "orange")
lines(A_list, kgee_co2[,75], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(kgee_na[, 100], A_cos_list, kgee_co1[, 100], kgee_co2[, 100]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 500000 individuals", col = "red")
lines(A_list, kgee_na[,100], lty = 3, lwd =2, col = "blue")
lines(A_list, kgee_co1[,100], lty = 4, lwd =2, col = "orange")
lines(A_list, kgee_co2[,100], lty = 5, lwd =2, col = "purple")

#########################
par(mar=c(4,6,2,2), mfrow=c(2,2))
range_rf <- range(c(kgee_na[, 25], A_cos_list, kgee_co1[, 25]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 125000 individuals", col = "red")
lines(A_list, kgee_na[,25], lty = 3, lwd =2, col = "blue")
lines(A_list, kgee_co1[,25], lty = 4, lwd =2, col = "orange")
#lines(A_list, kgee_co2[,25], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(kgee_na[, 50], A_cos_list, kgee_co1[, 50]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 250000 individuals", col = "red")
lines(A_list, kgee_na[,50], lty = 3, lwd =2, col = "blue")
lines(A_list, kgee_co1[,50], lty = 4, lwd =2, col = "orange")
#lines(A_list, kgee_co2[,50], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(kgee_na[, 75], A_cos_list, kgee_co1[,75]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 375000 individuals", col = "red")
lines(A_list, kgee_na[,75], lty = 3, lwd =2, col = "blue")
lines(A_list, kgee_co1[,75], lty = 4, lwd =2, col = "orange")
#lines(A_list, kgee_co2[,75], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(kgee_na[, 100], A_cos_list, kgee_co1[, 100]))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 500000 individuals", col = "red")
lines(A_list, kgee_na[,100], lty = 3, lwd =2, col = "blue")
lines(A_list, kgee_co1[,100], lty = 4, lwd =2, col = "orange")
#lines(A_list, kgee_co2[,100], lty = 5, lwd =2, col = "purple")

########################

par(mar=c(4,6,2,2), mfrow=c(2,2))
range_rf <- range(c(kgee_na[, 25], A_cos_list))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 125000 individuals", col = "red")
lines(A_list, kgee_na[,25], lty = 3, lwd =2, col = "blue")
#lines(A_list, kgee_co1[,25], lty = 4, lwd =2, col = "orange")
#lines(A_list, kgee_co2[,25], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(kgee_na[, 50], A_cos_list))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 250000 individuals", col = "red")
lines(A_list, kgee_na[,50], lty = 3, lwd =2, col = "blue")
#lines(A_list, kgee_co1[,50], lty = 4, lwd =2, col = "orange")
#lines(A_list, kgee_co2[,50], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(kgee_na[, 75], A_cos_list))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 375000 individuals", col = "red")
lines(A_list, kgee_na[,75], lty = 3, lwd =2, col = "blue")
#lines(A_list, kgee_co1[,75], lty = 4, lwd =2, col = "orange")
#lines(A_list, kgee_co2[,75], lty = 5, lwd =2, col = "purple")

range_rf <- range(c(kgee_na[, 100], A_cos_list))

plot(A_list, A_cos_list, type = "l", ylim = range_rf,  xlab = "Treatment a", ylab = expression(beta(a)), cex.lab = 1.3, cex.axis = 1.2, lwd = 1.2, main = "Estimated Causal Effects with 500000 individuals", col = "red")
lines(A_list, kgee_na[,100], lty = 3, lwd =2, col = "blue")
#lines(A_list, kgee_co1[,100], lty = 4, lwd =2, col = "orange")
#lines(A_list, kgee_co2[,100], lty = 5, lwd =2, col = "purple")

#######################