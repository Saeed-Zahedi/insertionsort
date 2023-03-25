segment .text

%include "asm_io.inc"
extern print_array
global  _asm_main


segment .data
; Write Code data here
        array: dd 12, -11, 13, 5, 6
        LEN: equ ($-array)/4
        i: dd 0
        key: dd 0
        error_text: dd "array is empty", 0


_asm_main:
        enter   0,0
        pusha

        ; Start Code
        ; Write Your Code Here  

        mov eax, 1
        cmp eax, LEN
        jg error


    loop1:
        ; i++
        inc dword [i]
        
        ;j
        mov ebx, [i]
        dec ebx
        ;dec dword [j]

        ;arr[i]
        mov eax, [array+4*(ebx+1)]

        ;key = arr[i]
        mov [key], eax
   

        ; if i > len then end
        mov eax, [i]
        inc eax
        cmp eax, LEN
        jg print


    loop2: 
        ;while j >= 0 and key < arr[j]
        cmp ebx, 0
        jl loop2_end

        mov eax, [array + 4*ebx]
        cmp eax, [key]
        jle loop2_end

        ;arr[j+1] = arr[j]
        mov eax, [array + 4*ebx]
        mov [array + 4*(ebx+1)], eax

        ; j =- 1
        dec ebx

        jmp loop2
        

    loop2_end:

        ;arr[j+1] = key
        mov eax, [key]
        mov [array + 4*(ebx+1)], eax

        jmp loop1


    error:
        mov eax, error_text
        call print_string
        call print_nl
        jmp end
        

    print:
        push LEN
        push array
        call print_array
        

    end:
        ; End Code
        popa
        mov     eax, 0
        leave                     
        ret

