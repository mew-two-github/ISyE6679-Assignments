#include<stdio.h>
#include<stdlib.h>

// function to generate random numbers from [0,m]
float gen_random( int m )
{
	float val;
	val = (float)rand()/(float)(RAND_MAX/m);
    val = (int)( val*1000); 
	val = val/1000 ;
	return(val);
}

int main(int argc, char *argv[])
{

	// Typecasting inputs to integers
	int *args = (int*) malloc((argc - 1)*sizeof(int));
	for(int i = 1; i < argc; i++)
	{
		char *a = argv[i];
		args[i-1] = atoi(a);
	}

	
	int N = (argc-1)/3;
	for(int count = 0; count < N; count += 1)
	{
		
		// Generation of matrices
		int r = args[count*3], c = args[count*3 + 1], m = args[count*3 + 2];
		float *a = (float*) malloc(r*c*sizeof(float));
		float *b = (float*) malloc(r*c*sizeof(float));;
		srand(5);
		for(int i = 0; i < r*c; i++)
		{
			a[i] = gen_random(m);
			b[i] = gen_random(m);
		}
		
		// Multiplication 
		float *res = (float*) malloc((r*r)*sizeof(float));
		for( int i = 0; i < r; i++ )
		{
			for(int j = 0; j < r; j++)
			{
				float val = 0;
				for(int k = 0; k < c; k++)
				{
					// number of items in a row = number of columns, so i,j can also be accessed as i*number of columns + j
					val = val + a[i*c + k]*b[k*r + j];
				}
				res[i*r + j] = val;
				// printf("%f     ", val);
			}
			// if(count + 1 != N || i + 1 !=r ) // Taking care to avoid printing an extra blank line
		    // 	printf("\n");
		}

		// Printing the resulting matrix
		for( int i = 0; i < r; i++ )
		{
		    for(int j = 0; j < r; j++)
		    {
		         printf("%f     ", res[i*r + j]);
		    }
		    if(count + 1 != N || i + 1 !=r ) // Taking care to avoid printing an extra blank line
		    	printf("\n");
		}
		//if(count + 1 != N)	// Taking care to avoid printing an extra blank line
		printf("\n");

		free(a);
		free(b);
		free(res);
	}
	free(args);
	return 0;
}