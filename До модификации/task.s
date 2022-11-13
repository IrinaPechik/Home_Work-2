	.file	"task.c"
	.intel_syntax noprefix
	.text					# Begin new section 
	.globl	task
	.type	task, @function
task:
	endbr64					
	push	rbp				# / Cохраняем rbp  на стек
	mov	rbp, rsp			# | rbp := rsp
	push	rbx				# | Сохраняем rbx на стек
	sub	rsp, 56				# \ rsp -= 56
	mov	QWORD PTR -56[rbp], rdi # rdi - str
	mov	DWORD PTR -60[rbp], esi # esi - n

	mov	eax, DWORD PTR -60[rbp] # eax := argv
	cdqe
	mov	esi, 4				# esi := 4
	mov	rdi, rax			# rdi := rax
	call	calloc@PLT		# main.c 8 - calloc(n, sizeof(int))
	mov	QWORD PTR -40[rbp], rax # answer := rax

	# main. c 9 - int count = 1;
	mov	DWORD PTR -20[rbp], 1  # count := 1
	# main. c 10 - int last_ind = 0;
	mov	DWORD PTR -24[rbp], 0 # last_ind := 0

	# main.c 11 for (int i = 1; i < strlen(str); i++) {
	mov	DWORD PTR -28[rbp], 1	# i := 1
	jmp	.L2 # go to .L2
.L8:
	# main.c 12 - if (count == n) {
	mov	eax, DWORD PTR -20[rbp] # eax := count
	cmp	eax, DWORD PTR -60[rbp] # cmp eax n
	jne	.L3 # if not equals - go to .L3.
	mov	eax, DWORD PTR -28[rbp]	# eax := i
	sub	eax, 1	# eax := eax - 1
	mov	DWORD PTR -24[rbp], eax # last_ind = eax
	jmp	.L4 # go to .L4
.L3:
	# main.c 16 if (str[i - 1] > str[i]) 
	mov	eax, DWORD PTR -28[rbp] # eax := i
	cdqe
	lea	rdx, -1[rax] # rdx := i - 1
	mov	rax, QWORD PTR -56[rbp] # rax := str
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	eax, DWORD PTR -28[rbp] # eax := i
	movsx	rcx, eax
	mov	rax, QWORD PTR -56[rbp] # rax := str
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al	# cmp dl al
	jle	.L5
	# main.c 17 - count++
	add	DWORD PTR -20[rbp], 1
	jmp	.L6 # go to .L6
.L5:
	mov	DWORD PTR -20[rbp], 1 # count := 1
	mov	DWORD PTR -24[rbp], 0 # last_ind := 0
.L6:
	# main.c 22 - if (i == strlen(str) - 1) 
	mov	eax, DWORD PTR -28[rbp] # eax := i
	movsx	rbx, eax # copy rbx eax
	mov	rax, QWORD PTR -56[rbp] # rax := str
	mov	rdi, rax	# rdi := rax
	call	strlen@PLT # strlen(str)
	sub	rax, 1	# rax := rax - 1
	cmp	rbx, rax # cmp rbx rax
	jne	.L7 # if not equals - go to .L7
	# main.c 23 if (count == n)
	mov	eax, DWORD PTR -20[rbp] # eax := count
	cmp	eax, DWORD PTR -60[rbp] # cmp eax n
	jne	.L7 # if not equals - go to .L7
	# main.c 24 - last_ind = i;
	mov	eax, DWORD PTR -28[rbp]	# eax := i
	mov	DWORD PTR -24[rbp], eax	# last_ind := eax
	# break
	jmp	.L4 # go to .L4
.L7:
	add	DWORD PTR -28[rbp], 1
.L2:
	# main.c 11 - for (int i = 1; i < strlen(str); i++) {
	mov	eax, DWORD PTR -28[rbp]	# eax = i;
	movsx	rbx, eax
	mov	rax, QWORD PTR -56[rbp]	# rax := str
	mov	rdi, rax # rdi := rax
	call	strlen@PLT # strlen(str);
	cmp	rbx, rax # cmp rbx rax
	# if rbx < rax
	jb	.L8
.L4:
	# main.c for (int i = 0; i < n; i++) 
	mov	DWORD PTR -32[rbp], 0 # i := 0
	jmp	.L9 # go to .L9
.L10:
	# main. c 30 answer[i] = str[last_ind - n + 1 + i];
	mov	eax, DWORD PTR -24[rbp] # eax := last_ind
	sub	eax, DWORD PTR -60[rbp] # eax := eax - n
	lea	edx, 1[rax] # edx := 
	mov	eax, DWORD PTR -32[rbp] # eax := n
	add	eax, edx	# eax := eax + edx
	movsx	rdx, eax
	mov	rax, QWORD PTR -56[rbp] # rax := str
	add	rax, rdx	# rax := rax + rdx
	mov	edx, DWORD PTR -32[rbp] # edx := n
	movsx	rcx, edx
	mov	rdx, QWORD PTR -40[rbp] # rdx := answer
	add	rdx, rcx # rdx := rdx + rcx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al

	add	DWORD PTR -32[rbp], 1 # i := i + 1
