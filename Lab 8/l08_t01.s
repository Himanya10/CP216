/*
-------------------------------------------------------
l08_t01.s
-------------------------------------------------------
Author: Himanya Verma
ID: 169051154
Email: Verm1154@mylaurier.ca
Date:    2026-03-27
-------------------------------------------------------
Uses a subroutine to write strings to the UART.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr r4, =First
bl  WriteString
ldr r4, =Second
bl  WriteString
ldr r4, =Third
bl  WriteString
ldr r4, =Last
bl  WriteString

_stop:
b    _stop

// Subroutine constants
.equ UART_BASE, 0xff201000  // UART base address

//=======================================================

.equ ENTER, 0x0A            // Define the ENTER constant (0x0A is line feed)

//=======================================================

WriteString:
/*
-------------------------------------------------------
Writes a null-terminated string to the UART, adds ENTER.
-------------------------------------------------------
Parameters:
  r4 - address of string to print
Uses:
  r0 - holds character to print
  r1 - address of UART
-------------------------------------------------------
*/

//=======================================================

push {r0, r1, r4, lr}   // Save registers to stack
    ldr  r1, =UART_BASE     // Load UART address into r1

ws_loop:
    ldrb r0, [r4], #1       // Load a byte from string into r0, then increment r4
    cmp  r0, #0             // Check if it is the null terminator (end of string)
    beq  ws_done            // If null, move to the end-of-line logic
    str  r0, [r1]           // Write the character in r0 to the UART Data Register
    b    ws_loop            // Repeat for the next character

ws_done:
    mov  r0, #ENTER         // Load the ENTER constant into r0
    str  r0, [r1]           // Send the ENTER character to the UART
    pop  {r0, r1, r4, pc}   // Restore registers and return (pop lr into pc)

//=======================================================

bx    lr                 // return from subroutine

.data
.align
// The list of strings
First:
.asciz  "First string"
Second:
.asciz  "Second string"
Third:
.asciz  "Third string"
Last:
.asciz  "Last string"
_Last:    // End of list address

.end
