// One block one thread cuda kernel that basically
// runs a single thread such that the kernel must be
// just a loop over all arrays and such algorithm does
// not take advantage of cuda kernels


#include <stdio.h>
#include <stdlib.h>


__global__ void add(int size, double* array, double* other, double* total) {
    for (int k = 0; k < size; ++k) {
        total[k] = array[k] + other[k];
    }
}


double difference(int size, double *total, double expected) {
    double maximum_difference = 0;
    for (int i = 0; i < size; ++i) {
        double expected_result = 3.0;
        double difference = abs(expected_result - total[i]);
        if (difference > maximum_difference) {
            maximum_difference = difference;
        }
    }

    return maximum_difference;
}


int main() {
    int size = 1 << 20;

    double *array = (double*) malloc(sizeof(double) * size);
    double *other = (double*) malloc(sizeof(double) * size);
    double *total = (double*) malloc(sizeof(double) * size);

    for (int i = 0; i < size; ++i) {
        array[i] = 1.0;
        other[i] = 2.0;
    }
    
    double *cuda_array;
    double *cuda_other;
    double *cuda_total;

    cudaMalloc(&cuda_array, size * sizeof(double));
    cudaMalloc(&cuda_other, size * sizeof(double));
    cudaMalloc(&cuda_total, size * sizeof(double));

    cudaMemcpy(cuda_array, array, size * sizeof(double), cudaMemcpyHostToDevice);
    cudaMemcpy(cuda_other, other, size * sizeof(double), cudaMemcpyHostToDevice);
    cudaMemcpy(cuda_total, total, size * sizeof(double), cudaMemcpyHostToDevice);

    add<<<1, 1>>>(size, cuda_array, cuda_other, cuda_total);

    cudaMemcpy(total, cuda_total, size * sizeof(double), cudaMemcpyDeviceToHost);

    double maximum_difference = difference(size, total, 3);

    printf("Maximum difference is %f\n", maximum_difference);

    free(array);
    free(other);
    free(total);

    return 0;
}
