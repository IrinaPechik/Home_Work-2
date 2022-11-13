	.file	"main.c"
	.intel_syntax noprefix
	.text						# начинаем новую секцию
	.section	.rodata
.LC0:
	.string	"Incorrect size of N"
.LC1:
	.string	"Str: %s\n"
.LC2:
	.string	"Time: %d ms"
	.align 8
.LC3:
	.string	"\nThere is no suitable substring"
.LC4:
	.string	"\nResult: %s\n"
.LC5:
	.string	"r"
	.align 8
.LC6:
	.string	"Error opening the file.To continue, press any key."
.LC7:
	.string	"w"
	.align 8
.LC8:
	.string	"There is no suitable substring\n"
	.align 8
.LC9:
	.string	"For random input - enter 1, for a console one - any other key"
.LC10:
	.string	"%d"
	.align 8
.LC11:
	.string	"Input length (0 < length <= %d): "
.LC12:
	.string	"Incorrect length = %d\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp							# / Cохраняем rbp  на стек
	mov	rbp, rsp						# | rbp := rsp
	sub	rsp, 368						# \ rsp -= 368

	mov	DWORD PTR -356[rbp], edi		# rdi - argc
	mov	QWORD PTR -368[rbp], rsi		# rsi - argv
	
	# ./main.c:15:     if (argc == 3) {
	cmp	DWORD PTR -356[rbp], 3			# cmp argc 3
	jne	.L2 # если не равно -> .L2

	# main.c 16 - char* my_str = argv[1];
	mov	rax, QWORD PTR -368[rbp]		# rax := argv
	mov	rax, QWORD PTR 8[rax]			# rax:= argv[1]
	mov	QWORD PTR -56[rbp], rax			# my_str := rax

	# main.c 18 - N = atoi(argv[2]);
	mov	rax, QWORD PTR -368[rbp] 		# rax = argv
	add	rax, 16
	mov	rax, QWORD PTR [rax]			# rax = argv[2];
	mov	rdi, rax						# rdi := rax
	call	atoi@PLT					# atoi(argv[2]);
	mov	DWORD PTR -8[rbp], eax			# N = eax;

	cmp	DWORD PTR -8[rbp], 1			# cmp N 1
	jle	.L3								# jump if N <= 1 -> .L3
	cmp	DWORD PTR -8[rbp], 256 			# cmp N 256 (max_size)
	jle	.L4								# jump if N <= 256 -> .L4
.L3:
	lea	rax, .LC0[rip]					# rax := "Incorrect size of N\n"
	mov	rdi, rax						# rdi := rax 
	call	puts@PLT					# printf(.LC0[rip]);
	mov	eax, 0							# eax := 0
	jmp	.L5								# go to .L5
.L4:
	# ./main.c:23:  time_t t_start = clock();
	call	clock@PLT
	mov	QWORD PTR -64[rbp], rax	# t_start := rax

	# ./main.c:24:  printf("Str: %s\n", my_str);
	mov	rax, QWORD PTR -56[rbp]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	
	mov	r13d, 0	# rbp[-4] = 0
	# ./main.c:25:    for (int i = 0; i < 25000000; ++i) {
	jmp	.L6
.L7:
	# task(my_str, N);
	mov	edx, DWORD PTR -8[rbp] # edx := N
	mov	rax, QWORD PTR -56[rbp] # rax := my_str
	mov	esi, edx				# esi := edx (2-й аргумент)
	mov	rdi, rax				# rdi := rax (1-й аргумент)
	call	task@PLT			# main.c 26 - task(my_str, N);
	add	r13d, 1	# ++i
