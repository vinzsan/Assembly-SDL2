.code64
.intel_syntax noprefix

.extern printf
.extern SDL_CreateWindow
.extern SDL_CreateRenderer
.extern SDL_PollEvent
.extern SDL_DestroyWindow
.extern SDL_DestroyRenderer
.extern SDL_DestroyTexture
.extern SDL_RenderPresent
.extern SDL_RenderClear
.extern SDL_Delay
.extern SDL_SetTextureAlphaMod
.extern SDL_SetRenderDrawColor
.extern SDL_GetKeyboardState
.extern SDL_CreateTextureFromSurface
.extern IMG_Init
.extern IMG_Load
.extern SDL_FreeSurface
.extern IMG_Quit
.extern SDL_Init
.extern SDL_RenderCopy
.extern SDL_SetHint
.extern SDL_SetTextureBlendMode

.equ SDL_QUIT,256
.equ SDL_WINDOWPOS_CENTERED,805240832
.equ SDL_SCANCODE_Q,20
.equ SDL_SCANCODE_1,30
.equ SDL_SCANCODE_2,31
.equ SDL_SCANCODE_3,32
.equ SDL_SCANCODE_4,33
.equ SDL_SCANCODE_5,34
.equ SDL_SCANCODE_6,35
.equ SDL_SCANCODE_7,36
.equ SDL_SCANCODE_8,37
.equ SDL_INIT_EVERYTHING,62001
.equ IMG_INIT_JPG,1

.section .rodata
  L1: .string "OwO"
  L2: .string "[INFO] : Error load image\n" 

  LS01: .string "[INFO] : success made window : %p\n"
  LS02: .string "[INFO] : success made renderer : %p\n"
  LS03: .string "[INFO] : success made renderer : %p\n"

  LS04: .string "[INFO] : exiting window SDL2\n"

  FMT: .string "%d\n"
  FMT_P: .string "PTR : %p\n"

  FMT_CL1: .string "Color r15d : %d\n"
  FMT_CL2: .string "Color r12d : %d\n"

  FMT_F: .string "Memory telah di bebaskan sebanyak : %d = %p\n"

  SDL_HINT_RENDER_SCALE_QUALITY: .string "SDL_RENDER_SCALE_QUALITY"
  img_name1: .string "./anime.jpeg"
  img_name2: .string "./ani1.jpeg"
  SDL_HINT_SET: .string "linear"

.section .data
  window_t: .quad 1
  render_t: .quad 1
  event_t: .skip 56
  texture_t: .quad 0,0
  surface_t: .quad 1 
  keystate_t: .quad 1

.section .text
  .global main

main:

  push rbp
  mov rbp,rsp
  sub rsp,16 * 16

  mov edi,SDL_INIT_EVERYTHING
  call SDL_Init

  mov edi,IMG_INIT_JPG
  call IMG_Init

  lea rdi,[rip + L1]
  mov esi,SDL_WINDOWPOS_CENTERED
  mov edx,SDL_WINDOWPOS_CENTERED
  mov ecx,900 
  mov r8d,800
  mov r9d,32
  call SDL_CreateWindow

  mov [rip + window_t],rax
  cmp rax,0 
  je ER1

  lea rdi,[rip + LS01]
  mov rsi,rax 
  xor eax,eax
  call printf

  mov rdi,QWORD ptr [rip + window_t]
  mov esi,-1
  mov edx,2 
  call SDL_CreateRenderer

  mov [rip + render_t],rax 
  cmp rax,0 
  je ER1 

  lea rdi,[rip + LS02]
  mov rsi,rax
  xor eax,eax
  call printf

  lea rdi,[rip + img_name1]
  call IMG_Load

  cmp rax,0 
  je ER1

  mov [rip + surface_t],rax

  lea rdi,[rip + SDL_HINT_RENDER_SCALE_QUALITY]
  lea rsi,[rip + SDL_HINT_SET]
  call SDL_SetHint

  mov rdi,QWORD ptr [rip + render_t]
  mov rsi,QWORD ptr [rip + surface_t]
  call SDL_CreateTextureFromSurface
  cmp rax,0 
  je ER1

  mov [rip + texture_t + 0*8],rax

  mov rdi,QWORD ptr [rip + surface_t]
  call SDL_FreeSurface

  lea rdi,[rip + img_name2]
  call IMG_Load 

  mov [rip + surface_t],rax

  mov rdi,QWORD ptr [rip + render_t]
  mov rsi,QWORD ptr [rip + surface_t]
  call SDL_CreateTextureFromSurface

  mov [rip + texture_t + 1*8],rax

  cmp rax,0 
  jle ER1

  xor r14,r14
  lea r15,[rip + texture_t]

TEXT_L01:

  cmp r14,2 
  jge TEXT_L02

  mov rdi,QWORD ptr [r15 + r14 *8]
  mov esi,1 
  call SDL_SetTextureBlendMode

  inc r14 
  jmp TEXT_L01

TEXT_L02:

  mov rdi,QWORD ptr [rip + surface_t]
  call SDL_FreeSurface

  lea rdi,[rip + LS03]
  mov rsi,rax
  xor eax,eax
  call printf

  mov r14d,100
  xor r15,r15
  xor r12,r12
  mov QWORD ptr [rbp - 16],r15
  mov QWORD ptr [rbp - 8],1
  mov QWORD ptr [rbp - 24],0 

L01:

  cmp QWORD ptr [rbp - 8],0
  je B01

