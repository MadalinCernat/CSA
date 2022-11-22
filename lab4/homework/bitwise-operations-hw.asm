bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
     a dw 0111011101010111b
     b dd 0
         ; 0101101111110000 0000111011100011

; our code starts here
segment code use32 class=code
    start:
        ; Given the word A,obtain the doubleword B as follows:

            
        mov BX, 0 ;we compute the result in CX:BX
        mov CX, 0
        
        ;the bits 0-3 of B are the same as the bits 1-4 of the result A XOR 0Ah
        mov AX, [a]
        xor AX, 0Ah ; A XOR 0Ah
        mov CL, 1
        ror AX, CL ;rotate 1 position to right
        or BX, AX ;put the bits into the result
        
        ;the bits 4-11 of B are the same as the bits 7-14 of A
        mov AX, [a]
        and AX, 0111111110000000b ;isolate bits 7-14 of A
        mov CL, 3
        ror AX, CL ;rotate 3 positions to right
        or BX, AX ;put the bits into the result
        
        ;the bits 12-19 of B have the value 0
        and BX, 0000111111111111b ;force bits 12-15 to the value 0
        and CX, 1111111111110000b ;force bits 16-19 to the value 0
        
        ;the bits 20-25 of B have the value 1
        or CX, 0000001111110000b ;force bits 20-25 to value 1
        
        ;the bits 26-31 of B are the same as the bits 3-8 of A complemented
        mov AX, [a]
        not AX
        add AX, 1
        and AX, 0000000111111000b;isolate bits 3-8 of A
        mov CL, 7
        rol AX, CL ;rotate 7 positions to left
        or CX, AX ;put the bits into the result
        
        ;move the result from the register to the result variable  
        mov [b], CX
        mov [b+2], BX
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
