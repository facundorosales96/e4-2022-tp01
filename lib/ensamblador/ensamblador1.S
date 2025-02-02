/**
 * Referencias importantes:
 * https://developer.arm.com/documentation/dui0552/a
 * https://github.com/ARM-software/abi-aa/tree/main/aapcs32
 */
.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

.macro defun nombre
    .section .text.\nombre
    .global \nombre
    .type \nombre, %function
\nombre:
.endm

.macro endfun nombre
    .size \nombre, . - \nombre
.endm

defun copiaMemoria
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitud
    cmp R2,#0
    beq 0f    
    movs R12,#0
1:    
    ldrb R3,[R0],#1
    strb R3,[R1],#1
    add R12,#1
    cmp R12,R2
    bne 1b
0:    
    bx lr
endfun copiaMemoria

defun copiaCadena
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitudMaxima
    cmp R2,#0
    beq 0f    
    movs R12,#0
1:    
    ldrb R3,[R0],#1
    strb R3,[R1],#1
    cmp R3,#0
    beq 0f
    add R12,#1
    cmp R12,R2
    bne 1b
    mov R3,#0
    strb R3,[R1,#-1]
0:    
    bx lr
endfun copiaCadena

defun mayusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    cmp R1,#0
    beq 0f    
    movs R12,#0
1:    
    ldrb R3,[R0]
    cmp R3,0x60
    bcc 2f
    subs R3,0x20
2:
    strb R3,[R0],#1
    cmp R3,#0
    beq 0f
    add R12,#1
    cmp R12,R1
    bne 1b
0:    
    bx lr
endfun mayusculaEnLugar

defun minusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    cmp R1,#0
    beq 0f    
    movs R12,#0
1:    
    ldrb R3,[R0]
    cmp R3,0x60
    bhi 2f
    cmp R3,0x3A
    bcc 2f
    add R3,0x20
2:
    strb R3,[R0],#1
    cmp R3,#0
    beq 0f
    add R12,#1
    cmp R12,R1
    bne 1b
0:    
    bx lr
endfun minusculaEnLugar
