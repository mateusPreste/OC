 .data
  message:   .asciiz  "\nInsira o numero: "
  resultado: .asciiz  "\nResultado: "
  valor:     .word    0
.text
  main:
        # show message
        li      $v0,  4
        la      $a0,  message
        syscall
        # insert value
        li      $v0,  5
        syscall
        # insert argument to function
        lui     $a0,  0
        add     $a0,  $a0,  $v0
        # call factorial(n)
        jal     factorial
        # get the return value
        sw      $v0,  valor
        # print result message
        li      $v0,  4
        la      $a0,  resultado
        syscall
        # print value result
        li      $v0,  1
        lw      $a0,  valor
        syscall
        # exit
        li      $v0,  10
        syscall
  factorial:
        add     $fp,  $sp,  $zero
        addi    $sp,  $sp,  -4
        sw      $ra,  ($sp)
        la      $t0,  recursiveBack
        sw      $t0,  ($fp)
        addi    $t1,  $v0,  -1
        j internal
  internal:
        slti    $t0,  $a0,  1
        beq     $t0,  1,    back
        addi    $sp,  $sp,  -4
        sw      $a0,  ($sp)
        addi    $a0,  $a0,  -1
        jal     internal
      back:
        li      $v0,  1 # v0 saves the result
      recursiveBack:
        lw      $t2,  ($sp)
        slt     $t3,  $t1,  $t2
        sll     $t3,  $t3,  2
        sub     $fp,  $fp,  $t3
        mul     $v0,  $t2,  $v0
        add     $sp,  $sp,  4
        lw      $t4,  ($fp)
        jr      $t4
      endStack:

##### Stack Format ###########
#------
#   internal factorial address
#   internal caller address
#   n
#   n-1
#   ...
#   1
#--------
