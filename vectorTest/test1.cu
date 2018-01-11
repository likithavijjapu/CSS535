# include <time.h>
# include <math.h>
# include <stdio.h>

__global__ void add( int *a , int *b , int *c)
{
	
	c[blockIdx.x] = a[blockIdx.x] +b[blockIdx.x];
	
}

//# define N 125

void random_ints(int* a, int h)
{

}

int main(void){
	int N;
	printf("\"Hello Vector !\"\n enter size of vector\n");
	scanf("%d",&N);
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

	
	
	
	cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_c, c, size, cudaMemcpyHostToDevice);
	clock_t start_time = clock(); 
	add<<<N,1>>>(d_a, d_b, d_c);
	cudaThreadSynchronize(); 
	clock_t stop_time = clock();
	int time =stop_time - start_time;
	printf("time=%d\n", time);

	cudaMemcpy(c,d_c,size,cudaMemcpyDeviceToHost);
	printf("c=");
	for(int i=0;i<N;i++){
	
	printf("%d+",c[i]);}
	printf("\n");

	
	cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
	return 0;
}
