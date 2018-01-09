# include <time.h>
# include <math.h>
# include <stdio.h>

__global__ void add( int *a , int *b , int *c)
{
	clock_t start_time = clock(); 
	c[blockIdx.x] = a[blockIdx.x] +b[blockIdx.x];
	/*cudaThreadSynchronize(); */
	clock_t stop_time = clock();
	printf("time=%d\n", (stop_time - start_time) );
}

# define N 5

void random_ints(int* a, int h)
{

}

int main(void){
	int a[N],b[N],c[N];
	int *d_a,*d_b,*d_c;

	int size = N * sizeof(int);
	
	cudaMalloc((void **)&d_a, size);
	cudaMalloc((void **)&d_b, size);
	cudaMalloc((void **)&d_c, size);
	for ( int i=0;i<=N;i++)
  		{
    		a[i]=i+2;
    		b[i]=i+3;
   		c[i]=0;
  		}

	
	
	printf("a=%d\n",a);
	
	cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_c, c, size, cudaMemcpyHostToDevice);

	add<<<N,1>>>(d_a, d_b, d_c);

	cudaMemcpy(c,d_c,size,cudaMemcpyDeviceToHost);
	printf("sum=%d\n",c);

	free(a); free(b); free(c);
	cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
	return 0;
}
