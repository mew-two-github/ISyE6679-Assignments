#include <stdio.h>
#include "support.h"
#include "kernel.cu"

int main(int argc, char**argv) {

    Timer timer;
    cudaError_t cuda_ret;

    // Initialize host variables ----------------------------------------------

    printf("\nSetting up the problem..."); fflush(stdout);
    startTime(&timer);

    unsigned int n;
    if(argc == 1) {
        n = 10000;
    } else if(argc == 2) {
        n = atoi(argv[1]);
    } else {
        printf("\n    Invalid input parameters!"
           "\n    Usage: ./vecadd               # Vector of size 10,000 is used"
           "\n    Usage: ./vecadd <m>           # Vector of size m is used"
           "\n");
        exit(0);
    }

    float* A_h = (float*) malloc( sizeof(float)*n );
    for (unsigned int i=0; i < n; i++) { A_h[i] = (rand()%100)/100.00; }

    float* B_h = (float*) malloc( sizeof(float)*n );
    for (unsigned int i=0; i < n; i++) { B_h[i] = (rand()%100)/100.00; }

    float* C_h = (float*) malloc( sizeof(float)*n );

    stopTime(&timer); printf("%f s\n", elapsedTime(timer));
    printf("    Vector size = %u\n", n);

    // Allocate device variables ----------------------------------------------

    printf("Allocating device variables..."); fflush(stdout);
    startTime(&timer);

    float* A_d;
    cuda_ret = cudaMalloc((void**) &A_d, sizeof(float)*n);
	if(cuda_ret != cudaSuccess) FATAL("Unable to allocate device memory");

    //INSERT CODE HERE for B and C
    ...
    ...
    ...

    ...
    ...
    ...

    cudaDeviceSynchronize();
    stopTime(&timer); printf("%f s\n", elapsedTime(timer));

    // Copy host variables to device ------------------------------------------

    printf("Copying data from host to device..."); fflush(stdout);
    startTime(&timer);

    cuda_ret = cudaMemcpy(A_d, A_h, sizeof(float)*n, cudaMemcpyHostToDevice);
	if(cuda_ret != cudaSuccess) FATAL("Unable to copy memory to device");

    //INSERT CODE HERE for B
    ...
    ...

    cudaDeviceSynchronize();
    stopTime(&timer); printf("%f s\n", elapsedTime(timer));

    // Launch kernel ----------------------------------------------------------

    printf("Launching kernel..."); fflush(stdout);
    startTime(&timer);

    const unsigned int THREADS_PER_BLOCK = 512;
    const unsigned int numBlocks = (n - 1)/THREADS_PER_BLOCK + 1;
    dim3 gridDim(numBlocks, 1, 1), blockDim(THREADS_PER_BLOCK, 1, 1);
    //INSERT CODE HERE to call kernel
    ...

    cuda_ret = cudaDeviceSynchronize();
	if(cuda_ret != cudaSuccess) FATAL("Unable to launch kernel");
    stopTime(&timer); printf("%f s\n", elapsedTime(timer));

    // Copy device variables from host ----------------------------------------

    printf("Copying data from device to host..."); fflush(stdout);
    startTime(&timer);

    //INSERT CODE HERE to copy C
    ...
    ...

    cudaDeviceSynchronize();
    stopTime(&timer); printf("%f s\n", elapsedTime(timer));

    // Verify correctness -----------------------------------------------------

    printf("Verifying results..."); fflush(stdout);

    verify(A_h, B_h, C_h, n);

    // Free memory ------------------------------------------------------------

    free(A_h);
    free(B_h);
    free(C_h);

    //INSERT CODE HERE to free device matrices
    ...
    ...
    ...

    return 0;

}

