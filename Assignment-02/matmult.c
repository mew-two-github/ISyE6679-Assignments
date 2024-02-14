#include<stdio.h>
#include<stdlib.h>
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
	
	/*int r = (int)argv[0], c = (int)argv[1], m = (int)argv[2];

	printf("%f %f %f     ", r,c,m);
	// float res[r][r];
	// Generation of matrices
	
	float *a = (float *)malloc(r * c * sizeof(float));*/
	int *args = (int*) malloc((argc - 1)*sizeof(int));
	//printf("%d \n", argc);
	for(int i = 1; i < argc; i++)
	{
		char *a = argv[i];
		args[i-1] = atoi(a);
		free(a);
		// printf("%d \t", args[i-1]);
	}
	// printf("\nv1 + vn = %d ", args[0] + args[argc-2] );
	int N = (argc-1)/3;
	for(int count = 0; count < N; count += 1)
	{
		// printf("\nArgument %d \n\n", count);
		int r = args[count*3], c = args[count*3 + 1], m = args[count*3 + 2];
		// printf("%d %d %d     \n", r,c,m);
		float *a = (float*) malloc(r*c*sizeof(float));
		float *b = (float*) malloc(r*c*sizeof(float));;
		srand(5);
		for(int i = 0; i < r*c; i++)
		{
			a[i] = gen_random(m);
			b[i] = gen_random(m);
		}
		
		// Multiplication 
		float *res = (float*) malloc((argc - 1)*sizeof(float));
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
			}
			
		}

		// for( int i = 0; i < r; i++ )
		// {
		//     for(int j = 0; j < c; j++)
		//     {
		//          printf("%f     ", a[i*c + j]);
		//     }
		//     printf("\n");
		// }
		// printf("\n");
		// for( int i = 0; i < c; i++ )
		// {
		//     for(int j = 0; j < r; j++)
		//     {
		//          printf("%f     ", b[i*r + j]);
		//     }
		//     printf("\n");
		// }

		// printf("\n");
		for( int i = 0; i < r; i++ )
		{
		    for(int j = 0; j < r; j++)
		    {
		         printf("%f     ", res[i*r + j]);
		    }
		    if(count + 1 != N || i + 1 !=r )
		    	printf("\n");
		}
		if(count + 1 != N)
			printf("\n");

		free(a);
		free(b);
		free(res);
	}
	free(args);
	return 0;
}