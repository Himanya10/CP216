/*
-------------------------------------------------------
intro.s
-------------------------------------------------------
Author: Himanya Verma
ID: 169051154
Email: Verm1154@mylaurier.ca
Date: 
-------------------------------------------------------
Assign to and add contents of registers.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

mov r0, #9       // Store decimal 9 in register r0
mov r1, #14     // Store hex E (decimal 14) in register r1. Task 1; replace #0xE to #14 
mov r3, #8		// Task 2; store decimal 8 in register r3
add r3, r3, r3  // Task 2; store r3 to r3 + r3 (r3 = r3 + r3)
add r2, r1, r0  // Add the contents of r0 and r1 and put result in r2
//add r4, #4, #5 // Task 3; store r4 to 4 + 5; Invalid: ARM syntax does not allow two immediates
mov r5, #4      // Task 3; store 4 into register r5 first
add r4, r5, #5  // Task 3; store r4 to r5 + 5.

// End program
_stop:
b _stop