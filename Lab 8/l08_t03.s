/*
-------------------------------------------------------
l08_t03.s
-------------------------------------------------------
Author: Himanya Verma
ID: 169051154
Email: Verm1154@mylaurier.ca
Date:    2026-03-27
-------------------------------------------------------
Uses a subroutine to read strings from the UART into memory.
-------------------------------------------------------
*/
.org 0x1000   // Start at memory location 1000
.text         // Code section
.global _start
_start:

bl    EchoString

_stop:
b _stop

// Subroutine constants
.equ UART_BASE, 0xff201000  // UART base address
.equ VALID, 0x8000          // Valid data in UART mask
.equ ENTER, 0x0A            // The enter key code

EchoString:
/*
-------------------------------------------------------
Echoes a string from the UART to the UART.
-------------------------------------------------------
Uses:
  r0 - holds character to print
  r1 - address of UART
-------------------------------------------------------
*/

//=======================================================
    push {r0, r1, lr}
    ldr  r1, =UART_BASE

echo_loop:
    # 1. Read the Data Register
    ldr  r0, [r1]           
    
    # 2. Check if a new character has actually been typed (Bit 15)
    tst  r0, #VALID          
    beq  echo_loop          // If bit 15 is 0, no new data; keep waiting

    # 3. Extract the 8-bit character from the 32-bit register
    and  r0, r0, #0xFF       

    # 4. Check if the character is the ENTER key
    cmp  r0, #ENTER          
    beq  echo_done          // If it's ENTER, we stop echoing

    # 5. Write the character back to the same UART address to "echo" it
    str  r0, [r1]           
    
    # 6. Loop back to wait for the next character
    b    echo_loop

echo_done:
    pop  {r0, r1, pc}       // Restore registers and return to _stop
//=======================================================


bx    lr               // return from subroutine

.end