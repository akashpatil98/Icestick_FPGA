#include <femtorv32.h>

int main()
{
	while(1)
	{
		printf("Hello, world!\r\n");
		*(volatile uint32_t*)(0x400004) = 3;
		delay(500);
		*(volatile uint32_t*)(0x400004) = 0;
		delay(500);
	}
	return 0;
}