.L9:
	# main.c 30 answer[i] = str[last_ind - n + 1 + i];
	mov	eax, DWORD PTR -32[rbp]
	cmp	eax, DWORD PTR -60[rbp]
	jl	.L10
	#  main.c 30 return answer;
	mov	rax, QWORD PTR -40[rbp]
	# вызод из функции
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret
	.size	task, .-task
	.section	.rodata
.LC0:
	.string	"Random string: %s"
	.text	# New section
	.globl	task_rnd
	.type	task_rnd, @function
task_rnd:
	endbr64 # DELETE!!
	push	rbp		# / Cохраняем rbp  на стек
	mov	rbp, rsp	# | rbp := rsp
	sub	rsp, 32		#  \ rsp -= 32
	
	mov	DWORD PTR -20[rbp], edi # length: = edi
	mov	DWORD PTR -24[rbp], esi # n := esi 
	#  main.c 36 char* rndStr = (char*)calloc(length, sizeof(int));
	mov	eax, DWORD PTR -20[rbp] # eax := length
	cdqe
	mov	esi, 4 # esi := 4
	mov	rdi, rax # rdi := rax
	call	calloc@PLT # calloc(length, sizeof(int));
	mov	QWORD PTR -16[rbp], rax # rndStr := rax
	# main.c 37 srand(clock());
	call	clock@PLT 
	mov	edi, eax
	call	srand@PLT
	# main.c 38 for (int i = 0; i < length; ++i)
	mov	DWORD PTR -4[rbp], 0
	jmp	.L13
.L14:
 	# Аналогично считаем в main.c 39 -
	# rndStr[i] = (char) (33 + rand() % 93);
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 738919105
	shr	rdx, 32
	sar	edx, 4
	mov	ecx, eax # ecx := eax
	sar	ecx, 31
	sub	edx, ecx # edx := edx - ecx
	imul	ecx, edx, 93
	sub	eax, ecx # eax := eax - ecx
	mov	edx, eax # edx := eax
	mov	eax, edx # eax := edx
	lea	ecx, 33[rax]
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rdx # rax := rax + rdx
	mov	edx, ecx # edx := ecx
	mov	BYTE PTR [rax], dl
	
	add	DWORD PTR -4[rbp], 1 # i := i + 1
.L13:
	# main.c 38 for (int i = 0; i < length; ++i) 
	mov	eax, DWORD PTR -4[rbp]	# eax := i
	cmp	eax, DWORD PTR -20[rbp] # cmp eax length
	jl	.L14 
	# main.c 41 - rndStr[length] = '\0';
	mov	eax, DWORD PTR -20[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	# main.c 42 printf("Random string: %s", rndStr);
	mov	rax, QWORD PTR -16[rbp]
	mov	rsi, rax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT # printf("Random string: %s", rndStr);
	# main.c 43 return task(rndStr, n);
	mov	edx, DWORD PTR -24[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	task
	# выход 
	leave
	ret
	.size	task_rnd, .-task_rnd
	.section	.rodata
	.align 8
.LC1:
	.string	"Your string (max - 256 characters):"
	.text	# new section
	.globl	task_cmd
	.type	task_cmd, @function
task_cmd:
	endbr64 # DELETE!!
	push	rbp	 # / Cохраняем rbp  на стек
	mov	rbp, rsp # | rbp := rsp
	sub	rsp, 272 # \ rsp -= 32
	# main.c 48 printf("Your string (max - 256 characters):");
	mov	DWORD PTR -260[rbp], edi # n := edi
	lea	rax, .LC1[rip] # rax := Your string (max - 256 characters):"
	mov	rdi, rax # rdi := rax
	mov	eax, 0 # eax := 0
	call	printf@PLT # printf(rax);
	# main.c 49 fflush(stdin);
	mov	rax, QWORD PTR stdin[rip] # rax := stdin
	mov	rdi, rax # rdi := rax
	call	fflush@PLT # main.c 49 - fflush(stdin);
	call	getchar@PLT # main.c 50 - getchar();
	# main.c 51 - fgets(string, 256, stdin);
	mov	rdx, QWORD PTR stdin[rip] # rdx := stdin
	lea	rax, -256[rbp] 
	mov	esi, 256 # esi := 256
	mov	rdi, rax # rdi := rax
	call	fgets@PLT # fgets(string, 256, stdin);
	# main.c 52 - return task(string, n);
	mov	edx, DWORD PTR -260[rbp] #
	lea	rax, -256[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	task
	# exit
	leave
	ret
	.size	task_cmd, .-task_cmd
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
