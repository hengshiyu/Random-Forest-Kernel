# summary of project

direc_1 <- "simulation/output"
direc_2 <- "simulation/simulation_2/output"
direc_3 <- "simulation/output_new/output"
direc_4 <- "simulation/output"


gee_na <- gee_co <- gee_co2 <- NULL
rf_na <- rf_co1 <- rf_co2 <- NULL


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




#######################