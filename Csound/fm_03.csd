<CsoundSynthesizer>

;############################################################################
; STRUMENTO CON CONTROLLO DI INDICE DI MODULAZIONE, E ASSEGNAZIONE VALORE
; RAPPORTI PORTANTE E MODULANTE
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
ksmps = 32
nchnls = 1
0dbfs  = 1

;############################################################################
;
;############################################################################

#define RANGE #1000#

instr 1

iAmp    =   ampdb(p4)

iFreqBase   =   p5
iPortante   =   p6  *   iFreqBase
iModulante  =   p7  *   iFreqBase
iVariationSpeed = p8

; VALORI MODULAZIONE
kDev    randi    $RANGE, iVariationSpeed

; MODULANTE
aMod	poscil	kDev + $RANGE,	iModulante	; MODULANTE

; ENV
aEnv 	linen	iAmp,	.1,	p3,	.1

; PORTANTE
aOut	poscil	aEnv, iPortante +   aMod	; PORTANTE

    out aOut

schedule(1, 5, 10, -12,1200 , 2, 1, 1000)

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
;p1	    p2	    p3	p4      p5	    p6      P7      P8
;INSTR	START	DUR	AMP     FR.BASE	IPORT	IMOD    Speed
i1      0       5   -12     440     5.5       1     2000
e

</CsScore>

</CsoundSynthesizer>
