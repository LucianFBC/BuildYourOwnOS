# BuildYourOwnOS / NewPepinOS

> English below / Español arriba

## Español

Proyecto educativo y progresivo para implementar un sistema operativo propio paso a paso, inspirado en Pépin OS de Michelizza y adaptado a herramientas modernas (NASM, GCC, QEMU, Bochs, etc.). Cada carpeta mostrará un avance incremental que servirá como referencia para estudiantes y entusiastas.

### Objetivos
- Documentar cada hito desde el primer sector de arranque hasta multitarea básica.
- Mantener el código compatible con toolchains actuales.
- Servir como guía reproducible ("del bootloader al kernel").
- Fomentar la experimentación y aprendizaje.

### Alcance (Roadmap inicial)
(Estructura sugerida, las carpetas se crearán progresivamente)
1. 01-bootloader: MBR / salto a código propio.
2. 02-real-mode: Rutinas básicas, impresión en pantalla (teletipo / BIOS).
3. 03-switch-to-protected: GDT, salto a modo protegido.
4. 04-basic-kernel: Layout, secciones, linker script básico.
5. 05-interrupciones: IDT, ISR, IRQ PIC remap.
6. 06-drivers-texto: Consola, pantalla (modo texto), teclado.
7. 07-memoria: Paginación inicial / gestión simple.
8. 08-elf-loading: Carga de binarios / funciones auxiliares.
9. 09-scheduling: Planificador muy simple (round-robin / cooperativo).
10. 10-syscalls: Interfaz mínima usuario-kernel.
11. Más adelante: FAT / VFS, multitarea avanzada, modo largo (x86_64).

### Requisitos Previos
Instala (mínimo):
- NASM >= 2.16.03
- GCC (idealmente un cross-compiler i686-elf o x86_64-elf para evitar dependencias de libc del host)
- binutils (para el target del cross-compiler)
- make
- qemu-system-x86_64 (ejecución rápida)
- bochs + bochs-sdl / bochs-x para depuración detallada
- genisoimage o xorriso (si se genera ISO)

### Creación de Toolchain (resumen)
(Se podrá documentar en detalle en la carpeta `toolchain/` más adelante)
1. Descargar fuentes de binutils y gcc.
2. Compilar binutils para target i686-elf.
3. Compilar gcc (solo c/c++) para el mismo target sin libs adicionales.
4. Usar ese prefijo (ej: `i686-elf-gcc`) en Makefiles.

### Ejecución Rápida (placeholder)
```bash
make run-qemu
```
(Se añadirá Makefile en etapas posteriores.)

### Estructura Esperada (ejemplo futuro)
```
BuildYourOwnOS/
  01-bootloader/
  02-real-mode/
  03-switch-to-protected/
  ...
  toolchain/ (scripts opcionales)
  docs/ (explicaciones adicionales)
```

### Convenciones
- Código ensamblador: NASM (`.asm`).
- Código C: estándar freestanding (`-ffreestanding -Wall -Wextra -O2`).
- No dependencia de la libc del host en secciones tempranas.
- Linker script explícito (`linker.ld`).

### .gitignore sugerido
Añadir (archivo `.gitignore`):
```
# Artefactos de compilación
*.o
*.obj
*.bin
*.iso
*.img
*.map
*.lst
*.log
build/
out/
# Editor / SO
*.swp
.DS_Store
.idea/
.vscode/
```

### Licencia
Se recomienda MIT o Apache-2.0 para facilitar reutilización. (Archivo `LICENSE` pendiente.)

### Créditos
Basado conceptualmente en Pépin OS de Michelizza. Guía original (francés): https://michelizza.developpez.com/realiser-son-propre-systeme/#L  
Este repositorio reescribe y adapta conceptos para entornos actuales.

### Contribuciones
Pull requests bienvenidos cuando la estructura base esté establecida. Mantener estilo consistente y escribir una breve explicación por commit.

---

## English

Educational, incremental operating system implementation inspired by Pépin OS (Michelizza) and adapted to modern toolchains (NASM, GCC, QEMU, Bochs). Each directory will represent a milestone so learners can follow the evolution step by step.

### Goals
- Document every milestone from the boot sector to basic multitasking.
- Keep code compatible with up-to-date compilers.
- Provide a reproducible learning path.
- Encourage experimentation.

### Initial Roadmap (proposed)
1. 01-bootloader: MBR / jump to custom code.
2. 02-real-mode: Basic routines, screen output (BIOS teletype).
3. 03-switch-to-protected: GDT + protected mode jump.
4. 04-basic-kernel: Layout, sections, basic linker script.
5. 05-interrupts: IDT, ISR, IRQ PIC remap.
6. 06-drivers-text: Console, VGA text, keyboard.
7. 07-memory: Early paging / simple memory manager.
8. 08-elf-loading: ELF loader helpers.
9. 09-scheduling: Simple scheduler.
10. 10-syscalls: Minimal user/kernel interface.
11. Later: FAT / VFS, advanced multitasking, long mode.

### Prerequisites
- NASM >= 2.16.03
- Cross GCC (i686-elf or x86_64-elf) + binutils
- make
- qemu-system-x86_64
- bochs (for deep debugging)
- genisoimage or xorriso (if generating ISO)

### Toolchain (brief)
Will be documented later under `toolchain/`.

### Quick Run (placeholder)
```bash
make run-qemu
```
(To be added.)

### Expected Structure (future)
```
BuildYourOwnOS/
  01-bootloader/
  02-real-mode/
  03-switch-to-protected/
  ...
  toolchain/
  docs/
```

### Conventions
- NASM assembly (.asm)
- Freestanding C (`-ffreestanding -Wall -Wextra -O2`)
- No host libc early on
- Explicit linker script

### Suggested .gitignore
See Spanish section (same list applies).

### License
Recommend MIT or Apache-2.0. (Pending LICENSE file.)

### Credits
Conceptually inspired by Pépin OS (Michelizza). Original (French) guide: https://michelizza.developpez.com/realiser-son-propre-systeme/#L  
Rewritten and adapted for current environments.

### Contributions
PRs welcome after initial layout; keep commits focused and documented.

---

Repositorio: https://github.com/LucianFBC/BuildYourOwnOS
