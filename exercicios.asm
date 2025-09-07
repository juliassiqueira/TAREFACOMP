; =====================================================
; EXERCÍCIOS DE ASSEMBLY
; Júlias e Bia
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
    STA RESULT         ; Salva resultado da soma antes de qualquer alteração
    JNC SEM_OVERFLOW
    LDA #0FFh
    STA OVERFLOW
    RET
SEM_OVERFLOW:
    LDA #0
    STA OVERFLOW
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
; Limpeza de área de memória (n posições)
START_ADDR: DW 2000h
N: DB 10

LIMPA_MEMORIA:
    LDX START_ADDR   ; Endereço inicial
    LDB N            ; Carrega N em B (contador)
    LDA #0
LOOP_LIMPA:
    STA (X)          ; Zera posição
    INX              ; Avança endereço
    DEC B            ; Decrementa contador
    JNZ LOOP_LIMPA   ; Repete até B == 0
    RET

; =========================
; 4) Comparar três variáveis
; =========================
VAR_A: DB 10
VAR_B: DB 20
VAR_C: DB 15
MAIOR: DB 0

COMPARA_3:
    LDA VAR_A     ; A = VAR_A
    CMP VAR_B
    JC SEGUNDO    ; Se A < B, vai para SEGUNDO
    ; A >= B
    LDB VAR_A     ; B = A (até aqui, A é maior)
    JMP TERCEIRO

SEGUNDO:
    LDB VAR_B     ; B = B (B é maior)

TERCEIRO:
    LDA VAR_C
    CMP B
    JC FINAL      ; Se C < B, B é maior
    ; C >= B
    LDB VAR_C     ; B = C (C é maior)
FINAL:
    STB MAIOR     ; Salva maior valor em MAIOR
    RET

; =========================
; 5) Transformação de números
; =========================
NUM: DB 5
COMP2: DB 0

TO_COMPLEMENTO2:
    LDA NUM
    NOT A
    ADD #1
    STA COMP2     ; Salva resultado em COMP2
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
MULTIPLICA:
    LDA #0
    STA MUL_RESULT
    LDA MUL_B
LOOP_MUL:
    CMP #0
    BEQ FIM_MUL
    LDA MUL_RESULT
    ADD MUL_A
    STA MUL_RESULT
    LDA MUL_B
    DEC A
    STA MUL_B
    JMP LOOP_MUL
FIM_MUL:
    RET


