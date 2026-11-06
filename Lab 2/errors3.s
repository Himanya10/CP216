/*
-------------------------------------------------------
errors3.s
-------------------------------------------------------
Author: Himanya Verma
ID: 169051154
Email: Verm1154@mylaurier.ca
Date: 05/28/2025
-------------------------------------------------------
Assign to and add contents of registers.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

.text // code section
// Copy contents of first element of Vec1 to Vec2
ldr r0, =Vec1
ldr r1, =Vec2
ldr r2, [r0]
str r2, [r1]
// Copy contents of second element of Vec1 to Vec2
add r0, r0, #4
add r1, r1, #4
ldr r2, [r0]
str r2, [r1]
// Copy contents of second element of Vec1 to Vec2
add r0, r0, #4
add r1, r1, #4
ldr r2, [r0]
str r2, [r1]
// End program
_stop:
b _stop

.data // Initialized data section
Vec1:
.word 1, 2, 3
.bss // Uninitialized data section
Vec2:
.space 12

.end