; Aarons version of exec via stack
; calling execve with the stack has variables
;  *filename=/bin/sh+0x0, *argv=/bin/sh+0 *envp =0

global _start

section .text

_start:
	xor eax,eax
	push eax
	
	push 0x68732f2f
	push 0x6e69622f
	mov ebx,esp

	push eax
	mov edx,esp
	
	push ebx
	mov ecx, esp

	;push eax
	;mov edx,esp

	mov al, 0xb
	int 0x80

	
section .data
