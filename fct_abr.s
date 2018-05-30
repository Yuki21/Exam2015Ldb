.data
    .comm ptr, 8
.text
.globl est_present
.globl abr_vers_tab

est_present:
    enter $0,$0
    if:
        cmpq $0, %rsi
        jne else_if1
        movq $0, %rax
        leave
        ret
    else_if1:
        cmpq %rdi, (%rsi)
        jne else_if2
        movq $1, %rax
        leave
        ret
    else_if2:
        cmpq (%rsi), %rdi
        jge else
        movq 8(%rsi), %rsi
        call est_present
        leave
        ret
    else:
        movq 16(%rsi), %rsi
        call est_present
        leave
        ret

abr_vers_tab:
    enter $16,$0
    //sauver abr
    movq %rdi, -8(%rbp)
    ifn:
        cmpq $0, %rdi
        je fin_ifn
        //abr_vers_tab(abr->fg)
        movq 8(%rdi), %rdi
        call abr_vers_tab
        //ptr* = abr->val
        movq -8(%rbp), %rdi
        movq (%rdi), %rax
        movq ptr, %r10
        movq %rax, (%r10)
        movq %r10, ptr
        //ptr++
        addq $8, ptr
        //struct noeud_t *fd = abr->fd
        movq -8(%rbp), %rdi
        movq 16(%rdi), %rdi
        movq %rdi, -16(%rbp)
        //free(abr)
        movq -8(%rbp), %rdi
        call free
        //abr_vers_tab(fd)
        movq -16(%rbp), %rdi
        call abr_vers_tab
    fin_ifn:
    leave
    ret