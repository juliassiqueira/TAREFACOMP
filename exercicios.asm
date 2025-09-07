; =====================================================
; EXERCÍCIOS DE ASSEMBLY
; Júlia Siqueira
; =====================================================

; =========================
; 1) Sub-rotinas para zerar registradores
; =========================

; Zera registrador A
ZERA_A:
    LDA #0
    RET

; Zera registrador B
ZERA_B:
    LDB #0
    RET

; Zera registrador X
ZERA_X:
    LDX #0
    RET

; Zera todos os registradores
ZERA_TODOS:
    CALL ZERA_A
    CALL ZERA_B
    CALL ZERA_X
    RET

; =========================
; 2) Soma de duas variáveis com detecção de overflow
; =========================

; --- 8 bits ---
VAR1: DB 14h
VAR2: DB 25h
RESULT: DB 0
OVERFLOW: DB 0

SOMA_8BITS:
    LDA VAR1
    ADD VAR2
    JNC SEM_OVERFLOW
    LDA #0FFh
    STA OVERFLOW
    JMP SALVAR
SEM_OVERFLOW:
    LDA #0
    STA OVERFLOW
SALVAR:
    STA RESULT
    RET

; --- 16 bits ---
VAR16_1: DW 1234h
VAR16_2: DW 2345h
RESULT16: DW 0
OVER16: DB 0

SOMA_16BITS:
    LDA VAR16_1      ; parte baixa
    ADD VAR16_2
    STA RESULT16
    JNC CHECK_HIGH
    LDA #0FFh
    STA OVER16
CHECK_HIGH:
    LDA VAR16_1+1    ; parte alta
    ADC VAR16_2+1
    STA RESULT16+1
    RET

; =========================
; 3) Limpeza de área de memória (n posições)
; =========================
START_ADDR: DW 2000h
N: DB 10

LIMPA_MEMORIA:
    LDX START_ADDR
    LDA #0
LOOP:
    STA (X)
    INX
    DEC N
    JNZ LOOP
    RET

; =========================
; 4) Comparar três variáveis
; =========================
VAR_A: DB 10
VAR_B: DB 20
VAR_C: DB 15

COMPARA_3:
    LDA VAR_A
    CMP VAR_B
    JC A_MENOR_B
    ; A >= B
A_MENOR_B:
    LDA VAR_A
    CMP VAR_C
    JC A_MENOR_C
    ; resto do código
    RET

; =========================
; 5) Transformação de números
; =========================
NUM: DB 5

; Complemento de 2
TO_COMPLEMENTO2:
    NOT NUM
    ADD #1
    RET

; Sinal-Magnitude (ex: se negativo, MSB=1)
TO_SINAL_MAG:
    ; Para positivos nada muda
    ; Para negativos: NUM = abs(NUM) | 80h
    RET

; =========================
; 6) Escrever nome em ASCII
; =========================
NOME_POS: DW 3000h
NOME:
    DB "JULIA SIQUEIRA",0

ESCREVE_NOME:
    LDX NOME_POS
    LDY NOME
LOOP_NOME:
    LDA (Y)
    BEQ FIM
    STA (X)
    INX
    INY
    JMP LOOP_NOME
FIM:
    RET

; =========================
; 7) Multiplicação de dois números positivos
; =========================
MUL_A: DB 5
MUL_B: DB 3
MUL_RESULT: DB 0

MULTIPLICA:
    LDA #0
    STA MUL_RESULT
    LDX MUL_B
LOOP_MUL:
    CMP #0
    BEQ FIM_MUL
    LDA MUL_RESULT
    ADD MUL_A
    STA MUL_RESULT
    DEC MUL_B
    JMP LOOP_MUL
FIM_MUL:
    RET
