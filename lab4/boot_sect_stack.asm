; Infinite loop (e9 fd ff)
[org 0x7c00]

; bp 基数指针寄存器BP(base pointer)是一个寄存器
; sp 堆栈寄存器SP(stack pointer)存放栈的偏移地址;
mov bp, 0x8000 ; this is an address far away from 0x7c00 so that we don't get overwritten
mov sp, bp ; if the stack is empty then sp points to bp; 栈的生长方向是从高地址到底地址

start: 
    mov ah, 0x0e ; tty mode
    push 'a'
    push 'b'
    push 'c'
    mov al, [0x7ffe] ; 0x8000 - 2
    int 0x10
    mov al, [0x8000]
    int 0x10
    pop bx
    mov al, bl
    int 0x10 ; prints C
    pop bx
    mov al, bl
    int 0x10 ; prints B

    pop bx
    mov al, bl
    int 0x10 ; prints A
    
    ; data that has been pop'd from the stack is garbage now
    mov al, [0x8000]
    int 0x10

    mov bx, sp
    add bx, 97
    mov al, bl
    int 0x10
end: 
    jmp $
; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55
