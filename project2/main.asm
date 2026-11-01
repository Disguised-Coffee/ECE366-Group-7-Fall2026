# MIPS Hello World Program
# based on https://courses.cs.vt.edu/cs2506/Fall2014/Notes/L04.MIPSAssemblyOverview.pdf
.data
out_string: .asciiz "\nHello, World!\n"   # Null‑terminated string

	.text # Assembly language instructions go in text segment
main: # Start of code section
    li $v0, 4          # System call code for print string
    la $a0, out_string # Load address of string into $a0
    syscall            # Execute print string syscall

    li $v0, 10        # System call code for exit
    syscall            # Terminate program
