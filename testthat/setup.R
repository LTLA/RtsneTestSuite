WRITEDATA <- function(data, fname=NULL) {
    if (is.null(fname)) fname <- tempfile()
    write.table(data, file=fname, sep="\t", quote=FALSE, row.names=FALSE, col.names=FALSE)
    return(fname)
}

library(Rtsne)
TESTFUN <- function(fname, perplexity=30, theta=0.5, max_iter=10, dims=2) {
    incoming <- read.table(fname, header=FALSE)
    out <- Rtsne(as.matrix(incoming), perplexity=perplexity, theta=theta,
        Y_init=matrix(seq_len(nrow(incoming) * dims) - 1L, nrow(incoming), ncol=dims, byrow=TRUE) * 0.0001, 
        dims=dims, 
        max_iter=max_iter, pca=FALSE,
        stop_lying_iter=250L, mom_switch_iter=250L)
    out$Y    
}

REFFUN <- function(fname, perplexity=30, theta=0.5, max_iter=10, dims=2) 
# Implements the reference function.
{
    outfile <- tempfile()
    system2("../bhtsne/bhtsne.py", args=c(paste("-p", perplexity),
        paste("-t", theta), paste("-m", max_iter), paste("-d", dims),
        "--no_pca", paste("-i", fname), paste("-o", outfile)))
    out <- as.matrix(read.table(outfile))
    dimnames(out) <- NULL
    out
}

