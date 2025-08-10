# Simple Boot Sector Makefile (BuildYourOwnOS)
# Usage:
#   make          -> build boot sector (bootsect) and floppy image (floppyA)
#   make clean    -> remove build artifacts

OBJ=floppyA
ARTIFACTS=bootsect $(OBJ)

all: $(OBJ)

$(OBJ): bootsect
	dd if=/dev/zero of=$(OBJ) bs=512 count=2880
	dd if=bootsect of=$(OBJ) bs=512 count=1 conv=notrunc

bootsect: bootsect.asm
	nasm -f bin -o $@ $^

clean:
	rm -f $(ARTIFACTS)

.PHONY: all clean
