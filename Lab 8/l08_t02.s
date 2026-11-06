/*
-------------------------------------------------------
l08_t02.s
-------------------------------------------------------
Author: Himanya Verma
ID: 169051154
Email: Verm1154@mylaurier.ca
Date:    2026-03-27
-------------------------------------------------------
Uses a subroutine to read strings from the UART into memory.
-------------------------------------------------------
*/
// Constants
.equ SIZE, 20 // Size of string buffer storage (bytes)

.org 0x1000   // Start at memory location 1000
.text         // Code section
.global _start
_start:

//=======================================================
    mov    r5, #SIZE        // Pass the buffer size through r5
//=======================================================

ldr    r4, =First
bl    ReadString
ldr    r4, =Second
bl    ReadString
ldr    r4, =Third
bl     ReadString
ldr    r4, =Last
bl     ReadString

_stop:
b _stop

// Subroutine constants
.equ UART_BASE, 0xff201000  // UART base address
.equ ENTER, 0x0A            // The enter key code
.equ VALID, 0x8000          // Valid data in UART mask

ReadString:
/*
-------------------------------------------------------
Reads an ENTER terminated string from the UART.
-------------------------------------------------------
Parameters:
  r4 - address of string buffer
  r5 - size of string buffer
Uses:
  r0 - holds character to print
  r1 - address of UART
-------------------------------------------------------
*/

//=======================================================
    push {r0, r1, r4, r5, lr}
    ldr  r1, =UART_BASE

rs_loop:
    # Check if there is space in the buffer. 
    # We use (SIZE - 1) to leave room for the null terminator (0x00).
    cmp  r5, #1             
    ble  rs_done            // If only 1 byte left, stop and null-terminate

    # Read from UART
    ldr  r0, [r1]           
    tst  r0, #VALID          // Check if the data is valid
    beq  rs_loop            // If not valid, loop back and wait

    # Process the character
    and  r0, r0, #0xFF       // Extract the 8-bit character from the UART data
    cmp  r0, #ENTER          // Check if the user pressed 'Enter'
    beq  rs_done

    # Store character and update counters
    strb r0, [r4], #1       // Store byte in memory and increment the pointer (r4)
    sub  r5, r5, #1          // Decrement the remaining space counter (r5)
    b    rs_loop

rs_done:
    mov  r0, #0              // Load null terminator
    strb r0, [r4]           // Terminate the string in memory
    pop  {r0, r1, r4, r5, pc} // Restore registers and return
//=======================================================

bx    lr                    // return from subroutine

.data
.align
// The list of strings
First:
.space  SIZE
Second:
.space SIZE
Third:
.space SIZE
Last:
.space SIZE
_Last:    // End of list address

.end