.text
.globl init
.globl somme

ecrire:
    //enter $0,$0
    pushl %ebp
    movl %esp, %ebp
    subl $0, %esp
    //%eax=lig
    movl 12(%ebp), %eax
    //%edx:%eax = lig*nrb_col
    mull nbr_col
    movl %eax, %ecx
    //%eax=col
    movl 16(%ebp), %eax
    //%edx:%eax = col
    addl %ecx, %eax

    //%eax = mat[lig][col]
    movl 8(%ebp), %ecx
    movl 20(%ebp), %edx
    movl %edx, (%ecx, %eax, 2)
    
    leave
    ret

init:
    //enter $0,$0
    pushl %ebp
    movl %esp, %ebp
    subl $16, %esp

    //time(NULL)
    movl $0, %edx
    pushl %edx
    call time
    pushl %eax
    call srandom

    movl $0, -4(%ebp)
    for1:
        movl -4(%ebp), %edx
        cmpl nbr_lig, %edx
        jae fin_for1

        movl $0, -8(%ebp)
        for2:
            movl -8(%ebp), %edx
            cmpl nbr_col, %edx
            jae fin_for2
            
            call random
            movl $0, %edx
            movl $19, %ecx
            divl %ecx
            subl $9, %edx
            pushl %edx
            movl -8(%ebp), %edx
            pushl %edx
            movl -4(%ebp), %edx
            pushl %edx
            movl 8(%ebp), %edx
            pushl %edx
            
            call ecrire

            movl -8(%ebp), %edx
            addl $1, %edx
            movl %edx, -8(%ebp)
            jmp for2
        fin_for2:

        movl -4(%ebp), %edx
        addl $1, %edx
        movl %edx, -4(%ebp)
        jmp for1
    fin_for1:

    leave
    ret

somme:
    //enter $0,$0
    pushl %ebp
    movl %esp, %ebp
    subl $8, %esp

    //som=0
    movl $0, -4(%ebp)
    //ix=0
    movl $0, -8(%ebp)
    for3:
        movl -8(%ebp), %eax
        cmpl 12(%ebp), %eax
        jae fin_for3

        movl 8(%ebp), %ecx
        movl -8(%ebp), %eax
        movl (%ecx, %eax, 2), %edx
        movl -4(%ebp), %eax
        addl %edx, %eax
        movl %eax, -4(%ebp)

        movl -8(%ebp), %edx
        addl $1, %edx
        movl %edx, -8(%ebp)
        jmp for3
    fin_for3:
    movl -4(%ebp), %eax
    pushl %eax
    leave
    ret