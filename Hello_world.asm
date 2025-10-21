; nano hello_world.asm - создание файла с кодом Ассемблера
global _start

section .data
        message db "Hello world!",10
        length equ $ - message

section .text
_start:
        mov rax, 1
        push rax ; запушим в стек значение системного вызова
        mov rdi, 1
        mov rsi, message
        mov rdx, length
        syscall

        mov rax, 60
        pop rdi ; выведем системный вызов в качестве возвращаемого значения
        syscall

; nasm -f elf64 hello_world.asm -o hello_world.o -l hello_world.lst - собираем бинарный файл, сохраняем код программы в листинге
; ld -o hello_world hello_world.o - линкуем готовый файл
; strace ./hello_world > hello_world.txt - вывод результата в файл и отслеживание системных вызовов
;
; Системные вызовы:
; execve("./hello_world", ["./hello_world"], 0x7ffd7d59c820 /* 58 vars */) = 0
; write(1, "Hello world!\n", 13)          = 13
; exit(1)                                 = ?
; +++ exited with 1 +++
;
; Листинг hello_world.lst:
;     1                                  global _start
;     2
;     3                                  section .data
;     4 00000000 48656C6C6F20776F72-             message db "Hello world!",10
;     4 00000009 6C64210A
;     5                                          length equ $ - message
;     6
;     7                                  section .text
;     8                                  _start:
;     9 00000000 B801000000                      mov rax, 1
;    10 00000005 50                              push rax
;    11 00000006 BF01000000                      mov rdi, 1
;    12 0000000B 48BE-                           mov rsi, message
;    12 0000000D [0000000000000000]
;    13 00000015 BA0D000000                      mov rdx, length
;    14 0000001A 0F05                            syscall
;    15
;    16 0000001C B83C000000                      mov rax, 60
;    17 00000021 5F                              pop rdi
;    18 00000022 0F05                            syscall
