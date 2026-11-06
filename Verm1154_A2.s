.global _start
_start:
    ldr r0, =Data        // Pointer to source data
    ldr r1, =0x00001500  //Pointer to destination memory 
    ldr r2, =ASCII_Table // Pointer to our lookup table 
    mov r3, #16          // Counter for 16 elements 

loop:
    ldr r4, [r0], #4     // Load hex value from Data and increment pointer 
    ldrb r5, [r2, r4]    // Use hex value (r4) as index into ASCII table to get code 
    strb r5, [r1], #1    // Store ASCII byte at destination and increment pointer
    
    subs r3, r3, #1      // Decrement counter and set condition flags
    bne loop             // Repeat until r3 reaches 0

_stop:
    b _stop              // Infinite loop to end program

// Lookup Table 
ASCII_Table:
    .byte 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37  /* 0-7 */
    .byte 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46  /* 8-9, A-F */

// Provided Data
.align
Data:
    .word 0xA, 0xB, 0xC, 0x1, 0x2, 0x4, 0x9, 0x3
    .word 0xD, 0xF, 0xE, 0x7, 0x5, 0x6, 0x8, 0x0
.end