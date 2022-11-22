<CsoundSynthesizer>

;############################################################################
; STRUMENTO CON CONTROLLO RANDOMICO DEI RAPPORTI
;############################################################################

<CsOptions>

;############################################################################
; OPZIONI EXPORT
;############################################################################

-o 05_fm.wav -W 

</CsOptions>


<CsInstruments>

;############################################################################
; VEDI PAGINA 216 LA MUSICA ELETTRONCIA PDF
;############################################################################

sr = 44100
nchnls = 1
0dbfs  = 1

;############################################################################
; DEFINE FORSE DA IMPLEMENTARE IN SCORE
;############################################################################

; RANGE DEVIAZIONE, NUMERO ARMONICI
#define RANGE #20#
; RANDOM IP/IM SPEED, CHANGES THE VALUE OF IP AND IM
#define RAPSPEED #10#
; INTORNO FREQ CENTR
#define BWCEN #20#
; SPEED OF BW CHANGE
#define BWSPEED #10#


;############################################################################
; IMPLEMENTARE SCHEDULE
;############################################################################

instr 1

iAmp    =   ampdb(p4)

; DEVIAZIONE FREQUENZA BASE
iFreqBase   =   p5

kFreqBW randi $BWCEN / 2, $BWSPEED

; frequenza base con intorno 
kFreqBase = iFreqBase + kFreqBW


;kPortante = p6  * kFreqBase

; RANGE INTERVALLO IP
kPortante   randi p6,   $RAPSPEED
kPortante = p6 * kFreqBase 
printk 1, kPortante

;kModulante = p7 * kFreqBase

; RANGE INTERVALLO IM
kModulante  randi p7,   $RAPSPEED
kModulante = p7 * kFreqBase
printk 1, kModulante

; Velocita cambio rapporti di modulazione
iVariationSpeed = p8

; VALORI MODULAZIONE
kDev    randi    $RANGE, iVariationSpeed

; MODULANTE
aMod	poscil	kDev + $RANGE,	kModulante	; MODULANTE

; ENV
aEnv 	linen	iAmp,	.1,	p3,	.1

; PORTANTE
aOut	poscil	aEnv, kPortante +   aMod	; PORTANTE

    out aOut

;schedule(1, 5, 10, -12,1200 , 2, 1, 1000)

endin

</CsInstruments>

<CsScore>

;############################################################################
; FUNCTION 
;############################################################################
f1 0 32768 10 1

;############################################################################
; SCORE
;############################################################################
;p1	    p2	    p3	p4      p5	    p6          P7          P8
;INSTR	START	DUR	AMP     FR.BAS	Port Range	Mod Range   Speed rapporti mod
;                           CENTRO
i1      0       5   -12     440     1          2           10
e

</CsScore>

</CsoundSynthesizer>
