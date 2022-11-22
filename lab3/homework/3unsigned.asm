bits 32 ; assembling for the 32 bits architecture
; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 10
    b db 5
    c db 5
    e dd 20
    x dq 15

; our code starts here
segment code use32 class=code
    start:
        ; a*b-(100-c)/(b*b)+e+x; a-word; b,c-byte; e-doubleword; x-qword
        mov AL, [b]
        mov AH, 0
        mov BX, [a]
        mul BX ; DX:AX = a * b
        push DX
        push AX
        mov AL, 100
        sub AL, [c] ; AL = 100 - c
        mov AH, 0 ; AX = 100 - c
        mov DX, 0 ; DX:AX = 100 - c
        mov CX, DX
        mov BX, AX ; CX:BX = 100 - c
        mov AL, [b]
        mul byte [b] ; AX = b * b
        push AX
        mov DX, CX
        mov AX, BX ; DX:AX = 100 - c
        pop BX
        div BX ; AX = (100-c) / (b*b)
        mov DX, 0
        pop EBX ; EBX = a * b
        push DX
        push AX
        pop EAX ; EAX = (100-c) / (b*b)
        sub EBX, EAX ; EBX = a * b - (100-c) / (b*b)
        add EBX, [e]
        mov EAX, EBX
        mov EDX, 0
        add EAX, [x]
        adc EDX, [x+4]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
