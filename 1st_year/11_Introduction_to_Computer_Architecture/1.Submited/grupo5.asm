;************************************************************************************
; 				Função de cada tecla
; 0 - diminui o valor nos displays em regime contínuo
; 1 - diminui o valor nos displays uma vez por clique
; 2 - aumenta o valor nos displays uma vez por clique
; 3 - aumenta o valor nos displays em regime contínuo
;
;*************************************************************************************

DISPLAYS   EQU 0A000H   ; endereço dos displays de 7 segmentos (periférico POUT-1)
TEC_LIN    EQU 0C000H   ; endereço das linhas do teclado (periférico POUT-2)
TEC_COL    EQU 0E000H   ; endereço das colunas do teclado (periférico PIN)

delay      EQU 5FFFH    ; quanto maior este valor, mais lentamente o valor nos displays varia em regime contínuo, sendo 1 o mais rápido e, contrário à regra, 0 o mais lento

PLACE 1000H

pilha: TABLE 100H		;cria a pilha para a utilização das rotinas: conversor e reg_continuo
fim_pilha:

PLACE      0

inicio:		
; inicializações
    MOV  R2, TEC_LIN    ; endereço do periférico das linhas
    MOV  R3, TEC_COL    ; endereço do periférico das colunas
    MOV  R4, DISPLAYS   ; endereço do periférico dos displays
	MOV  SP, fim_pilha	; move o step pointer para poder iniciar o registo de mudanças na pilha

;********************************************************************************
; Nos seguintes registos são escritos vários valores utilizados pelo conversor
;********************************************************************************
    MOV  R6, 100
	MOV  R7, 100H
	MOV  R8, 10
	MOV  R9, 10H
	
    MOV  R5, 0
    MOV [R4], R5		; escreve a linha e a coluna a 0 nos displays
	MOV  R5, 1000		; para não haver erro ao subtrair 1 ao valor inicial nos displays, inicia-se o programa com 1000, devido a todos os múltiplos de 1000 serem equivalentes a 0 nos displays
	
; corpo principal do programa

espera_tecla:           ; neste ciclo espera-se até uma tecla ser premida
    MOV  R1, 1          ; testar a linha 1
    MOVB [R2], R1       ; escrever no periférico de saída (linhas)
    MOVB R0, [R3]       ; ler do periférico de entrada (colunas)
    CMP  R0, 1         	; verifica de a tecla 0 está a ser premida
	JZ   a				; quando a tecla 0 for premida executar as linhas do programa denominadas "a"
	CMP  R0, 2			; verifica de a tecla 1 está a ser premida
	JZ   b				; quando a tecla 1 for premida executar as linhas do programa denominadas "b"
	CMP  R0, 4			; verifica de a tecla 2 está a ser premida
	JZ   c				; quando a tecla 2 for premida executar as linhas do programa denominadas "c"
	CMP  R0, 0			; verifica de a tecla 3 está a ser premida
	JNZ  d				; quando a tecla 3 for premida executar as linhas do programa denominadas "d"
    JMP  espera_tecla   ; se nenhuma tecla premida, continua à procura de uma tecla premida

;*********************************************************************************************************************
;Os seguintes conjuntos linhas (a, b, c, d) são executados para alterar o valor hexadecimal a ser convertido
; - a:  diminui o valor em regime contínuo
; - b:  diminui o valor uma vez por clique
; - c:  aumenta o valor uma vez por clique
; - d:  aumenta o valor em regime contínuo
;*********************************************************************************************************************

a:
    SUB  R5, 1			; subtrai uma unidade ao valor hexadecimal
    CALL reg_continuo   ; chama a rotina que provoca o delay entre a mudança de valor
	CMP  R0, 0			; há tecla premida?
	JNZ  a				; continua a diminuir o valor enquanto a tecla for premida
	JMP  espera_tecla	; se a tecla não estiver premida, espera um novo input

b:
    SUB  R5, 1			; subtrai uma unidade ao valor hexadecimal
	JMP por_clique		; executa as linhas do programa denominadas por_clique:
	
c:
    ADD  R5, 1			; aumenta uma unidade ao valor hexadecimal
	JMP por_clique		; executa as linhas do programa denominadas por_clique:

d:
    ADD  R5, 1			; adiciona uma unidade ao valor hexadecimal
    CALL reg_continuo	; chama a rotina que provoca o delay entre a mudança de valor
	CMP  R0, 0			; há tecla premida?
	JNZ  d				; continua a aumentar o valor enquanto a tecla continuar a ser premida
	JMP  espera_tecla	; se a tecla não estiver premida, espera um novo input

por_clique:				;
    CALL conversor		; chama a rotina para converter o valor hexadecimal recebido, em decimal
	MOV  [R4], R1		; escreve o valor em decimal nos displays
loop:
	MOVB R0, [R3]		; lê do periférico de entrada (colunas)
	CMP  R0, 0			; há tecla premida?
	JNZ  loop			; se ainda houver tecla premida, espera até não haver
	JMP  espera_tecla	; se a tecla não estiver premida, espera um novo input

;*******************************************ROTINAS*****************************************************

conversor:				; nesta rotina são convertidos os valores de hexadecimal, utilizados pelo programa, para decimal, que aparecem nos displays
	PUSH R5				
	PUSH R5				
	PUSH R5				; escreve na pilha o valor de hexadecimal a ser convertido
	MOV  R1, 1000		; impede que valores superiores a 999 apareçam nos displays
	
	MOD  R5, R1			;*******************************************************************
    DIV  R5, R6			; Determina o algarimso das centenas do número decimal resultante
	MUL  R5, R7			;
	MOV  R1, R5			;*******************************************************************

    POP  R5				;*******************************************************************
	MOD  R5, R6			; 
	DIV  R5, R8			; Determina o algarimso das dezenas do número decimal resultante
	MUL  R5, R9			; 
	ADD  R1, R5			;*******************************************************************
	
    POP  R5				;*******************************************************************
	MOD  R5, R8			; Determina o algarimso das unidades do número decimal resultante
	ADD  R1, R5			;*******************************************************************
	
	POP  R5				;************************************************************************************************************************************
	CMP  R1, 0			;
	JNZ  jump			; Para não haver erro ao subtrair 1 ao valor inicial nos displays,
	MOV  R5, 1000		; sempre que o valor nos displays for 0, o valor hexadecimal utilizado pelo programa passa para 3E8H (1000 em decimal, 0 nos displays)
jump:					;
	RET					;************************************************************************************************************************************


reg_continuo:			; enquanto a tecla estiver premida, aumenta o valor nos displays
	CALL conversor		; chama a rotina para converter o valor hexadecimal recebido, em decimal
	MOV  [R4], R1		; escreve o valor em decimal nos displays
	MOV  R1, delay		; define o tempo de delay entre mudança de valores quando a tecla se encontra premida
clock:
	SUB  R1, 1			; diminui o valor anterior até 0
	JNZ  clock			; apenas depois do valor anterior chegar a 0, aumentar valor do display em 1 unidade
	MOVB R0, [R3]		; lê do periférico de entrada (colunas)
	RET