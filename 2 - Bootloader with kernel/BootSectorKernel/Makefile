# Stage 02 Bootloader + Tiny Kernel Makefile
# Targets:
#   make            -> build bootsect + kernel + floppyA
#   make run        -> run via QEMU (floppy)
#   make clean      -> remove artifacts

OBJ=floppyA
ARTIFACTS=bootsect kernel $(OBJ)

all: $(OBJ)

$(OBJ): bootsect kernel
	dd if=/dev/zero of=$(OBJ) bs=512 count=2880 status=none
	dd if=bootsect of=$(OBJ) bs=512 count=1 conv=notrunc status=none
	dd if=kernel  of=$(OBJ) bs=512 seek=1 conv=notrunc status=none

bootsect: bootsect.asm
	nasm -f bin -o $@ $^
	@sz=$$(stat -c%s $@); if [ $$sz -ne 512 ]; then echo "Boot sector size != 512" >&2; exit 1; fi

kernel: kernel.asm
	nasm -f bin -o $@ $^
	@sz=$$(stat -c%s $@); if [ $$sz -ne 512 ]; then echo "Kernel (stub) expected 512 bytes for this stage" >&2; fi

run: $(OBJ)
	qemu-system-i386 -boot a -fda $(OBJ) -serial stdio -no-reboot

clean:
	rm -f $(ARTIFACTS)

.PHONY: all run clean
