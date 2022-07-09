#include <femtorv32.h>

int main()
{
	while(1)
	{
		for (int i = 0; i < 4096; i++)
		{
			*(volatile uint32_t*)(0x404000) = i;
			/* 0x400000 + (1 < (2 + 12)) = 0x404000.
			 This is how we got the above value.
			*/
			
			delay (1);	
	        }
	}
	return 0;
}
