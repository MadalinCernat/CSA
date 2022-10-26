bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 15
    b db 4
    c db 3
    d dw 6

; our code starts here
segment code use32 class=code
    start:
        ; [(a-b)*5+d]-2*c (a,b,c - byte, d - word)
        mov AL, [a]
        sub AL, [b] ; AL = a - b
        mov AH, 5
        mul AH ; AX = (a-b) * 5
        
        add AX, [d] ; AX = (a-b) * 5 + d
        mov BX, AX ; BX = AX
        
        mov CL, [c]
        mov AL, 2
        mul CL ; AX = CL * AL = 2 * c
        
        sub BX, AX ; BX = [(a-b) * 5 + d] - 2 * c
       
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
