


###############  Simulation Study ################################
###############  Continuous Outcome ##############################
###############  Hengshi Yu ######################################
library(mvtnorm)
library(geepack)
library(randomForest)
library(MASS)
#source("geenonpa.R")

n <- 1000
m <- 5
beta_0 <- 20
upperA <- pi
lowerA <- 0
rho <- 0.4
rho_min <- 0.3
rho_max <- 0.55
rho_std <- 0.13
sigmai <- 345
A_list <- seq(lowerA, upperA, length = 100)
A_cos_list <- cos(A_list)
Adata_frame <- as.data.frame(A_list)
Adata_frame_1 <- as.data.frame(A_list+1)
Adata_frame_p1 <- as.data.frame(A_list+0.1)
Adata_frame_p2 <- as.data.frame(A_list+0.01)
names(Adata_frame) <- "treatment"
names(Adata_frame_1) <- "treatment"
names(Adata_frame_p1) <- "treatment"
names(Adata_frame_p2) <- "treatment"
simu <- function(n, m, data_use = NULL){
  mu <- matrix(NA,n,m)    ## means of n*m individuals in n clusters
  y <- matrix(NA,n,m)     ## results of n*m individuals in n clusters
  X <- matrix(NA,n,m)
  R <- matrix(NA, m,m)
  A <- diag(sigmai, m)
 for(i in 1:n){
    X[i, ] <- runif(1, lowerA, upperA)
    beta_A <- cos(X[i, 1])
    for(j in 1:m){
      mu[i,j] <- beta_0  + beta_A * X[i,j] 
    }
    rho_value <- rnorm(1, rho, rho_std)
    rho_value <- rho_value * (rho_value <= rho_max) *(rho_value >= rho_min) + rho_min * (rho_value < rho_min) + rho_max * (rho_value > rho_max)
    for(j in 1:m){
      for(k in 1:m){
        R[j,k]<-ifelse(j==k, 1, rho_value)  
      }
    }
    Variance <- A^(1/2)%*% R %*% A^(1/2)
    y[i, ] <- rmvnorm(1,mean=mu[i,],sigma=Variance)
   }
  idmatrix <- matrix(NA,n,m)
  for(i in 1:n){
    idmatrix[i,] <- i
  }

  # variances for kgee
  #Vpost_naive <- cov(as.matrix(y))
 # Vuse1 <- bdiag(lapply(1:n, function(i) solve(Vpost_naive)))
 # Vuse2 <- diag(rep(solve(killoffdiag(Vpost_naive)), n)) 

  # yobs
  yob<-as.vector(t(y)) ## transpose the outcome matrix to be a vector
  treatment<-as.vector(t(X))
  id <- as.vector(t(idmatrix))
  obs<-data.frame(id, treatment, yob)
  obs$treatment2 <- obs$treatment * obs$treatment
  obs$treatment3 <- obs$treatment2 * obs$treatment
  obs$treatment4 <- obs$treatment3 * obs$treatment

  data_use <- rbind(data_use, obs)
  #geeglm_na <-  geeglm(formula=yob~treatment, id = id, data = data_use, family = gaussian, corstr="exchangeable")
  #geeglm_co <-  geeglm(formula=yob~treatment + treatment2 + treatment3, id = id, data = data_use, family = gaussian, corstr="exchangeable")
  geeglm_co2 <- geeglm(formula=yob~treatment + treatment2 + treatment3 + treatment4, id = id, data = data_use, family = gaussian, corstr = "exchangeable")
  #gee_na <- c()
  #gee_co <- c()
  gee_co2 <- c()
  for(j in 1:length(A_list)){
    #gee_na <- c(gee_na, summary(geeglm_na)$coef[2,1])
    Avalue <- A_list[j]
    #gee_co_value <- summary(geeglm_co)$coef[2,1] + summary(geeglm_co)$coef[3,1] * Avalue + 3 * summary(geeglm_co)$coef[4,1] * Avalue * Avalue 
    #gee_co <- c(gee_co,  gee_co_value)
    gee_co2_value <- summary(geeglm_co2)$coef[2,1] + summary(geeglm_co2)$coef[3,1] * Avalue + 3 * summary(geeglm_co2)$coef[4,1] * Avalue * Avalue + 4 * summary(geeglm_co2)$coef[5,1] * Avalue * Avalue * Avalue 
    gee_co2 <- c(gee_co2, gee_co2_value)  
  }

  # random forest model 
  # rf_model <- randomForest(yob ~ treatment, data = data_use, importance = TRUE)
  # predTrain <- predict(rf_model, Adata_frame)
  # predTrain1 <-  predict(rf_model, Adata_frame_1)
  # predTrainp1 <-  predict(rf_model, Adata_frame_p1)
  # predTrainp2 <-  predict(rf_model, Adata_frame_p2)
  # rf_na <-  as.numeric(predTrain1) -  as.numeric(predTrain)
  # rf_co1 <- 10*(as.numeric(predTrainp1) -  as.numeric(predTrain))
  # rf_co2 <- 100*(as.numeric(predTrainp2) -  as.numeric(predTrain))
  
  #h_value <- (A_list[2] - A_list[1])

  #gee_non_para =  kgee(x= treatment, y= yob, h = h_value, xgrid= A_list,  id=id, V1= Vuse2)$f
  #gee_non_para_1 =  kgee(x= treatment, y= yob, h = h_value, xgrid= A_list + 1,  id=id, V1= Vuse2)$f
  #gee_non_para_p1 =  kgee(x= treatment, y= yob, h = h_value, xgrid= A_list + 0.1,  id=id, V1= Vuse2)$f
  #gee_non_para_p2 =  kgee(x= treatment, y= yob, h = h_value, xgrid= A_list + 0.01,  id=id, V1= Vuse2)$f
  
  # kgee_na <- as.numeric(gee_non_para_1) -  as.numeric(gee_non_para)
  # kgee_co1 <- 10 * (as.numeric(gee_non_para_p1) -  as.numeric(gee_non_para))
  # kgee_co2 <- 100 * (as.numeric(gee_non_para_p2) -  as.numeric(gee_non_para))

  return(list(gee_co2 = gee_co2, 
              data_generate = data_use))
}

