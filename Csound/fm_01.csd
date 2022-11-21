<CsoundSynthesizer>

;############################################################################
; LA MUSICA ELETTRONICA 
; PDF PAGINA 216
;############################################################################

<CsOptions>

;############################################################################
; OPZIONI EXPORT
;############################################################################

-o 01_fm.wav -W 

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

idur	=	p3		; DURATA
iamp	=	ampdb(p4)	; AMPIEZZA PORTANTE
ipfrq	=	p5		; FREQ PORT
iindx	=	p6		; INDEX
imfrq	=	p7		; FREQ MODULANTE
ifp	=	1		; RAPPORTO 
ifm	=	1		; RAPPORTO

ipd	=	iindx	*	imfrq 	; DEVIAZIONE

; MODULANTE
amod	oscili	ipd,	imfrq,	ifm	; MODULANTE

; ENV
aenv 	linen	iamp,	.1,	idur,	.1

; PORTANTE
a1	oscili	aenv, ipfrq	+	amod,	ifp	; PORTANTE

	out a1

endin


;############################################################################
;
;############################################################################

instr 2

iamp 	=	ampdb(p4)
if0	=	p5	; FREQ BASE
ip	=	p6	; MOLTIPLICATORE PORTANTE
im	=	p7	; MOLTIPLICATORE MODULANTE
iindx	=	p8	; INDICE MODUL

; ENVELOPE
aenv 	linen	iamp,	.1,	p3,	.1

; OUT CON FOSCILI
a1	foscili	aenv,	if0,	ip,	im,	iindx,	1,	1

	out 	a1

endin

;############################################################################
;
;############################################################################
instr 3

iamp 	= 	ampdb(p4)  
if0 	=  	p5	; FREQUENZA BASE
ip	=  	p6	; MOLT PORTANTE
im 	=	p7	; MOLT MODULANTE


kindx 	line 	0,	p3,	44

aenv 	linen	iamp,	.1,	p3,	.1

a1 	foscili	aenv,	if0,	ip,	im,	kindx,	1,	1

	out a1


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

;P1	P2	P3	P4	P5	P6	P7
;INSTR	START	DUR	AMP	IPFRQ	INDX	MODULFRQ
i1 	0	1	-12	2000	0	440	; solo portate
i1	+	.	.	.	.5	.	; 3 parziali
i1	+	.	.	.	1.5	.	; 5 parziali
i1	+	.	.	.	2.5	.	; 7 parziali
i1	+	.	.	.	3.5	.	; 8 parziali
s

;P1	P2	P3	P4	P5	P6	P7	P8
;INSTR	START	DUR	AMP	if0	ip	im	indx

; se im è 1, lo spettro contiene tutti gli armonici
i2	0	1	-12	200	1	1	1
i2	+	.	.	.	2	.	.
; se ip è dispari, compaiono soltanto armonici dispari 
i2	+	.	.	.	3	.	.
i2	+	.	.	.	5	.	.
; se im è 3, mancano i terzi armonici
i2	+	.	.	.	2	3	.
i2	+	.	.	.	4	.	.
i2	+	.	.	.	6	.	.
; se % != 0 di ip/im spettro inarmonico
i2	+	.	.	.	3	5	.
i2	+	.	.	.	6	3	.
 
s

;P1	P2	P3	P4	P5	P6	P7
;INSTR	START	DUR	AMP	if0	ip	im

i3	0	1	-12	440	1	1
e

</CsScore>

</CsoundSynthesizer>