.L6:
	# ./main.c:25:    for (int i = 0; i < 25000000; ++i) {
	cmp	r13d, 24999999	# cmp 'int i' 24999999
	jle	.L7							# jump less eq => .L7
	# ./main.c:28:         time_t t_end = clock();
	call	clock@PLT
	mov	QWORD PTR -72[rbp], rax # t_end = rax

	# main.c 29 printf("Time: %d ms", (int) (difftime(t_end, t_start)) / 1000);
	mov	rdx, QWORD PTR -64[rbp]	# rdx := t_start
	mov	rax, QWORD PTR -72[rbp]	# rax := t_end
	mov	rsi, rdx				# rsi := rdx (second arg)
	mov	rdi, rax				# rdi := rax (first arg)
	call	difftime@PLT
	cvttsd2si	eax, xmm0
	movsx	rdx, eax
	imul	rdx, rdx, 274877907
	shr	rdx, 32				# побитовый сдвиг rdx вправо на 32
	sar	edx, 6				# побитовый сдвиг edx вправо на 6
	sar	eax, 31				# побитовый сдвиг eax вправо на 6
	mov	ecx, eax			# ecx := eax
	mov	eax, edx			# eax := edx
	sub	eax, ecx			# eax := eax - ecx
	mov	esi, eax			# esi := eax
	lea	rax, .LC2[rip]		# rax = "Time: %d ms"
	mov	rdi, rax			# rdi := rax
	mov	eax, 0				# eax := 0
	call	printf@PLT		# # main.c 29 printf("Time: %d ms", (int) (difftime(t_end, t_start)) / 1000);

	# main.c 30 char* result = task(my_str, N); Аналогично:
	mov	edx, DWORD PTR -8[rbp]
	mov	rax, QWORD PTR -56[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	task@PLT
	mov	QWORD PTR -80[rbp], rax # result = rax
		
	# main.c 31 - if (strlen(result) == 0) {	
	mov	rax, QWORD PTR -80[rbp]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L8 # if strlen(result) != 0 -> .L8

	lea	rax, .LC3[rip] # rax := "\nThere is no suitable substring\n"
	mov	rdi, rax		# rdi := rax
	call	puts@PLT	# printf("\nThere is no suitable substring\n");
	# main.c 33 - return 0 
	mov	eax, 0	# eax := 0
	jmp	.L5		# go to jmp	.L5
.L8:
	mov	rax, QWORD PTR -80[rbp]		# rax := result
	mov	rsi, rax					# rsi := rax
	lea	rax, .LC4[rip] # rax := "\nResult: %s\n"
	mov	rdi, rax	
	mov	eax, 0
	call	printf@PLT	# printf("\nResult: %s\n", result);
	# return 0
	mov	eax, 0
	jmp	.L5
.L2:
	# main.c 41 - if (argc == 4) {
	cmp	DWORD PTR -356[rbp], 4 # cmp argc 4
	jne	.L9 # if not equals - go to .L9
	mov	rax, QWORD PTR -368[rbp] # rax := argv
	add	rax, 24
	mov	rax, QWORD PTR [rax]	 # rax := argv[3]
	mov	rdi, rax	# rdi := rax
	call	atoi@PLT # atoi(argv[3])
	# Такое же сравнение N и выполнение соотв. кода как и при argc == 3
	mov	DWORD PTR -8[rbp], eax 
	cmp	DWORD PTR -8[rbp], 1
	jle	.L10
	cmp	DWORD PTR -8[rbp], 256
	jle	.L11
.L10:
	lea	rax, .LC0[rip] # rax = "Incorrect size of N\n"
	mov	rdi, rax
	call	puts@PLT
	# return 0
	mov	eax, 0 
	jmp	.L5
.L11:
	# main.c 49 - FILE *input = fopen(argv[1], "r");
	mov	rax, QWORD PTR -368[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -32[rbp], rax
	# main.c 51 if (input == NULL) {
	cmp	QWORD PTR -32[rbp], 0 # cmp input 0
	jne	.L13 # if not eq -> go to .L13 

	lea	rax, .LC6[rip]	# rax := "Error opening the file.To continue, press any key.\n"
	mov	rdi, rax	# rdi := rax
	call	puts@PLT
	call	getchar@PLT
	mov	eax, 0 	# return 0;
	jmp	.L5
.L13:
	# main.c 57 - fgets(array_str, sizeof(array_str), input);
	mov	rdx, QWORD PTR -32[rbp]
	lea	rax, -352[rbp]
	mov	esi, 256
	mov	rdi, rax
	call	fgets@PLT
	# main.c - fclose(input);
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	fclose@PLT
	# main.c - FILE* output = fopen(argv[2], "w");
	mov	rax, QWORD PTR -368[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC7[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	# main.c - char* result = task(array_str, N);
	mov	edx, DWORD PTR -8[rbp]
	lea	rax, -352[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	task@PLT
	mov	QWORD PTR -48[rbp], rax
	# main.c - if (strlen(result) == 0) {
	mov	rax, QWORD PTR -48[rbp]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L14 # if not eq -> .L14
	# main.c - fprintf(output, "%s", "There is no suitable substring\n");
	mov	rax, QWORD PTR -40[rbp]
	mov	rcx, rax
	mov	edx, 31
	mov	esi, 1
	lea	rax, .LC8[rip]
	mov	rdi, rax
	call	fwrite@PLT
	# main.c 67 - fclose(output);
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	fclose@PLT
	# return 0
	mov	eax, 0
	jmp	.L5
.L14:
	# main.c fprintf(output, "%s", result);
	mov	rdx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -48[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	fputs@PLT
	# fclose(output);
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	fclose@PLT
	# return 0
	mov	eax, 0
	jmp	.L5
.L9:
	# main.c 77 - if (argc == 2). Всё те же аналогичные действия.
	cmp	DWORD PTR -356[rbp], 2 # 
	jne	.L15
	# main.c N = atoi(argv[1]);
	mov	rax, QWORD PTR -368[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -8[rbp], eax
	# if (N < 2 || N > max_size) {
	cmp	DWORD PTR -8[rbp], 1
	jle	.L16 # if incorrect
	cmp	DWORD PTR -8[rbp], 256
	jle	.L17 # if correct
.L16:
 	# main. c 80 - 81:
	# printf("Incorrect size of N");
	# return 0;
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L5
.L17:
	# main.c 83 - printf("For random input - enter 1, for a console one - any other key\n");
	lea	rax, .LC9[rip]
	mov	rdi, rax
	call	puts@PLT

	mov	DWORD PTR -84[rbp], 0 # choice := 0;
	#  main.c 85 - scanf("%d", &choice);
	lea	rax, -84[rbp] # rax := &(-84 на стеке)
	mov	rsi, rax	  # rsi := rax - 2-й аргумент
	lea	rax, .LC10[rip]	# rax := &(строчка "%d") 
	mov	rdi, rax		# rdi := rax - 1-й аргумент
	mov	eax, 0
	call	__isoc99_scanf@PLT
				# scanf("%d", &rbp[-84]);
	# main.c 87 - if (choice == 1) {
	mov	eax, DWORD PTR -84[rbp]
	cmp	eax, 1
	jne	.L19 # if not eq - .L19
	# int len = 0;
	mov	DWORD PTR -88[rbp], 0
	# printf("Input length (0 < length <= %d): ", max_size);
	mov	esi, 256
	lea	rax, .LC11[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT

	#  main.c 90 - scanf("%d", &len);
	lea	rax, -88[rbp]  # rax := &(-88 на стеке)
	mov	rsi, rax	   # rsi := rax - 2-й аргумент
	lea	rax, .LC10[rip]	# rax := &(строчка "%d") 
	mov	rdi, rax		# rdi := rax - 1-й аргумент
	mov	eax, 0
	call	__isoc99_scanf@PLT
				# scanf("%d", &rbp[-88]);

	# main.c 91 - if (len < 1 || len > max_size) {
	mov	eax, DWORD PTR -88[rbp]
	test	eax, eax
	jle	.L20 # if equals
	mov	eax, DWORD PTR -88[rbp]
	cmp	eax, 256
	jle	.L21 # if not equlas
.L20:
	# main.c 92 printf("Incorrect length = %d\n", len);
	mov	eax, DWORD PTR -88[rbp]
	mov	esi, eax
	lea	rax, .LC12[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	# return 0;
	mov	eax, 0
	jmp	.L5
.L21:
	# main.c 95 - char* result = task_rnd(len, N);
	mov	eax, DWORD PTR -88[rbp]
	mov	edx, DWORD PTR -8[rbp]
	mov	esi, edx
	mov	edi, eax
	call	task_rnd@PLT
	mov	QWORD PTR -24[rbp], rax
	# if (strlen(result) == 0) 
	mov	rax, QWORD PTR -24[rbp]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L23
	#  main.c 97 printf("\nThere is no suitable substring\n");
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	puts@PLT
	# return 0;
	mov	eax, 0
	jmp	.L5
.L23:
	# printf("\nResult: %s\n", result);
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	# return 0;
	mov	eax, 0
	jmp	.L5
.L19:
	# main.c 95 - char* result = task_cmd(N);
	mov	eax, DWORD PTR -8[rbp]
	mov	edi, eax
	call	task_cmd@PLT
	mov	QWORD PTR -16[rbp], rax
	# main.c 96 - if (strlen(result) == 0) 
	mov	rax, QWORD PTR -16[rbp]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L24
	# printf("\nThere is no suitable substring\n");
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	puts@PLT
	# return 0;
	mov	eax, 0
	jmp	.L5
.L24:
	# main.c 109 printf("\nResult: %s\n", result);
	mov	rax, QWORD PTR -16[rbp]
	mov	rsi, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	# return 0;
	mov	eax, 0
	jmp	.L5
.L15:
	# return 0; 
	mov	eax, 0
.L5:
	leave #/ выход из функции
	ret	  #\
