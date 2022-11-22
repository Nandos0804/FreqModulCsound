<CsoundSynthesizer>

;############################################################################
; INTORNO FREQ BASE
;############################################################################

<CsOptions>

;############################################################################
; OPZIONI EXPORT
;############################################################################

-o 03_fm.wav -W 

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

; LARGHEZZA BANDA
#define BWCEN #20#
; SPEED OF BW CHANGE
#define BWSPEED #10#


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

kPortante = p6 * kFreqBase 

kModulante = p7 * kFreqBase

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
i1      0       5       -12     440         2         1           0
i1      +       .       .       .           .         .           1
i1      +       .       .       .           .         .           10
i1      +       .       .       .           1         2           2
i1      +       .       .       .           2.5       4           5
i1      +       .       .       .           3         2.5         .

e

</CsScore>

</CsoundSynthesizer>
