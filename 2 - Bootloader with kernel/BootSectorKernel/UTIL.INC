; -------------------------------------------------------------
; print_string: Display zero-terminated string at DS:SI
; Destroys: AL, AH, BX (restored), advances SI.
; -------------------------------------------------------------
print_string:
    push ax
    push bx
.next:
    lodsb                ; AL <- [DS:SI++]
    test al, al          ; end?
    jz .done
    mov ah, 0x0E         ; BIOS teletype
    mov bx, 0x0007       ; page=0 attr=07
    int 0x10
    jmp .next
.done:
    pop bx
    pop ax
    ret
