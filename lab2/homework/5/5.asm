bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 4
    e dw 14
    h dw 5

; our code starts here
segment code use32 class=code
    start:
        ; 100/(e+h-3*a)
        ; a - byte
        ; e, h - word
        
        mov BX, [e]
        add BX, [h] ; BX = e + h
        
        mov AL, 3
        mul byte [a] ; AX = 3 * a
        
        sub BX, AX ; BX = e + h - 3 * a 
        
        mov AX, 100
        mov DX, 0 ; DX:AX = 100
        
        div BX ; AX = 100 / (e + h - 3 * a)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
