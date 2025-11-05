global _start ; делаем метку _start видимой извне

section .data ; Секция данных
    prompt1 db "Enter 1 number: ", 0 ; Приглашение на ввод первого числа
    prompt1_length equ $ - prompt1 ; Длина строки первого приглашения
    prompt2 db "Enter 2 number: ", 0 ; Приглашение на ввод второго числа
    prompt2_length equ $ - prompt2 ; Длина строки второго приглашения
    result_msg db "Answer: ", 0 ; Строка с ответом
    result_length equ $ - result_msg - 1 ; Длина строки ответа
    newline db 10, 0 ; Символ переноса строки

section .bss ; Секция буфера неинициализированных статических данных
    char1 resb 2 ; буфер для первого числа
    char2 resb 2 ; буфер для второго числа
    sum resb 1 ; буфер для суммы чисел

section .text ; Секция кода

_start: ; Точка старта
    ; Ввод первого числа
    mov rax, 1 ; системный вызов write
    mov rdi, 1 ; вывод в stdout
    mov rsi, prompt1 ; строка первого запроса
    mov rdx, prompt1_length ; длина строки первого запроса
    syscall

    mov rax, 0 ; системный вызов read
    mov rdi, 0 ; ввод в stdin
    mov rsi, char1 ; в переменную char1
    mov rdx, 2 ; длина 2 символа
    syscall

    ; Ввод второго числа
    mov rax, 1 ; системный вызов write
    mov rdi, 1 ; вывод в stdout
    mov rsi, prompt2 ; строка второго запроса
    mov rdx, prompt2_length ; длина строки второго запроса
    syscall

    mov rax, 0 ; системный вызов read
    mov rdi, 0 ; ввод в stdin
    mov rsi, char2 ; в переменную char2
    mov rdx, 2 ; длина 2 символа
    syscall

    ; Преобразование символов в числа и сложение
    mov al, [char1] ; Первое число в регистр al
    sub al, '0' ; Преобразуем символ в число
    mov bl, [char2] ; Второе число в регистр bl
    sub bl, '0' ; Преобразуем символ в число
    add al, bl ; Складываем
    mov [sum], al ; Результат в переменную sum

    ; Вывод результата
    mov rax, 1 ; системный вызов write
    mov rdi, 1 ; вывод в stdout
    mov rsi, result_msg ; строка ответа
    mov rdx, result_length ; длина строки ответа
    syscall

   ; Преобразование суммы обратно в символ
    mov al, [sum] ; запись в регистр al
    add al, '0' ; преобразование
    mov [sum], al ; запись в переменную sum

    ; Вывод суммы
    mov rax, 1 ; системный вызов write
    mov rdi, 1 ; вывод в stdout
    mov rsi, sum ; полученная сумма
    mov rdx, 2 ; количество символов
    syscall

    ; Вывод символа новой строки
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    mov rax, 60 ; системный вызов exit
    mov rdi, 0 ; код возврата 0
    syscall

; nasm -f elf64 sum.asm -o sum.o -l sum.lst
; ld -o sum sum.o
; strace ./sum > ./sum.txt
;
; execve("./sum", ["./sum"], 0x7ffe30cd4240 /* 49 vars */) = 0
; write(1, "Enter 1 number: \0", 17)      = 17
; read(0, 1
; "1\n", 2)                       = 2
; write(1, "Enter 2 number: \0", 17)      = 17
; read(0, 2
; "2\n", 2)                       = 2
; write(1, "Answer: ", 8)                 = 8
; write(1, "3\0", 2)                      = 2
; write(1, "\n", 1)                       = 1
; exit(0)                                 = ?
; +++ exited with 0 +++
;
; cat ./sum.txt
;
; Enter 1 number: Enter 2 number: Answer: 3
;
;
