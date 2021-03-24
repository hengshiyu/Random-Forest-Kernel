# nonparametric GEE
# For close form solutions
kern <- function(z){
	return(3/4 * (1 - z^2) * as.numeric(abs(z)<1))
}

kd <- function(z, h, Z){
	zc <- (Z - z) / h
	return(diag(sapply(zc, kern) / h))
}
  
kw <- function(z, h, Z, W, V1){
	u <- as.matrix(rep(1, length(Z)), ncol = 1)
    r <- t(u) %*% W %*% kd(z, h, Z)
    return(solve(r %*% V1 %*% u,  r))
}
  
kw1 <- function(z, h, Z, V1){
	u <- as.matrix(rep(1, length(Z)), ncol = 1)
	r <- t(u) %*% kd(z, h, Z)
    return(solve(r %*% V1 %*% u, r))
}
  
kww <- function(h, Z, W, V1){
	return(t(sapply(Z, function(x) kw(x, h, Z, W, V1))))
}
  
  
kww1 <- function(h, Z, V1){
	return(t(sapply(Z, function(x) kw1(x, h, Z, V1))))
}


mu <- function(t){
  t
}

# Function to create block diagonal
bdiag <- function(x){
	if(!is.list(x)) stop("x not a list")
	n <- length(x)
	if(n==0) return(NULL)
	x <- lapply(x, function(y) if(length(y)) as.matrix(y) else
	stop("Zero-length component in x"))
	d <- array(unlist(lapply(x, dim)), c(2, n))
	rr <- d[1,]
	cc <- d[2,]
	rsum <- sum(rr)
	csum <- sum(cc)
	out <- array(0, c(rsum, csum))
	ind <- array(0, c(4, n))
	rcum <- cumsum(rr)
	ccum <- cumsum(cc)
	ind[1,-1] <- rcum[-n]
	ind[2,] <- rcum
	ind[3,-1] <- ccum[-n]
	ind[4,] <- ccum
	imat <- array(1:(rsum * csum), c(rsum, csum))
	iuse <- apply(ind, 2, function(y, imat) imat[(y[1]+1):y[2],
	                                           (y[3]+1):y[4]], imat=imat)
	iuse <- as.vector(unlist(iuse))
	out[iuse] <- unlist(x)
	return(out)
}

feval_KEEp <- function(z, V1, Y, Z, h, id){
    
    obs = lapply(split(id, id), "length")
    nobs = as.numeric(obs)
    nsub = length(nobs)
    
    loc1 = 0
    loc2 = 0 
    
    bun1 <- matrix(0,2,2)
    bun2 <- matrix(0,2,1)       
 	
 	X <- cbind(rep(1, length(Z)), (Z - z))
    weights <- kd(z, h, Z)^ 0.5
     
    for(i in 1: nsub){
        loc1 = loc2 +1
        loc2 = loc1 + nobs[i] - 1 
        Gbun <- X[loc1:loc2, ,drop=FALSE]
        bun1_delta <- t(Gbun) %*% weights[loc1:loc2, loc1:loc2] %*% V1[loc1:loc2, loc1:loc2] %*% weights[loc1:loc2, loc1:loc2] %*% Gbun
        bun2_delta <- t(Gbun) %*% weights[loc1:loc2, loc1:loc2] %*% V1[loc1:loc2, loc1:loc2] %*% weights[loc1:loc2, loc1:loc2] %*% as.matrix(Y[loc1:loc2])
        bun1 <- bun1 + bun1_delta
        bun2 <- bun2 + bun2_delta
    }
      
    return(ginv(bun1)%*% bun2)
  
}

killoffdiag <- function(m){
    m[row(m)!=col(m)] <- 0
    m
} 

# Z function
z.fun <- function(x, y, id, weights, V1){
    function(beta){
        obs = lapply(split(id, id), "length")
        nobs = as.numeric(obs)
        nsub = length(nobs)
        loc1 = 0
        loc2 = 0 
        cun <- matrix(0,2,1)
        for(i in 1: nsub){
            loc1 = loc2 +1
            loc2 = loc1 + nobs[i] - 1 
            Gfun <- x[loc1:loc2, , drop =FALSE]
            xbeta <-  x[loc1:loc2, , drop=FALSE] %*% beta
            cun_delta <- t(Gfun) %*% weights[loc1:loc2, loc1:loc2] %*% V1[loc1:loc2, loc1:loc2] %*% weights[loc1:loc2, loc1:loc2] %*% as.matrix(y[loc1:loc2] - mu(xbeta))
            cun <- cun + cun_delta
        }
        return(cun)
    }
}


zest <- function(x ,y, betastart, weights, id, V1, ...){
    y <- c(y)
    betastart <- c(betastart)
    n <- length(unique(id))
    beta <- betastart
    tol <- 0.00000001
    objective <- function(beta){
      Z.final <- z.fun(x, y, id, weights, V1)(beta)
      t(Z.final) %*% Z.final
    }

    beta <- optim(betastart, objective)[[1]]
    return(list(beta=beta))
}

lpoly <- function(x, y, h, xgrid, id, V1, ...){
    x<-c(x)
    y<-c(y)
    h<-c(h)
    xgrid<-c(xgrid)
    id <- c(id)
    n <- length(unique(id))
    m <- length(xgrid)
    if (length(h) == 1){
      h <- rep(h, m)
    }
    f <- rep(0, m)
    var <- f
    betastart <- c(1,1)
    for (i in 1:m){
        n <- length(x)
        X <- cbind(rep(1,n), (x - xgrid[i]))
        xccm <- kd(xgrid[i], h[i], x)^ 0.5
        betastart <- feval_KEEp(xgrid[i], V1, y, x, h[i], id)
        out <- zest(X, y, betastart, xccm,  id, V1)
        beta <- out$beta      
        f[i] <- beta[1]
        betastart <- beta
    }
    
    return(list(f=f))
}

kgee <- function(x, y, h, xgrid, id, V1){
    lpoly(x, y, h, xgrid, id, V1)
}
