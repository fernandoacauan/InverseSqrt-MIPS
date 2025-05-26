.data
	msg: .ascii "Programa de Raiz Quadrada - Newton-Raphson\n",
		    "Desenvolvedores: Eduardo Acauan, Fernando Acauan, Henrique Hiller, Rodrigo Pacheco\n", "\0"
	prompt: .asciiz "Digite os parametros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execucao\n"
	res1:   .asciiz "sqrt("
.text

.macro printDataString (%addr)
	li	$v0, 4
	la	$a0, %addr
	syscall 
.end_macro
	
.macro exit()
	li $v0, 10
	syscall
.end_macro

.macro printChar(%carac)
	li $a0, %carac
	li $v0, 11
	syscall
.end_macro

main:
	printDataString (msg)
	
loop:	printDataString (prompt)
	
	li	$v0, 5 
	syscall 
	
	blt	$v0, $zero, exit
	
	move	$a0, $v0 #x
	
	li	$v0, 5
	syscall
	
	blt	$v0, $zero, exit
	
	move	$a1, $v0 #i
	
	jal	sqrt # sqrt($a0, $a1)
	
	move	$t0, $v0 # res
	move    $t1, $a0 # x
	move    $t2, $a1 # i
	
	printDataString (res1) #sqrt(
	
	li	$v0, 1
	move	$a0, $t1 
	syscall # sqrt(x
	
	printChar(',')
	
	move	$a0, $t2
	li	$v0, 1
	syscall # sqrt(x,i
	
	printChar(')')
	printChar('=')
	
	li	$v0, 1
	move	$a0, $t0
	syscall #sqrt(x,i)=y
	
	printChar('\n')
	
	j	loop
exit:	exit()









sqrt: #a0 -> x, a1 -> i, v0 -> r
	addi	$sp, $sp, -12
	sw	$ra, 0($sp)
	sw	$a0, 4($sp)
	sw	$a1, 8($sp)
	bne	$a0, $zero, _if1
	li	$v0, 0
	j 	sqexit
_if1:   ble     $a1, $zero, _if2
	addiu   $a1, $a1, -1
	jal	sqrt
	div     $a0, $v0
	mflo    $t1
	add     $v0, $v0, $t1
	srl     $v0, $v0, 1
	j       sqexit
_if2:   move    $v0, $a0
sqexit:	lw	$ra, 0($sp)
	lw      $a0, 4($sp)
	lw      $a1, 8($sp)
	addi    $sp, $sp, 12
	jr      $ra
