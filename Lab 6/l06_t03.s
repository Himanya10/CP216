/*
-------------------------------------------------------
l06_t03.s
-------------------------------------------------------
Author: Himanya Verma
ID: 169051154
Email: Verm1154@mylaurier.ca
Date:    2024-02-22
-------------------------------------------------------
Working with stack frames.
Finds the common prefix of two null-terminate strings.
-------------------------------------------------------
*/
// Constants
.equ SIZE, 80

.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

//=======================================================
// push parameters onto the stack (Right-to-Left)
//=======================================================
mov    r3, #SIZE
stmfd  sp!, {r3}         // [fp, #12] - size

ldr    r3, =Common
stmfd  sp!, {r3}         // [fp, #8]  - common pointer

ldr    r3, =Second
stmfd  sp!, {r3}         // [fp, #4]  - second pointer

ldr    r3, =First
stmfd  sp!, {r3}         // [fp, #0]  - first pointer (if using mov fp, sp)
// Note: If using add fp, sp, #4, the offsets below will shift. 
// Let's use the most stable method:
//=======================================================

bl     FindCommon

//=======================================================
// clean up stack
//=======================================================
add    sp, sp, #16       // 4 parameters * 4 bytes each
//=======================================================

_stop:
b      _stop

//-------------------------------------------------------

FindCommon:
//=======================================================
// prologue: save registers and get parameters from stack
//=======================================================
    stmfd   sp!, {fp, lr}    // Save Frame Pointer and Link Register
    add     fp, sp, #4       // Point fp to the saved lr
    stmfd   sp!, {r0-r5}     // Save all registers used in the subroutine

    // Load parameters using fp offsets
    ldr     r0, [fp, #4]     // first - pointer to start of first string
    ldr     r1, [fp, #8]     // second - pointer to start of second string
    ldr     r2, [fp, #12]    // common - pointer to storage of common string
    ldr     r3, [fp, #16]    // size - maximum size of common
//=======================================================

FCLoop:
    cmp    r3, #1          // is there room left in common?
    beq    _FindCommon     // no, leave subroutine
    ldrb   r4, [r0], #1    // get next character in first
    ldrb   r5, [r1], #1    // get next character in second
    cmp    r4, r5
    bne    _FindCommon     // if characters don't match, leave subroutine
    cmp    r4, #0          // reached end of first?
    beq    _FindCommon
    cmp    r5, #0          // reached end of second?
    beq    _FindCommon
    strb   r4, [r2], #1    // copy character to common
    sub    r3, r3, #1      // decrement space left in common
    b      FCLoop

_FindCommon:
    mov    r4, #0
    strb   r4, [r2]        // terminate common with null character

//=======================================================
// epilogue: clean up stack and return from subroutine
//=======================================================
    ldmfd   sp!, {r0-r5}    // Restore working registers
    ldmfd   sp!, {fp, pc}   // Restore fp and return (pop lr into pc)
//=======================================================

.data
First:
.asciz "pandemic"
Second:
.asciz "pandemonium"
Common:
.space SIZE

.end