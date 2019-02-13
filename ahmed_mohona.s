.data
  input_buffer1: .space 256
  input_specifier1: .asciz "%d"
  input_buffer2: .space 256
  input_specifier2: .asciz "%d"
  input_buffer3: .space 256
  string_specifier: .asciz "%s"
  solution_specifier: .asciz "%d"
  string_input_buffer:.space 256
  buffer: .space 256

  welcome_string: .asciz "Please type two digits and an operation\n"
  error: .asciz "\n cannot divide by zero\n"
  newline: .asciz "\n"

.global main
.text

main:

  #Prompting the user
  ldr x0, =welcome_string
  ldr x1, =string_input_buffer
  bl printf


  #GETTING FIRST INPUT
    #Save input to the buffer
    ldr x0, =input_specifier1
    ldr x1, =input_buffer1
    bl scanf

    ldr x21, =input_buffer1
    ldr x21, [x21]


    #GETTING SECOND INPUT
      #Save input to the buffer
      ldr x0, =input_specifier2
      ldr x1, =input_buffer2
      bl scanf

      ldr x23, =input_buffer2
      ldr x23, [x23]


    #GETTING OPERATION
    #Save input to the buffer
    ldr x0, =string_specifier
    ldr x1, =input_buffer3
    bl scanf

    ldr x25, =input_buffer3
    ldrb w25, [x25]



    #BRANCHING
    #loading operation
    ldr x0, =string_specifier
    ldr x1, =input_buffer3
    ldr x1, [x1]
    #comparing operation to +
    cmp x1, #43
    beq ADD
    #comparing operation to -
    cmp x1, #45
    beq SUB
    #comparing operation to *
    cmp x1, #42
    beq MUL
    #comparing operation to /
    cmp x1, #47
    beq DIV




exit:
mov x0, #0
mov x8, #93
svc #0


ADD:
ADD x25, x21, x23
mov x1, x25
ldr x0, =solution_specifier
bl printf
#FLUSH
ldr x0, =newline
bl printf
b exit

SUB:
SUB x25, x21, x23
mov x1, x25
ldr x0, =solution_specifier
bl printf
#FLUSH
ldr x0, =newline
bl printf
b exit

MUL:
MUL x25, x21, x23
mov x1, x25
ldr x0, =solution_specifier
bl printf
#FLUSH
ldr x0, =newline
bl printf
b exit

DIV:
CBZ w23, ERROR_MESSAGE
SDIV w25, w21, w23
mov w1, w25
ldr w0, =solution_specifier
bl printf
#FLUSH
ldr x0, =newline
bl printf
b exit

ERROR_MESSAGE:
ldr x0, =error
ldr x1, =string_input_buffer
bl printf
#FLUSH
ldr x0, =newline
bl printf
b exit
