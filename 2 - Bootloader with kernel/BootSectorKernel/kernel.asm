[BITS 16]
[ORG 0x0]

jmp start

%include "UTIL.INC"

start:
    cli
    mov ax, 0x0100
    mov ds, ax
    mov es, ax
    mov ax, 0x9000
    mov ss, ax
    xor sp, sp
    sti

    mov si, msg_kernel
    call print_string

halt_kernel:
    hlt
    jmp halt_kernel


msg_kernel db "Kernel is speaking!", 13, 10, 0

