global _start ; делаем метку _start видимой извне

section .data ; Секция данных

    input_string db "Hello, World!", 0 ; Исходная строка
    string_length equ $ - input_string - 1  ; Длина строки без нулевого байта
    newline db 10 ; символ новой строки

section .bss ; Секция буфера неинициализированных статических данных
    reversed_string resb 100  ; Буфер для перевернутой строки в 100 байт (100 символов)


section .text ; Секция кода
_start: ; точка входа в программу
    ; Инициализация регистров
    mov rsi, input_string     ; Указатель на начало исходной строки
    mov rdi, reversed_string  ; Указатель на начало буфера для перевернутой строки
    mov rcx, string_length    ; Длина строки
    mov rbx, rcx              ; Сохраняем длину в rbx
    dec rbx                   ; Вычитаем последний символ из строки (убираем нулевой с>

reverse_loop:
    ; Проверяем, не достигли ли начала строки
    cmp rbx, 0 ; Проверка конца строки
    jl reverse_done ; если длина меньше 0, переходим в конец

    ; Копируем символ из исходной строки в перевернутую
    mov al, [rsi + rbx]       ; Берем символ с конца
    mov [rdi], al             ; Сохраняем в начало перевернутой строки

    ; Переходим к следующему символу
    inc rdi                   ; Следующая позиция в перевернутой строке
    dec rbx                   ; Предыдущий символ в исходной строке

    jmp reverse_loop ; переход в начало цикла

reverse_done: ; конец программы
    mov byte [rdi], 0 ; добавляем к концу строки нулевой терминатор

    ; вывод строки
    mov rax, 1                ; системный вызов write
    mov rdi, 1                ; вывод в stdout
    mov rsi, input_string     ; исходная строка
    mov rdx, string_length    ; длина исходной строки
    syscall

    ; Вывод символа новой строки
    mov rax, 1
    mov rdi, 1
    mov rsi, newline ; символ новой строки
    mov rdx, 1
    syscall

    ; Вывод перевернутой строки
    mov rax, 1
    mov rdi, 1
    mov rsi, reversed_string ; перевернутая строка
    mov rdx, string_length
    syscall

    ; Вывод символа новой строки
    mov rax, 1
    mov rdi, 1
    mov rsi, newline ; символ новой строки
    mov rdx, 1
    syscall

    ; Завершаем программу
    mov rax, 60               ; системный вызов exit
    xor rdi, rdi              ; код возврата 0
    syscall

; nasm -f elf64 revers.asm -o revers.o -l revers.lst
; ld -o revers revers.o
; strace ./revers > ./revers.txt
;
; xecve("./revers", ["./revers"], 0x7ffeb15182b0 /* 49 vars */) = 0
; write(1, "Hello, World!", 13)           = 13
; write(1, "\n", 1)                       = 1
; write(1, "!dlroW ,olleH", 13)           = 13
; write(1, "\n", 1)                       = 1
; exit(0)                                 = ?
; +++ exited with 0 +++
;
; cat revers.txt
;
; Hello, World!
; !dlroW ,olleH                                                       
