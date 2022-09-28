.globl my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
  ####### Some smart student's code here #######
    #save all registers except rdi and rax

	pushq %rbx
    pushq %rcx
    pushq %rdx
    pushq %rsi
	pushq %rbp
    pushq %r8
    pushq %r9
    pushq %r10
    pushq %r11
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
    
    #get invalid opcode - opcode(rip) is first in stack becuase theres no error code
    movq 104(%rsp),%rdx
    #little endian 0f will be first
    movb (%rdx),%dl
    #check if opcode is one or two bytes long
    movb $0x0f,%cl
    cmpb %cl,%dl
    je two_byte
    movzbl %dl,%rdi
    call what_to_do
    #return of what_to_do in rax but return of handler in rdi
    movq %rax,%rdi
    #popq internal parameters
    popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	popq %rbp
	popq %rsi
	popq %rdx
	popq %rcx
	popq %rbx

    cmp $0,%rax
    #if 0 then return to old handler which is a global pointer variable
    jz old_handler
    #rip moves to next opcode
    addq $1,(%rsp)
    jmp end
    
old_handler:
       jmp *old_ili_handler
       jmp end
    
two_byte:
    #get second byte
    movq 104(%rsp),%rdx
    movb 1(%rdx),%dl
    movzbl %dl,%rdi
    call what_to_do
    #return of what_to_do in rax but return of handler in rdi
    movq %rax,%rdi
    #popq internal parameters
    popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	popq %rbp
	popq %rsi
	popq %rdx
	popq %rcx
	popq %rbx

    cmp $0,%rax
    #if 0 then return to old handler which is a global pointer variable
    jz old_handler
    #rip moves to next opcode
    addq $2,(%rsp) 
    jmp end

end:
    iretq
