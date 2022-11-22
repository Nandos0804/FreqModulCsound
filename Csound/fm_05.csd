<CsoundSynthesizer>

;############################################################################
; STRUMENTO CON CONTROLLO RANDOMICO DEI RAPPORTI, FREQ CENTRALE E INDICE MOD
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
; INTORNO FREQ CENTR
#define BWCEN #20#
; SPEED OF BW CHANGE
#define BWSPEED #10#
; VARIZIONE OF IM IP
#define PMSPEED #10#

;############################################################################
; IMPLEMENTARE SCHEDULE
;############################################################################

instr 1

iAmp        =   ampdb(p4)

; DEVIAZIONE FREQUENZA BASE
iFreqBase   =   p5

kFreqBW randi $BWCEN / 2, $BWSPEED

; frequenza base con intorno 
kFreqBase = iFreqBase + kFreqBW

; VARIAZIONI
kVarPor randi p6, $PMSPEED, 0, 0, p6
printk 1, kVarPor
kVarMod randi p7, $PMSPEED, 0, 0, p7
printk 1, kVarMod

; Relazione a frequenza e variazione, forse +
kPortante =  kVarPor + kFreqBase 
kModulante = kVarMod + kFreqBase 

; Velocita cambio rapporti di modulazione
kDev = p8

; MODULANTE
aMod	poscil	kDev * kModulante ,	kModulante

; ENV
aEnv 	linen	iAmp,   .1, p3,	.1

; PORTANTE
aOut	poscil	aEnv, kPortante +   aMod

    out aOut

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
;p1	    p2	    p3	    p4      p5	        p6        P7          P8
;INSTR	START	DUR	    AMP     FR.BAS	    FR        FR          DEV
;                               CENTRO      PORT      MODUL
i1      0       5       -12     440         1         2           0
i1      +       .       .       .           .         .           1
i1      +       .       .       .           1         2           10
i1      +       .       .       .           1         2           2
i1      +       .       .       .           2.5       4           5
i1      +       .       .       .           3         2.5         .
e


</CsScore>

</CsoundSynthesizer>
