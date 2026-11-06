/*
-------------------------------------------------------
count3.s
-------------------------------------------------------
Author: Himanya Verma 
ID: 169051154
Email: Verm1154@mylaurier.ca
Date: 06/04/2025
-------------------------------------------------------
An infinite loop program with a timer delay and
LED display (memory version)
-------------------------------------------------------
*/
// Constants
.equ TIMER, 0xfffec600
.equ LEDS,  0xff200000

.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

// Load addresses and values from memory
ldr r0, =LEDS
ldr r1, =TIMER
ldr r4, =LED_BITS   // Load address of LED_BITS
ldr r2, [r4]        // Load actual LED pattern from memory
ldr r5, =DELAY_TIME // Load address of DELAY_TIME
ldr r3, [r5]        // Load actual delay time from memory

str r3, [r1]        // Set timer timeout
mov r3, #0b011      // Auto-reload + enable
str r3, [r1, #0x8]  // Set timer control

LOOP:
str r2, [r0]        // Update LEDs
WAIT:
ldr r3, [r1, #0xC]  // Read timer status
cmp r3, #0
beq WAIT            // Wait for timer expiration
str r3, [r1, #0xC]  // Reset timer flag
ror r2, #1          // Rotate LED pattern
b LOOP

.data  // Data section
LED_BITS:
.word 0x0F0F0F0F    // LED pattern stored in memory
DELAY_TIME:
.word 200000000     // Delay time stored in memory

.end