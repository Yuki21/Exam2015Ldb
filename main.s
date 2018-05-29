.text
.globl main

main:
    enter $32,$0
    //int32_t i = 0
    movq $0, -8(%rbp)
    //on sauvegarde argc dans la pile
    movq %rdi, -16(%rbp)
    //sauv %rsi
    movq %rsi, -24(%rbp)
    for:
        //on restaure i dans %r8
        movq -8(%rbp), %r8
        //on restaure argc dans %r9
        movq -16(%rbp), %r9
        //i < argc
        cmpq %r9, %r8
        jge fin_for
        //%rax=argv[i]
        movq (%rsi, %r8, 8), %rax
        //%rdi=%rax
        movq %rax, %rdi
        //puts
        call puts
        //restaurer %rsi
        movq -24(%rbp), %rsi
        //on restaure i dans %r8
        movq -8(%rbp), %r8
        //i++
        addq $1, %r8
        //restaurer i
        movq %r8, -8(%rbp)
        jmp for
    fin_for:
    movq $0,%rdi
    leave
    ret