#include <stdio.h>
#include <assert.h>

//CUDA Runtime
#include <cuda_runtime.h>

//Helper function
#include <helper_functions.h>
#include <helper_cuda.h>

#include "cuPrintf.cu"

__global__ void printThreadID(void)
{
	int BlockID = blockIdx.x;
	int ThreadID = threadIdx.x;
	printf("Block id x : %d, Thread id x : %d\n", BlockID, ThreadID);

}

int main(int argc, char **argv)
{

	int DevID = findCudaDevice(argc, (const char**)argv);
	cudaDeviceProp props;

	cudaGetDevice(&DevID);
	cudaGetDeviceProperties(&props, DevID);

	dim3 grid(3, 1, 1);     //Block size, SM size
	dim3 threads(10, 1, 1); //Thread size, SP size, cuda core size

	printThreadID<<<grid, threads>>>();
	cudaDeviceSynchronize();

	cudaDeviceReset();

	getchar();
	return EXIT_SUCCESS;
}

