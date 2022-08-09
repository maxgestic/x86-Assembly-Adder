.data
result: .byte 0
var1: .ascii "000\n"
var2: .ascii "000\n"
text1: .ascii "Enter Number 1:\n"
text2: .ascii "Enter Number 2:\n"
text3: .ascii "Result:\n"

.text
.globl _start
_start:
      mov $4, %eax 
      mov $1, %ebx 
      mov $text1, %ecx 
      mov $16, %edx 
      int $0x80
      xor %ecx, %ecx
      mov $3, %eax 
      mov $0, %ebx 
      mov $var1, %ecx 
      mov $4, %edx 
      int $0x80
      xor %ecx, %ecx
      mov $4, %eax 
      mov $1, %ebx 
      mov $text2, %ecx 
      mov $16, %edx 
      int $0x80
      xor %ecx, %ecx
      mov $3, %eax 
      mov $0, %ebx 
      mov $var2, %ecx 
      mov $4, %edx 
      int $0x80
      xor %ecx, %ecx
      mov var2, %eax
      push %eax
      shl $24, %eax
      shr $24, %eax
      mov %eax, %ebx
      pop %eax
      push %eax
      shr $8, %eax
      shl $24, %eax
      shr $24, %eax
      mov %eax, %ecx
      pop %eax
      push %eax
      shr $16, %eax
      shl $24, %eax
      shr $24, %eax
      mov %eax, %edx
      pop %eax
      xor %eax, %eax
      sub $0x30, %ebx
      sub $0x30, %ecx
      sub $0x30, %edx
      mov var1, %eax
start_maths:
      cmp $0, %edx
      jne add_1
      cmp $0, %ecx 
      jne add_10
      cmp $0, %ebx
      jne add_100
      jmp finish
add_1:
      add $0x010000, %eax
      dec %edx
      push %eax
      shr $16, %eax
      cmp $0x3A, %al
      pop %eax
      je overflow_1
      jmp start_maths
add_10:
      add $0x0100, %eax
      dec %ecx
      push %eax
      shr $8, %eax
      cmp $0x3A, %al
      pop %eax
      je overflow_10
      jmp start_maths
add_100:
      add $0x01, %eax
      dec %ebx
      jmp start_maths
overflow_1:
      sub $0x0A0000, %eax
      add $0x0100, %eax
      jmp start_maths
overflow_10:
      sub $0x0A00, %eax
      add $0x01, %eax
      jmp start_maths
finish:
      mov %eax, result(,1)
      mov $4, %eax 
      mov $1, %ebx 
      mov $text3, %ecx 
      mov $8, %edx 
      int $0x80
      mov $4, %eax
      mov $1, %ebx
      mov $result, %ecx
      mov $3, %edx
      int $0x80
      mov $1, %eax
      xor %ebx, %ebx
      int $0x80
