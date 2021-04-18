[org 0x7c00]  ; 告诉汇编器当前的偏移量是引导扇区
mov ah, 0x0e
mov bx, the_secret

; 打印字符串
print:
    mov al, [bx]
    cmp al, 0
    je end
    int 0x10
    inc bx
    jmp print

end:
    jmp $

the_secret:
    db 'hello, world', 0

; Fill with 510 zeros minus the size of the previous code ，填充0，直到510
times 510-($-$$) db 0

; Magic number 魔数
; 引导文件的最后两个字节需要是 0xaa55,用于区分这个一个boot
dw 0xaa55
