# This tests the consistency of Rtsne and bhtsne on simulated data.
# library(testthat); source("setup.R"); source("test-simulated.R")

set.seed(1000)
test_that("Rtsne matches up with bhtsne on simulated data", {
    Y <- matrix(rnorm(1000), ncol=10)
    fname <- WRITEDATA(Y)
    INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(fname)
    ref <- REFFUN(fname)
    expect_equal(out, ref)
    
    Y <- matrix(runif(123*2), ncol=2)
    fname <- WRITEDATA(Y)
    INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(fname)
    ref <- REFFUN(fname)
    expect_equal(out, ref)

    Y <- matrix(runif(1333*3), ncol=3)
    fname <- WRITEDATA(Y)
    INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(fname)
    ref <- REFFUN(fname)
    expect_equal(out, ref)
})

set.seed(1001)
test_that("Rtsne matches up with bhtsne with different perplexity values", {
    Y <- matrix(rnorm(1000), ncol=10)
    fname <- WRITEDATA(Y)
    INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(fname, perplexity=10)
    ref <- REFFUN(fname, perplexity=10)
    expect_equal(out, ref)
    
    Y <- matrix(runif(1000), ncol=10)
    fname <- WRITEDATA(Y)
    INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(fname, perplexity=20)
    ref <- REFFUN(fname, perplexity=20)
    expect_equal(out, ref)

    Y <- matrix(runif(2000), ncol=10) # more samples to avoid error.
    fname <- WRITEDATA(Y)
    INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(fname, perplexity=50)
    ref <- REFFUN(fname, perplexity=50)
    expect_equal(out, ref)
})
   
set.seed(1002)
test_that("Rtsne matches up with bhtsne with different theta values", {
    Y <- matrix(rnorm(1000), ncol=10)
    fname <- WRITEDATA(Y)
    INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(fname, theta=0)
    ref <- REFFUN(fname, theta=0)
    expect_equal(out, ref)
    
    Y <- matrix(runif(1000), ncol=10)
    fname <- WRITEDATA(Y)
    INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(fname, theta=0.25)
    ref <- REFFUN(fname, theta=0.25)
    expect_equal(out, ref)

    Y <- matrix(runif(1000), ncol=10)
    fname <- WRITEDATA(Y)
    INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(fname, theta=0.75)
    ref <- REFFUN(fname, theta=0.75)
    expect_equal(out, ref)
})
   
set.seed(1003)
test_that("Rtsne matches up with bhtsne with different max iterations", {
    Y <- matrix(rnorm(1000), ncol=10)
    fname <- WRITEDATA(Y)
    INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(fname, max_iter=5)
    ref <- REFFUN(fname, max_iter=5)
    expect_equal(out, ref)
    
    Y <- matrix(runif(1000), ncol=10)
    fname <- WRITEDATA(Y)
    INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(fname, max_iter=15)
    ref <- REFFUN(fname, max_iter=15)
    expect_equal(out, ref, tol=1e-6) # higher tolerance due to issues with numerical precision.
})

set.seed(1004)
test_that("Rtsne matches up with bhtsne with different numbers of output dimensions", {
    Y <- matrix(rnorm(1000), ncol=10)
    fname <- WRITEDATA(Y)
    INITIALIZE(nrow(Y), 3)
    out <- TESTFUN(fname, dims=3)
    ref <- REFFUN(fname, dims=3)
    expect_equal(out, ref)
    
    Y <- matrix(runif(1000), ncol=10)
    fname <- WRITEDATA(Y)
    INITIALIZE(nrow(Y), 1)
    out <- TESTFUN(fname, dims=1)
    ref <- REFFUN(fname, dims=1)
    expect_equal(out, ref)
})
