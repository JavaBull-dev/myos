; Infinite loop (e9 fd ff) 无限循环
;loop:
;    jmp loop 


;
mov ah, 0x0e
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10

;在当前的地址循环
jmp $


; Fill with 510 zeros minus the size of the previous code ，填充0，直到510
times 510-($-$$) db 0
; Magic number 魔数
; 引导文件的最后两个字节需要是 0xaa55,用于区分这个一个boot
dw 0xaa55
