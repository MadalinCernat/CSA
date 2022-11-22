bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 10
    b dw 15
    c dd 20
    d dq 11

; our code starts here
segment code use32 class=code
    start:
        ; (b+c+a)-(d+c+a)
        ; a - byte, b - word, c - double word, d - qword - Unsigned representation
    
        mov AL, [a]
        mov AH, 0 ; AX = a
        
        mov BX, [b]
        add AX, BX ; AX = b + a
        
        mov DX, 0
        push DX
        push AX
        pop EAX ; EAX = b + a
        
        add EAX, [c] ; EAX = b + c + a
        mov EBX, EAX
        
        mov AL, [a]
        mov AH, 0 ; AX = a
        
        mov DX, 0
        push DX
        push AX
        pop EAX
        
        add EAX, [c]
        mov EDX, 0
        
        add EAX, [d]
        adc EDX, [d+4]
        
        mov ECX, 0
        
        sub EBX, EAX
        sbb ECX, EDX
        
        
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
