# include <time.h>
# include <math.h>
# include <stdio.h>

__global__ void add( int *a , int *b , int *c)
{
	int index= threadIdx.x + blockIdx.x * blockDim.x;
	c[index] = a[index] +b[index];
	
}

//# define N 125
#define thread_count 10

void random_ints(int* a, int h)
{

}

int main(void){
	int N;
	printf("\"Hello Vector !\"\n enter size of vector\n");
	scanf("%d",&N);
	int a[N],b[N],c[N];  // host copies of a, b,c
	int *d_a,*d_b,*d_c;  //// device copies of a, b, c

	int size = N * sizeof(int);
	// Alloc space for device copies of a, b, c
	cudaMalloc((void **)&d_a, size);
	cudaMalloc((void **)&d_b, size);
	cudaMalloc((void **)&d_c, size);
	//setup input values for a, b, c  
	for ( int i=0;i<=N;i++)
  		{
    		a[i]=i+2;
    		b[i]=i+3;
   		c[i]=0;
  		}

	
	// Copy inputs to device
	cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_c, c, size, cudaMemcpyHostToDevice);
	// start clocking
	clock_t start_time = clock(); 
	//Launch add() kernel on GPU
	add<<<N,thread_count>>>(d_a, d_b, d_c);
	cudaThreadSynchronize(); 
	//end clocking and measuring time for execution
	clock_t stop_time = clock();
	int time =stop_time - start_time;
	printf("time=%d\n", time);
	//Copy result back to host
	cudaMemcpy(c,d_c,size,cudaMemcpyDeviceToHost);
	printf("c=");
	for(int i=0;i<N;i++){
	
	printf("%d+",c[i]);}
	printf("\n");

	// Cleanup
	cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
	return 0;
}
