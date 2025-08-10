; -------------------------------------------------------------
; Stage 01 Boot Sector (i386) - BuildYourOwnOS / NewPepinOS
; Target architecture: 16-bit real mode entry (BIOS) -> i386 path.
; Didactic focus: minimal, incremental evolution toward protected mode.
; 
; Build (NASM):
;   nasm -f bin -o bootsect bootsect.asm
; 
; Create 1.44MB floppy image:
;   dd if=/dev/zero of=floppyA bs=512 count=2880
;   dd if=bootsect of=floppyA bs=512 count=1 conv=notrunc
; 
; Run (QEMU, simple floppy boot):
;   qemu-system-i386 -boot a -fda floppyA -no-reboot -serial stdio
; 
; Run (Bochs, using bochsrc.txt):
;   bochs -q -f bochsrc.txt
; 
; (Raw sector direct boot kept for reference, optional):
;   qemu-system-i386 -drive format=raw,file=bootsect -no-reboot -serial stdio
; 
; Notes:
; - Keep file size exactly 512 bytes with 0x55AA signature.
; - Future stages will introduce disk reading, GDT, protected mode, etc.
; -------------------------------------------------------------

[org 0x7C00]
[bits 16]

    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ax, 0x9000
    mov ss, ax
    xor sp, sp
    sti

    mov [BootDrive], dl   ; Save BIOS drive number

    mov si, msg_hello
    call print_string

halt_loop:
    hlt
    jmp halt_loop

print_string:
    push si
.next:
    lodsb
    test al, al
    jz .done
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    jmp .next
.done:
    pop si
    ret

msg_hello db "Hello World!", 13, 10, 0
BootDrive db 0

    times 510 - ($ - $$) db 0
    dw 0xAA55