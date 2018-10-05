# This tests the consistency of Rtsne and bhtsne on simulated data.
# library(testthat); source("setup.R"); source("test-simulated.R")

set.seed(1000)
test_that("Rtsne matches up with bhtsne on simulated data", {
    Y <- matrix(rnorm(1000), ncol=10)
    init <- INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(Y, init)
    ref <- REFFUN(Y, init)
    expect_equal(out, ref)
    
    Y <- matrix(runif(123*2), ncol=2)
    init <- INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(Y, init)
    ref <- REFFUN(Y, init)
    expect_equal(out, ref)

    Y <- matrix(runif(1333*3), ncol=3)
    init <- INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(Y, init)
    ref <- REFFUN(Y, init)
    expect_equal(out, ref)
})

set.seed(1001)
test_that("Rtsne matches up with bhtsne with different perplexity values", {
    Y <- matrix(rnorm(1000), ncol=10)
    init <- INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(Y, init, perplexity=10)
    ref <- REFFUN(Y, init, perplexity=10)
    expect_equal(out, ref)
    
    Y <- matrix(runif(1000), ncol=10)
    init <- INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(Y, init, perplexity=20)
    ref <- REFFUN(Y, init, perplexity=20)
    expect_equal(out, ref)

    Y <- matrix(runif(2000), ncol=10) # more samples to avoid error.
    init <- INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(Y, init, perplexity=50)
    ref <- REFFUN(Y, init, perplexity=50)
    expect_equal(out, ref)
})
   
set.seed(1002)
test_that("Rtsne matches up with bhtsne with different theta values", {
    Y <- matrix(rnorm(1000), ncol=10)
    init <- INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(Y, init, theta=0, max_iter=10)
    ref <- REFFUN(Y, init, theta=0, max_iter=10)
    expect_equal(out, ref)
    
    Y <- matrix(runif(1000), ncol=10)
    init <- INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(Y, init, theta=0.25)
    ref <- REFFUN(Y, init, theta=0.25)
    expect_equal(out, ref)

    Y <- matrix(runif(1000), ncol=10)
    init <- INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(Y, init, theta=0.75)
    ref <- REFFUN(Y, init, theta=0.75)
    expect_equal(out, ref)
})
   
set.seed(1003)
test_that("Rtsne matches up with bhtsne with different max iterations", {
    Y <- matrix(rnorm(1000), ncol=10)
    init <- INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(Y, init, max_iter=10)
    ref <- REFFUN(Y, init, max_iter=10)
    expect_equal(out, ref)
    
    Y <- matrix(runif(1000), ncol=10)
    init <- INITIALIZE(nrow(Y), 2)
    out <- TESTFUN(Y, init, max_iter=1000)
    ref <- REFFUN(Y, init, max_iter=1000)
    expect_equal(out, ref)
})

set.seed(1004)
test_that("Rtsne matches up with bhtsne with different numbers of output dimensions", {
    Y <- matrix(rnorm(1000), ncol=10)
    init <- INITIALIZE(nrow(Y), 3)
    out <- TESTFUN(Y, init, dims=3)
    ref <- REFFUN(Y, init, dims=3)
    expect_equal(out, ref)
    
    Y <- matrix(runif(1000), ncol=10)
    init <- INITIALIZE(nrow(Y), 1)
    out <- TESTFUN(Y, init, dims=1)
    ref <- REFFUN(Y, init, dims=1)
    expect_equal(out, ref)
})
