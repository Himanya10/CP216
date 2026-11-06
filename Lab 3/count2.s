/*
-------------------------------------------------------
count2.s
-------------------------------------------------------
Author: Himanya Verma 
ID: 169051154
Email: Verm1154@mylaurier.ca
Date: 06/04/2025
-------------------------------------------------------
A simple count down program (bge)
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

// Load initial value from memory
ldr r1, =COUNTER  // Load address of COUNTER into r1
ldr r3, [r1]      // Load value from COUNTER into r3

TOP:
sub r3, r3, #1    // Decrement the countdown value
cmp r3, #0        // Compare the countdown value to 0
bge TOP           // Branch to TOP if >= 0

_stop:
b _stop

.data  // Data section
COUNTER:
.word 5  // Initialize counter value

.end