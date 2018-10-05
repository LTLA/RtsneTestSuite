# Test suite for comparing _Rtsne_ to _bhtsne_

This provides a test suite to compare the refactored C++ code in [_Rtsne_](https://github.com/jkrijthe/Rtsne) with the original implementation in [_bhtsne_](https://github.com/lvdmaaten/bhtsne).
If on Linux or OSX, simply clone this repository and run `make` to prepare the executables.
Then, open an R session and run `source("testthat.R")` to execute the tests.

The design of the tests are based on trial and error and bitter experience, with the following notes:

- To avoid differences due to the random number generator, we use a pre-initialized coordinate matrix in both implementations.
This requires a hack to `tsne.cpp` in _bhtsne_ so that it can accept a initial coordinate matrix, see the `Makefile` for details.
- Data and results are saved to and read from binary format directly when calling the _bhtsne_ implementation.
This avoids going through a text intermediate (necessary to use the Python wrapper), which may result in loss of precision and differences between implementations.
- The nearest neighbor search in both implementations is exact but involves a randomization procedure that may change the order of neighbours with tied distances.
This can either change the identity of the `K` nearest neighbors, or change the order of addition of floating point numbers (which then leads to issues with numerical precision).
To avoid this, the input matrix should not contain any pairs of samples with tied distances.
- The behaviour of summation is not consistent in calls to and inside `computeNonEdgeForces`.
This requires some modification to (i) create per-sample elements in each loop iteration prior to addition to a sum variable in `tsne.cpp`,
and (ii) avoid summation within recursion in `sptree.cpp`.
- The switches to stop lying and to alter momentum occur after `Y` updates in _bhtsne_ but before it updates in _Rtsne_.
This effectively requires an increment to the iterations at which these switches occur in _Rtsne_ to yield consistent results, see `setup.R`.
- _Rtsne_ uses BLAS to compute a distance matrix when `theta=0` (i.e., for the exact algorithm), while _bhtsne_ does its own thing.
This results in small round-off errors that are amplified. 
It was too much work to try to synchronise these two, so all exact tests should use few iterations for their comparisons.
