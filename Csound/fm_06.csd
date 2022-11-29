<CsoundSynthesizer>

;############################################################################
; STRUMENTO CON CONTROLLO RANDOMICO FREQ CENTRALE E RAPPORTI IM IP
; E INDEX MODUL
; !!!!! add tonex? !!!!
;############################################################################

<CsOptions>

;############################################################################
; OPZIONI EXPORT
;############################################################################

-o 06_fm.wav -W 

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
; RIPETIZIONI LETTURA FTABLE PER ENV
#define ENVSPEED #1#

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
kDev line 0 , p3, p8

; MODULANTE
aMod	poscil3	kDev * kModulante ,	kModulante

; ENV
iFnEnv  =   p9

kRep init  $ENVSPEED / p3  ; Ripetizione lettura

kIndex phasor kRep 

kEnv 	tablei kIndex, iFnEnv, 1

; PORTANTE
aOut	poscil3	kEnv, kPortante +   aMod

    out aOut

endin

</CsInstruments>

<CsScore>

;############################################################################
; FUNCTION 
;############################################################################
;   P1      P2      P3      P4     P5
;   NUMBER  START   SIZE    GEN    ARG
    f1      0       32768    10     1                                   ;sine
;                                   BREAK POINT, START AT PX
;                                   IN PY GOES TO PZ
;                                     | ATTACK  | DECAY  | SUSTAIN | RELEASE
;                                     |         |        |         |         
;                                     |         |        |         |         
;                                     |         |        |         |         
;                                     |         |        |         |         
    f2      0       32768    7    0.  8192  0.8  8192 0.5  8192 0.2  8192 0.
;############################################################################
; SCORE
;############################################################################
;p1	    p2	    p3	    p4      p5	        p6        P7          P8       P9
;INSTR	START	DUR	    AMP     FR.BAS	    FR        FR          DEV      ENV
;                               CENTRO      PORT      MODUL       TARGET   TYP
i1      0       5       -12     440         1         2           2        2
i1      +       .       .       .           .         .           1        .
i1      +       .       .       .           1         2           10       .
i1      +       .       .       .           1         2           2        .
i1      +       .       .       .           2.5       4           5        .
i1      +       .       .       .           3         2.5         .        .
e

</CsScore>

</CsoundSynthesizer>
