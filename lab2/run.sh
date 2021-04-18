#/bin/bash
#编译
nasm -f bin boot_sect_hello.asm -o boot_sect_hello.bin
#启动
qemu-system-x86_64 boot_sect_hello.bin



