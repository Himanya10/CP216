/*
-------------------------------------------------------
count1.s
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

// Store data in registers
mov r3, #5  // Initialize a countdown value

TOP:
sub r3, r3, #1 // Decrement the countdown value
cmp r3, #0     // Compare the countdown value to 0
bge TOP        // Branch to TOP if >= 0

_stop:
b _stop

.end