L02:

  lea rdi,[rip + event_t]
  call SDL_PollEvent

  # if 
  mov eax,[rip + event_t]
  cmp eax,SDL_QUIT
  je B01

  xor edi,edi
  call SDL_GetKeyboardState
  mov r13,rax

  movzx eax,BYTE ptr [r13 + SDL_SCANCODE_Q]
  test eax,eax
  jnz B01

  movzx eax,BYTE ptr [r13 + SDL_SCANCODE_1]
  test eax,eax 
  jnz IF0

  movzx eax,BYTE ptr [r13 + SDL_SCANCODE_2]
  test eax,eax 
  jnz IF1 

  movzx eax,BYTE ptr [r13 + SDL_SCANCODE_3]
  test eax,eax
  jnz IF6

  movzx eax,BYTE ptr [r13 + SDL_SCANCODE_4]
  test eax,eax
  jnz IF7

  movzx eax,BYTE ptr [r13 + SDL_SCANCODE_5]
  test eax,eax
  jnz IF01

  movzx eax,BYTE ptr [r13 + SDL_SCANCODE_6]
  test eax,eax 
  jnz IF02

  movzx eax,BYTE ptr [r13 + SDL_SCANCODE_7]
  test eax,eax
  jnz IF11 

  movzx eax,BYTE ptr [r13 + SDL_SCANCODE_8]
  test eax,eax
  jnz IF12 
  # init and clamp
  
  jmp IF3

IF01:

  add QWORD ptr [rbp - 24],5 
  jmp IF03 

IF02:

  sub QWORD ptr [rbp - 24],5 
  jmp IF03

IF03:

  cmp QWORD ptr [rbp - 24],255 
  jge IF04
  cmp QWORD ptr [rbp - 24],0 
  jle IF05
  
  jmp IF3

IF04:

  mov QWORD ptr [rbp - 24],255
  jmp IF3 

IF05:

  mov QWORD ptr [rbp - 24],0 
  jmp IF3

IF0:

  add r14d,10 
  jmp IF3

IF1:

  sub r14d,10
  jmp IF3

IF3:

  cmp r14d,255 
  jge IF4
  cmp r14d,0
  jle IF5
  jmp R01

IF4:

  mov r14d,255
  jmp R01

IF5:

  mov r14d,0 
  jmp R01

IF6:

  mov QWORD ptr [rbp - 16],0 
  jmp R01 

IF7:

  mov QWORD ptr [rbp - 16],1 
  jmp R01

IF11:

  add r12d,10 
  jmp IF13 

IF12:

  sub r12d,10 
  jmp IF13

IF13:

  cmp r12d,0 
  jle IF14
  cmp r12d,255 
  jge IF15
  jmp R01

IF14:

  mov r12d,0 
  jmp R01 

IF15:

  mov r12d,255 
  jmp R01

R01:

  mov rdi,QWORD ptr [rip + render_t]
  call SDL_RenderClear

  mov rdi,QWORD ptr [rip + render_t]
  mov esi,r14d
  mov edx,r14d
  mov ecx,r12d
  mov r8d,r12d
  call SDL_SetRenderDrawColor

  lea rdi,[rip + FMT_CL1]
  mov esi,r14d 
  xor eax,eax
  call printf

  lea rdi,[rip + FMT_CL2]
  mov esi,r12d
  xor eax,eax 
  call printf

  lea rbx,[rip + texture_t]
  xor r15,r15
  
R02:

  cmp r15,2 
  jge R04

  mov rdi,QWORD ptr [rbx + r15 * 8]
  mov rsi,QWORD ptr [rbp - 24]
  call SDL_SetTextureAlphaMod
 
  inc r15
  jmp R02

R04:

  cmp QWORD ptr [rbp - 16],0 
  je IF8 
  jnz IF9

IF8:

  mov rdi,QWORD ptr [rip + render_t]
  mov rsi,QWORD ptr [rip + texture_t + 0*8]
  xor rdx,rdx
  xor rcx,rcx
  call SDL_RenderCopy

  jmp R03

IF9:

  mov rdi,QWORD ptr [rip + render_t]
  mov rsi,QWORD ptr [rip + texture_t + 1*8]
  xor rdx,rdx
  xor rcx,rcx
  call SDL_RenderCopy

  jmp R03

R03:

  mov rdi,QWORD ptr [rip + render_t]
  call SDL_RenderPresent

  mov edi,16
  call SDL_Delay

  jmp L01

B01:

  mov rdi,QWORD ptr [rip + window_t]
  call SDL_DestroyWindow

  mov rdi,QWORD ptr [rip + render_t]
  call SDL_DestroyRenderer

  #mov rdi,QWORD ptr [rip + texture_t]
  #call SDL_DestroyTexture

  xor r15,r15
  lea rbx,[rip + texture_t]

FOR1:
  
  cmp r15,2 
  jge IF10

  lea rdi,[rip + FMT_F]
  mov rsi,r15
  lea rdx,[rbx + r15 * 8]
  xor eax,eax
  call printf

  mov rdi,QWORD ptr [rbx + r15 * 8]
  call SDL_DestroyTexture

  # mov rdi,QWORD ptr [rbx + r8 * 8]

  inc r15
  jmp FOR1

IF10:

  call IMG_Quit

  mov eax,0 
  leave
  ret

ER1:

  lea rdi,[rip + L2]
  xor eax,eax
  call printf

  mov eax,1
  leave
  ret
