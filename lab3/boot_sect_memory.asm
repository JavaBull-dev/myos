; Infinite loop (e9 fd ff) 无限循环
;loop:
;    jmp loop 
; boot文件载入内存中，放在 0x7c00～0x7e00, 作为loaded boot sector

mov ah, 0x0e

; attempt 1
; Fails because it tries to print the memory address (i.e. pointer)
; not its actual contents
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; attempt 2
; It tries to print the memory address of 'the_secret' which is the correct approach.
; However, BIOS places our bootsector binary at address 0x7c00
; so we need to add that padding beforehand. We'll do that in attempt 3
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; attempt 3
; Add the BIOS starting offset 0x7c00 to the memory address of the X
; and then dereference the contents of that pointer.
; We need the help of a different register 'bx' because 'mov al, [ax]' is illegal.
; A register can't be used as source and destination for the same command.
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; attempt 4
; We try a shortcut since we know that the X is stored at byte 0x2d in our binary
; That's smart but ineffective, we don't want to be recounting label offsets
; every time we change the code
mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10


;在当前的地址循环
jmp $

the_secret:
    db "A"

; Fill with 510 zeros minus the size of the previous code ，填充0，直到510
times 510-($-$$) db 0
; Magic number 魔数
; 引导文件的最后两个字节需要是 0xaa55,用于区分这个一个boot
dw 0xaa55
