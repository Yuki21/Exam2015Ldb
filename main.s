.text
.globl main

main:
    enter $16,$0
    //int32_t i = 0
    movq $0, -8(%rbp)
    //on sauvegarde argc dans la pile
    movq %rdi, -16(%rbp)
    for:
        //on restaure i dans %r8
        movq -8(%rbp), %r8
        //on restaure argc dans %r9
        movq -16(%rbp), %r9
        cmpq %r8, %r9
        jge fin_for
        movq (%rsi, %r11, 8), %rax
        movq %rax, %rdi
        call puts
        addq $1, %r8
        movq %r8, -8(%rbp)
    fin_for:
    leave
    ret