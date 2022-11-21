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

instr 1

iAmp    =   ampdb(p4)

iFreqBase   =   p5
iPortante   =   p6  *   iFreqBase
iModulante  =   p7  *   iFreqBase
iModulStart =   p8
iModulEnd   =   p9

; ANDAMENTO MODULAZIONE
kIndxModul line  p8,    p3,    p9 

; VALORI MODULAZIONE
kDev    =   kIndxModul   *   iModulante

; MODULANTE
aMod	poscil	kDev,	iModulante	; MODULANTE

; ENV
aEnv 	linen	iAmp,	.1,	p3,	.1

; PORTANTE
aOut	poscil	aEnv, iPortante +   aMod	; PORTANTE

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
;p1	    p2	    p3	p4      p5	    p6      P7      P8          P9
;INSTR	START	DUR	AMP     FR.BASE	IPORT	IMOD    Modul Start Modul End
i1      0       5   -12     440     2       1       1           10           
e

</CsScore>

</CsoundSynthesizer>
