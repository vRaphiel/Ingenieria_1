!classDefinition: #MarsRoversTests category: #MarsRovers!
TestCase subclass: #MarsRoversTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 20:36:40'!
test01MarsRoversEnPosicion00

	| marsRovers |
	
	marsRovers := MarsRovers enPosicion: 0@0 apuntaHacia: #N.
	
	marsRovers ejecuta: ''.
	
	self assert: (marsRovers estaEn: 0@0 apuntandoA: #N)
! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/18/2024 01:36:33'!
test02MarsRoversApuntaHaciaNorteYAvanza
	| marsRovers initialPosition |
	initialPosition := 0@0.
	marsRovers := MarsRovers enPosicion: initialPosition apuntaHacia: #N.
	marsRovers ejecuta: 'f'.
	self assert: (marsRovers estaEn: initialPosition + (0@1) apuntandoA: #N).! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/18/2024 01:36:50'!
test03MarsRoversApuntaHaciaNorteYRetrocede

	| marsRovers initialPosition |
	initialPosition := 0@0.
	marsRovers := MarsRovers enPosicion: initialPosition apuntaHacia: #N.
	marsRovers ejecuta: 'b'.
	
	self assert: 	(marsRovers estaEn: (initialPosition - (0@1)) apuntandoA: #N).! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/18/2024 01:46:58'!
test04MarsRoversApuntaHaciaNorteYRotaAIzquierda

	| marsRovers initialPosition |
	initialPosition := 0@0.
	marsRovers := MarsRovers enPosicion: initialPosition apuntaHacia: #N.
	marsRovers ejecuta: 'l'.
	
	self assert: 	(marsRovers estaEn: initialPosition apuntandoA: #O).! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/18/2024 01:47:05'!
test05MarsRoversApuntaHaciaNorteYRotaADerecha

	| marsRovers initialPosition |
	initialPosition := 0@0.
	marsRovers := MarsRovers enPosicion: initialPosition apuntaHacia: #N.
	marsRovers ejecuta: 'r'.
	
	self assert: 	(marsRovers estaEn: initialPosition apuntandoA: #E).! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/18/2024 01:22:32'!
test06MensajeNoReconocidoX

	| marsRovers initialPosition |
	initialPosition := 0@0.
	marsRovers := MarsRovers enPosicion: initialPosition apuntaHacia: #N.

	self 
		should: [ marsRovers ejecuta: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRovers invalidCommandErrorDescription.
			self assert: (marsRovers estaEn: initialPosition apuntandoA: #N) ].! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/18/2024 01:37:40'!
test07MarsRoversApuntaHaciaNorteYAvanzaDosVeces

	| marsRovers initialPosition |
	initialPosition := 0@0.
	marsRovers := MarsRovers enPosicion: initialPosition apuntaHacia: #N.
	marsRovers ejecuta: 'ff'.

	self assert: (marsRovers estaEn: (0@2) apuntandoA: #N).! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/18/2024 01:37:50'!
test08MarsRoversApuntaHaciaEsteYAvanza
	| marsRovers initialPosition |
	initialPosition := 0@0.
	marsRovers := MarsRovers enPosicion: initialPosition apuntaHacia: #E.
	marsRovers ejecuta: 'f'.

	self assert: (marsRovers estaEn: (1@0) apuntandoA: #E).! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/18/2024 01:37:59'!
test09MarsRoversApuntaHaciaEsteYRetrocede
	| marsRovers initialPosition |
	initialPosition := 0@0.
	marsRovers := MarsRovers enPosicion: initialPosition apuntaHacia: #E.
	marsRovers ejecuta: 'b'.

	self assert: (marsRovers estaEn: (-1@0) apuntandoA: #E).! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/18/2024 01:46:30'!
test10MarsRoversApuntaHaciaEsteYRotaAIzquierda
	| marsRovers initialPosition |
	initialPosition := 0@0.
	marsRovers := MarsRovers enPosicion: initialPosition apuntaHacia: #E.
	marsRovers ejecuta: 'l'.

	self assert: (marsRovers estaEn: initialPosition apuntandoA: #N).! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/18/2024 01:46:32'!
test11MarsRoversApuntaHaciaEsteYRotaADerecha
	| marsRovers initialPosition |
	initialPosition := 0@0.
	marsRovers := MarsRovers enPosicion: initialPosition apuntaHacia: #E.
	marsRovers ejecuta: 'r'.

	self assert: (marsRovers estaEn: initialPosition apuntandoA: #S).! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/18/2024 01:48:53'!
test12
	| marsRovers initialPosition |
	initialPosition := 0@0.
	marsRovers := MarsRovers enPosicion: initialPosition apuntaHacia: #S.
	marsRovers ejecuta: 'ffbr'.

	self assert: (marsRovers estaEn: 0@-1 apuntandoA: #O).
! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/18/2024 01:51:45'!
test13

	| marsRovers initialPosition |
	initialPosition := 0@0.
	marsRovers := MarsRovers enPosicion: initialPosition apuntaHacia: #S.
	marsRovers ejecuta: 'l'.
	
	self assert: (marsRovers estaEn: initialPosition apuntandoA: #E)! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/18/2024 01:53:49'!
test14

	| marsRovers initialPosition |
	initialPosition := 0@0.
	marsRovers := MarsRovers enPosicion: initialPosition apuntaHacia: #O.
	marsRovers ejecuta: 'ffbr'.
	
	self assert: (marsRovers estaEn: -1@0 apuntandoA: #N).! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/18/2024 01:54:38'!
test15

	| marsRovers initialPosition |
	initialPosition := 0@0.
	marsRovers := MarsRovers enPosicion: initialPosition apuntaHacia: #O.
	marsRovers ejecuta: 'l'.
	self assert: (marsRovers estaEn: initialPosition apuntandoA: #S)
	
	! !


!classDefinition: #MarsRovers category: #MarsRovers!
Object subclass: #MarsRovers
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRovers methodsFor: 'evaluating' stamp: 'RPH 5/19/2024 20:26:12'!
addToPosition: aPoint 
	 position := position + aPoint ! !

!MarsRovers methodsFor: 'evaluating' stamp: 'RPH 5/18/2024 01:18:07'!
ejecuta: unConjuntoDeInstrucciones
	unConjuntoDeInstrucciones do: [:unaInstruccion | self procesarInstruccion: unaInstruccion 	].! !

!MarsRovers methodsFor: 'evaluating' stamp: 'RPH 5/19/2024 12:39:40'!
estaEn: unaPosicion apuntandoA: unPuntoCardinal

	^position = unaPosicion and: [ heading cardinalPoint = unPuntoCardinal ]! !

!MarsRovers methodsFor: 'evaluating' stamp: 'RPH 5/18/2024 00:10:45'!
posicionActual
	^position.! !

!MarsRovers methodsFor: 'evaluating' stamp: 'RPH 5/19/2024 20:26:49'!
procesarInstruccion: unaInstruccion

	unaInstruccion = $f ifTrue: [^ self addToPosition: heading forwardPoint. ].
	unaInstruccion = $b ifTrue: [^ self addToPosition: heading backwardPoint ].
	unaInstruccion = $l ifTrue: [^heading :=  self class headingFor: heading leftCardinalPoint. ].
	unaInstruccion = $r ifTrue: [^heading := self class headingFor: heading rightCardinalPoint. ].

	self signalInvalidCommand .! !


!MarsRovers methodsFor: 'initialize' stamp: 'RPH 5/19/2024 12:35:24'!
initializeLandsOn: aPosition lookingTo: aDirection
	position := aPosition.
	heading := aDirection.! !


!MarsRovers methodsFor: 'asserting' stamp: 'RPH 5/18/2024 01:17:23'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRovers methodsFor: 'asserting' stamp: 'RPH 5/18/2024 01:19:15'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRovers class' category: #MarsRovers!
MarsRovers class
	instanceVariableNames: 'headings'!

!MarsRovers class methodsFor: 'initialization' stamp: 'RPH 5/19/2024 20:29:21'!
enPosicion: aPosition apuntaHacia: aCardinalPoint

	| newHeading |
	
	newHeading := self headingFor: aCardinalPoint.
	
	 ^ self new initializeLandsOn: aPosition lookingTo: newHeading.! !

!MarsRovers class methodsFor: 'initialization' stamp: 'RPH 5/19/2024 20:29:24'!
headingFor: aCardinalPoint
	
	^ headings at: aCardinalPoint ! !

!MarsRovers class methodsFor: 'initialization' stamp: 'RPH 5/19/2024 20:21:56'!
initialize

	self initializeHeadings! !

!MarsRovers class methodsFor: 'initialization' stamp: 'RPH 5/19/2024 20:43:07'!
initializeHeadings

	headings := Dictionary new.
	
	(OrderedCollection 
		with: (MarsRoversHeading for: #N forwardWith: 0@1 backwardWith: 0@-1 rightCardinalPoint: #E leftCardinalPoint: #O)	
		with: (MarsRoversHeading for: #E forwardWith: 1@0 backwardWith: -1@0 rightCardinalPoint: #S leftCardinalPoint: #N)
		with: (MarsRoversHeading for: #S forwardWith: 0@-1 backwardWith: 0@1 rightCardinalPoint: #O leftCardinalPoint: #E)
		with: (MarsRoversHeading for: #O forwardWith: -1@0 backwardWith: 1@0 rightCardinalPoint: #N leftCardinalPoint: #S))
			do: [ :heading | headings at: heading cardinalPoint put: heading ]! !


!classDefinition: #MarsRoversHeading category: #MarsRovers!
Object subclass: #MarsRoversHeading
	instanceVariableNames: 'cardinalPoint backwardPoint forwardPoint lookingLeft lookingRight'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!


!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 20:13:35'!
backwardPoint
	
	^backwardPoint.! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 20:13:39'!
cardinalPoint
	^cardinalPoint.! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 20:13:44'!
forwardPoint
	^forwardPoint.! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 20:45:14'!
initializeFor: aCardinalPoint forwardWith: aForwardPoint backwardWith: aBackwardPoint rightCardinalPoint: aRightCardinalPoint leftCardinalPoint: aLeftCardinalPoint
	cardinalPoint := aCardinalPoint.
	forwardPoint := aForwardPoint.
	backwardPoint := aBackwardPoint.
	lookingRight := aRightCardinalPoint.
	lookingLeft := aLeftCardinalPoint ! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 20:13:49'!
lookingLeft
	^lookingLeft.! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 20:13:56'!
lookingRight
	^lookingRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoversHeading class' category: #MarsRovers!
MarsRoversHeading class
	instanceVariableNames: ''!

!MarsRoversHeading class methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 20:14:30'!
for: aCardinalPoint forwardWith: aForwardPoint backwardWith: aBackwardPoint rightCardinalPoint: rightCardinalPoint leftCardinalPoint: leftCardinalPoint

	^self new initializeFor: aCardinalPoint forwardWith: aForwardPoint backwardWith: aBackwardPoint rightCardinalPoint: rightCardinalPoint leftCardinalPoint: leftCardinalPoint
	! !


!classDefinition: #MarsRoversHeadingEste category: #MarsRovers!
Object subclass: #MarsRoversHeadingEste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRoversHeadingEste methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:19:36'!
backwardPoint
	
	^-1@0! !

!MarsRoversHeadingEste methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:29:06'!
cardinalPoint
	^#E.! !

!MarsRoversHeadingEste methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:19:32'!
forwardPoint
	
	^1@0! !

!MarsRoversHeadingEste methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:36:41'!
lookingLeft
	
	^MarsRoversHeadingNorte.! !

!MarsRoversHeadingEste methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:36:50'!
lookingRight
	
	^MarsRoversHeadingSur.! !


!classDefinition: #MarsRoversHeadingNorte category: #MarsRovers!
Object subclass: #MarsRoversHeadingNorte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRoversHeadingNorte methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:12:31'!
backwardPoint
	
	^0@-1! !

!MarsRoversHeadingNorte methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:29:11'!
cardinalPoint
	^#N.! !

!MarsRoversHeadingNorte methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:09:56'!
forwardPoint
	
	^0@1! !

!MarsRoversHeadingNorte methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:36:59'!
lookingLeft
	
	^MarsRoversHeadingOeste.! !

!MarsRoversHeadingNorte methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:37:07'!
lookingRight
	
	^MarsRoversHeadingEste.! !


!classDefinition: #MarsRoversHeadingOeste category: #MarsRovers!
Object subclass: #MarsRoversHeadingOeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRoversHeadingOeste methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:21:54'!
backwardPoint
	
	^1@0! !

!MarsRoversHeadingOeste methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:29:14'!
cardinalPoint
	^#O.! !

!MarsRoversHeadingOeste methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:21:50'!
forwardPoint
	
	^-1@0! !

!MarsRoversHeadingOeste methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:37:16'!
lookingLeft
	
	^MarsRoversHeadingSur.! !

!MarsRoversHeadingOeste methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:37:29'!
lookingRight
	
	^MarsRoversHeadingNorte.! !


!classDefinition: #MarsRoversHeadingSur category: #MarsRovers!
Object subclass: #MarsRoversHeadingSur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRoversHeadingSur methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:21:22'!
backwardPoint
	
	^0@1! !

!MarsRoversHeadingSur methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:29:18'!
cardinalPoint
	^#S.! !

!MarsRoversHeadingSur methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:21:28'!
forwardPoint
	
	^0@-1! !

!MarsRoversHeadingSur methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:37:37'!
lookingLeft
	
	^MarsRoversHeadingEste.! !

!MarsRoversHeadingSur methodsFor: 'as yet unclassified' stamp: 'RPH 5/19/2024 12:37:44'!
lookingRight
	
	^MarsRoversHeadingOeste.! !

MarsRovers initialize!