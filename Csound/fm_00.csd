<CsoundSynthesizer>

;############################################################################
; in sintesi fm, la frequenza portante varia per mezzo della frequenza
; modulante che impone una deviazione di picco. Le deviazioni
; sottraggono energia alla portante, generando un numero crescente
; di frequenze laterali. la larghezza di banda ottenuta e uguale a
; 2(deviazione di picco + modulante)
;############################################################################

<CsOptions>

;############################################################################
; OPZIONI EXPORT
;############################################################################

-o 00_fm.wav -W 

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

ifp	=	p4	; CENTRAL FREQUENCY
iindx	=	p5	; INDEX FACTOR, (NUMBER OF HARMONIC)
ifm	=	p6	; MODULATING FREQUENCY

idev	=	iindx	*	ifm

; ENV.
aenv	cosseg 	0,	0.01,	1, p3 - 0.02, 1,	0.01, 0

; MODULATION
amod	poscil	idev,	ifm,	1

; OUT
asig	poscil	aenv,	ifp	+	amod,	1

	out asig

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
;p1	p2	p3	p4	p5	p6
;INSTR	START	DUR	FR.CEN	INDEX	FR.MOD
i1	0	5	440	1	220	; INCREASING INDEX GIVES
						; MORE HARMONIC
i1	+	.	.	2	.	

i1	+	.	.	4	.

i1	+	.	.	1	230	; IF % OF FR.CEN / FR.MOD != INT
						; UNHARMONIC SPECTRUM
i1	+	.	.	2	.	; WILL BE GENERATED

i1	+	.	.	4	.
e

</CsScore>

</CsoundSynthesizer>
