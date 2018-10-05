INITIALIZE <- function(nsamples, dims=2) {
    rnorm(nsamples*dims) * 0.0001
}

library(Rtsne)
TESTFUN <- function(data, init, perplexity=30, theta=0.5, max_iter=500, dims=2) {
    Y_in <- matrix(init, nrow(data), ncol=dims, byrow=TRUE)
    out <- Rtsne(data, perplexity=perplexity, theta=theta, Y_init=Y_in, 
        dims=dims, max_iter=max_iter, pca=FALSE, stop_lying_iter=251L, mom_switch_iter=251L)
    out$Y    
}

REFFUN <- function(data, init, perplexity=30, theta=0.5, max_iter=500, dims=2) {
    infile <- "data.dat"
    con <- file(infile, open="wb")
    writeBin(nrow(data), con=con)
    writeBin(ncol(data), con=con)
    writeBin(as.numeric(theta), con=con)
    writeBin(as.numeric(perplexity), con=con)
    writeBin(as.integer(dims), con=con)
    writeBin(as.integer(max_iter), con=con)
    writeBin(as.numeric(t(data)), con=con)
    close(con)

    writeBin(con="init.dat", object=init)

    system2("../bhtsne/bh_tsne", stdout=FALSE)

    outfile <- "result.dat"
    con <- file(outfile, open="rb")
    n <- readBin(con=con, what="integer", 1)
    d <- readBin(con=con, what="integer", 1)
    out <- readBin(con=con, "numeric", dims*nrow(data))
    close(con)
    matrix(out, ncol=dims, byrow=TRUE)
}