nsim <- 1167
m <- 5

gee_na_data <- gee_co_data <- gee_co2_data <- rf_na_data <- rf_co1_data <- rf_co2_data <- NULL
kgee_na_data <- kgee_co1_data <- kgee_co2_data <- NULL
kgee_curve_data <- NULL

data_have <- NULL

#taskn <- as.numeric(Sys.getenv("SLURM_ARRAY_TASK_ID")) 
# no set.seed()
set.seed(123)
for(i in 1:nsim){
  print(i)
  result <- simu(n, m, data_use = data_have)
  
  # data 
  data_have <- result$data_generate

  # gee_na_data <- cbind(gee_na_data, result$gee_na)
  # gee_co_data <- cbind(gee_co_data, result$gee_co)
  gee_co2_data <- cbind(gee_co2_data, result$gee_co2)
  # rf_na_data <- cbind(rf_na_data, result$rf_na)
  # rf_co1_data <- cbind(rf_co1_data, result$rf_co1)
  # rf_co2_data <- cbind(rf_co2_data, result$rf_co2)
  # kgee_na_data <- cbind(kgee_na_data, result$kgee_na)
  # kgee_co1_data <- cbind(kgee_co1_data, result$kgee_co1)
  # kgee_co2_data <- cbind(kgee_co2_data, result$kgee_co2)
  # kgee_curve_data <- cbind(kgee_curve_data, result$kgee_curve)
  # save data
  # save(gee_na_data, file = paste0("./output/gee_na_", taskn, "_data.RData"))
  # save(gee_co_data, file = paste0("./output/gee_co_", taskn, "_data.RData"))
  
  # save(rf_na_data, file = paste0("./output/rf_na_", taskn, "_data.RData"))
  # save(rf_co1_data, file = paste0("./output/rf_co1_", taskn, "_data.RData"))
  # save(rf_co2_data, file = paste0("./output/rf_co2_", taskn, "_data.RData"))
  # save(kgee_na_data, file = paste0("./output/kgee_na_", taskn, "_data.RData"))
  # save(kgee_co1_data, file = paste0("./output/kgee_co1_", taskn, "_data.RData"))
  # save(kgee_co2_data, file = paste0("./output/kgee_co2_", taskn, "_data.RData"))  
  # compare
  # gee_na_bias <- rowMeans(gee_na_data) - A_cos_list 
  # gee_na_Var <-apply(gee_na_data,1,var)
  # gee_co_bias <- rowMeans(gee_co_data) - A_cos_list 
  # gee_co_Var <-apply(gee_co_data,1,var)
  # gee_co2_bias <- rowMeans(gee_co2_data) - A_cos_list 
  # gee_co2_Var <-apply(gee_co2_data,1,var)
  save(gee_co2_data, file = paste0("./output/gee_co2_data.RData"))
  # rf_na_bias <- rowMeans(rf_na_data) - A_cos_list 
  # rf_na_Var <-apply(rf_na_data,1,var)
  # rf_co1_bias <- rowMeans(rf_co1_data) - A_cos_list 
  # rf_co1_Var <-apply(rf_co1_data,1,var)
  # rf_co2_bias <- rowMeans(rf_co2_data) - A_cos_list 
  # rf_co2_Var <-apply(rf_co2_data,1,var)


  # kgee_na_bias <- rowMeans(kgee_na_data) - A_cos_list 
  # kgee_na_Var <-apply(kgee_na_data,1,var)
  # kgee_co1_bias <- rowMeans(kgee_co1_data) - A_cos_list 
  # kgee_co1_Var <-apply(kgee_co1_data,1,var)
  # kgee_co2_bias <- rowMeans(kgee_co2_data) - A_cos_list 
  # kgee_co2_Var <-apply(kgee_co2_data,1,var)



  # sink(paste0("./output/result_", taskn, ".txt"))
  # print("Simulation step:")
  # print(i)
  # print("Bias:")
  # print("GEE naive")
  # print(gee_na_bias)
  # print("GEE complex 3rd order")
  # print(gee_co_bias)
  # print("GEE complex 4th order")
  # print(gee_co2_bias)
  # print("RF naive")
  # print(rf_na_bias)
  # print("RF complex 0.1")
  # print(rf_co1_bias)
  # print("RF complex 0.01")
  # print(rf_co2_bias) 
  # print("GEE nonparametric naive")
  # print(kgee_na_bias)
  # print("GEE nonparametric 0.1")
  # print(kgee_co1_bias)
  # print("GEE nonparametric 0.01")
  # print(kgee_co2_bias)
  # ## Variance
  # print("Variance:")
  # print("GEE naive")
  # print(gee_na_Var)
  # print("GEE complex 3rd order")
  # print(gee_co_Var)
  # print("GEE complex 4th order")
  # print(gee_co2_Var)
  # print("RF naive")
  # print(rf_na_Var)
  # print("RF complex 0.1")
  # print(rf_co1_Var)
  # print("RF complex 0.01")
  # print(rf_co2_Var) 
  # print("GEE nonparametric naive")
  # print(kgee_na_Var)
  # print("GEE nonparametric 0.1")
  # print(kgee_co1_Var)
  # print("GEE nonparametric 0.01")
  # print(kgee_co2_Var)
  # #### current 
  # print("Current")
  # print("GEE naive")
  # print(result$gee_na)
  # print("GEE complex 3rd order")
  # print(result$gee_co)
  # print("GEE complex 4th order")
  # print(result$gee_co2)
  # print("RF naive")
  # print(result$rf_na)
  # print("RF complex 1")
  # print(result$rf_co1)
  # print("RF complex 2")
  # print(result$rf_co2)
  # print("GEE nonparametric naive")
  # print(result$kgee_na)
  # print("GEE nonparametric 0.1")
  # print(result$kgee_co1)
  # print("GEE nonparametric 0.01")
  # print(result$kgee_co2)
  # sink()
}
