; -------------------------------------------------------------
; Stage 02 Boot Sector (i386) - Loads tiny kernel (1 sector)
; Build:
;   nasm -f bin -o bootsect bootsect.asm
; Create floppy:
;   dd if=/dev/zero of=floppyA bs=512 count=2880
;   dd if=bootsect of=floppyA bs=512 count=1 conv=notrunc
;   dd if=kernel  of=floppyA bs=512 seek=1 conv=notrunc
; Run (QEMU):
;   qemu-system-i386 -boot a -fda floppyA -serial stdio -no-reboot
;
; Run (Bochs, using bochsrc.txt):
;   bochs -q -f bochsrc.txt
; -------------------------------------------------------------

%define KERNEL_SEG     0x0100      ; segment where kernel (1 sector) is loaded (phys 0x1000)
%define KERNEL_SECTORS 1           ; number of 512B sectors to read
%define KERNEL_LBA     2           ; CHS: cylinder 0, head 0, sector 2

[org 0x7C00]
[bits 16]

    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ax, 0x9000         ; stack segment (well above boot + kernel)
    mov ss, ax
    xor sp, sp
    sti

    mov [BootDrive], dl    ; preserve BIOS boot drive

    ; Print loading message
    mov si, msg_loading
    call print_string

    ; Set ES to kernel destination segment
    mov ax, KERNEL_SEG
    mov es, ax
    xor bx, bx             ; ES:BX points to load address

    mov ah, 0x02           ; BIOS disk read
    mov al, KERNEL_SECTORS ; sectors count
    mov ch, 0              ; cylinder 0
    mov cl, KERNEL_LBA     ; sector number (1-based)
    mov dh, 0              ; head 0
    mov dl, [BootDrive]    ; drive
    int 0x13
    jc disk_error

    ; Jump to loaded kernel (far jump to set CS)
    jmp KERNEL_SEG:0x0000

halt_loop:
    hlt
    jmp halt_loop

disk_error:
    mov si, msg_disk_error
    call print_string
    jmp halt_loop

; -------------------------------------------------------------
; Reusable print routine (TTY) - could be factored to UTIL.INC, duplicated
; intentionally here for a self-contained stage.
; -------------------------------------------------------------
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

msg_loading    db "Loading kernel...", 13, 10, 0
msg_disk_error db "Disk read error", 13, 10, 0
BootDrive      db 0

    times 510 - ($ - $$) db 0
    dw 0xAA55
