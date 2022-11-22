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
    b dw 5
    c dd 8
    d dq 15

; our code starts here
segment code use32 class=code
    start:
        ; d-a+c+c-b+a
        ; a - byte, b - word, c - double word, d - qword - Signed representation
        
        mov AL, [a]
        cbw
        cwde
        cdq ; EDX: EAX = a
        
        mov ECX, [d]
        mov EBX, [d+4]
        
        sub ECX, EAX
        sbb EBX, EDX ; EBX: ECX = d - a 
        
        mov EAX, [c]
        cdq
        
        add ECX, EAX
        adc EBX, EDX ; EBX: ECX = d - a + c
        
        add ECX, EAX
        adc EBX, EDX ; EBX: ECX = d - a + c + c
        
        mov AX, [b]
        cwde
        cdq
        
        sub ECX, EAX
        sbb EBX, EDX ; EBX: ECX = d - a + c + c - b
        
        mov AL, [a]
        cbw
        cwde
        cdq ; EDX: EAX = a 
        
        add ECX, EAX
        adc EBX, EDX ; EBX: ECX = d - a + c + c - b + a
        
       
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
