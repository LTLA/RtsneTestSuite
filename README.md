# Test suite for comparing _Rtsne_ to _bhtsne_

This provides a test suite to compare the refactored C++ code in [_Rtsne_](https://github.com/jkrijthe/Rtsne) with the original implementation in [_bhtsne_](https://github.com/lvdmaaten/bhtsne).
If on Linux or OSX, simply clone this repository and run `make` to prepare the executables.
Then, open an R session and run `source("testthat.R")` to execute the tests.
Note that this calls _bhtsne_ through the Python wrapper.

The design of the tests are based on trial and error and bitter experience, with the following notes:

- To avoid differences due to the random number generator, we use a pre-initialized coordinate matrix in both implementations.
This requires a hack to `tsne.cpp` in _bhtsne_ so that it can accept a initial coordinate matrix, see the `Makefile` for details.
- The nearest neighbor search in both implementations is exact but involves a randomization procedure that may change the order of neighbours with tied distances.
This can either change the identity of the `K` nearest neighbors, or change the order of addition of floating point numbers (which then leads to issues with numerical precision).
To avoid this, the input matrix should not contain any pairs of samples with tied distances.
- There is a difference between implementations in the 16th decimal place in the first calculation of `uY`, seemingly caused by with the `eta` multiplication.
This amplifies across iterations and causes the final results to be highly divergent.
Thus, we only test a limited number of iterations in these simulations.

The last point means that we are never able to test the stage where the algorithm stops lying about the probabilities, or when the momentum switch occurs.

