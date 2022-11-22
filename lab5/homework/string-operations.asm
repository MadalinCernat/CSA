bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s1 db 1, 3, 6, 2, 3, 2
    ls1 equ $-s1
    s2 db 6, 3, 8, 1, 2, 5
    ls2 equ $-s2
    d times ls1 db 0
; our code starts here
segment code use32 class=code
    start:
        ; Two byte strings S1 and S2 of the same length are given. Obtain the string D where each element is the sum of the corresponding elements from S1 and S2
        ;S1: 1, 3, 6, 2, 3, 2
        ;S2: 6, 3, 8, 1, 2, 5
        ;D: 7, 6, 14, 3, 5, 7
        mov ECX, ls1
        mov ESI, 0
        jecxz Sfarsit
        Repeta:
                mov AL, [s1+ESI]
                add AL, [s2+ESI] ; add the numbers on the same position
                mov [d+ESI], AL ; move the result to the new string
                inc ESI
        loop Repeta
        Sfarsit:

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
