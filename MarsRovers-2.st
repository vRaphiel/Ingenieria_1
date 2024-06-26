!classDefinition: #MarsRoversTests category: #MarsRovers!
TestCase subclass: #MarsRoversTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 19:39:28'!
test01createMarsRoversHeadingNorth

	| marsRovers |
	
	marsRovers := MarsRovers at: 1@0 heading: 'N'.
	
	marsRovers process: ''.

	self assert: (marsRovers isAt: 1@0 heading: 'N').! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:01:18'!
test02marsRoversForwardNorth

	| marsRovers |
	
	marsRovers := MarsRovers at: 0@1 heading: 'N'.
	
	marsRovers process: 'f'.

	self assert: (marsRovers isAt: 0@2 heading: 'N').! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:01:29'!
test03marsRoversBackwardsNorth

	| marsRovers |
	
	marsRovers := MarsRovers at: 0@1 heading: 'N'.
	
	marsRovers process: 'b'.

	self assert: (marsRovers isAt: 0@0 heading: 'N').! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 19:40:36'!
test04marsRoversHeadingNorthRotateLeft

	| marsRovers |
	
	marsRovers := MarsRovers at: 1@0 heading: 'N'.
	
	marsRovers process: 'l'.

	self assert: (marsRovers isAt: 1@0 heading: 'W').! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 19:40:41'!
test05marsRoversHeadingNorthRotateRight

	| marsRovers |
	
	marsRovers := MarsRovers at: 1@0 heading: 'N'.
	
	marsRovers process: 'r'.

	self assert: (marsRovers isAt: 1@0 heading: 'E').! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 19:45:23'!
test06marsRoversNotContinueOnErrorCommand

	| marsRovers |
	
	marsRovers := MarsRovers at: 1@0 heading: 'N'.
	
	self 
		should: [marsRovers process: 'x']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRovers invalidCommandException.
			self assert: (marsRovers isAt: 1@0 heading: 'N').
		].! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:04:23'!
test07marsRoversAcceptMultipleInstructions

	| marsRovers |
	
	marsRovers := MarsRovers at: 0@1 heading: 'N'.
	
	marsRovers process: 'ff'.

	self assert: (marsRovers isAt: 0@3 heading: 'N').! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:05:54'!
test08marsRoversForwardEast

	| marsRovers |
	
	marsRovers := MarsRovers at: 0@1 heading: 'E'.
	
	marsRovers process: 'f'.

	self assert: (marsRovers isAt: 1@1 heading: 'E').! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:12:18'!
test09marsRoversBackwardsEast

	| marsRovers |
	
	marsRovers := MarsRovers at: 0@1 heading: 'E'.
	
	marsRovers process: 'b'.

	self assert: (marsRovers isAt: -1@1 heading: 'E').! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:12:43'!
test10marsRoversHeadingEastRotateLeft

	| marsRovers |
	
	marsRovers := MarsRovers at: 1@0 heading: 'E'.
	
	marsRovers process: 'l'.

	self assert: (marsRovers isAt: 1@0 heading: 'N').! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:13:13'!
test11marsRoversHeadingEastRotateRight

	| marsRovers |
	
	marsRovers := MarsRovers at: 1@0 heading: 'E'.
	
	marsRovers process: 'r'.

	self assert: (marsRovers isAt: 1@0 heading: 'S').! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/24/2024 00:28:56'!
test12marsRoversAcceptMultiplesInstructions2

	| marsRovers |
	
	marsRovers := MarsRovers at: 1@2 heading: 'S'.
	
	marsRovers process: 'ffbr'.

	self assert: (marsRovers isAt: 1@1 heading: 'W').! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/24/2024 00:29:02'!
test13marsRoversBackwardsSouth

	| marsRovers |
	
	marsRovers := MarsRovers at: 1@0 heading: 'S'.
	
	marsRovers process: 'l'.

	self assert: (marsRovers isAt: 1@0 heading: 'E').! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:32:19'!
test14marsRoversMultiplesInstruction3

	| marsRovers |
	
	marsRovers := MarsRovers at: 1@2 heading: 'W'.
	
	marsRovers process: 'ffbr'.

	self assert: (marsRovers isAt: 0@2 heading: 'N').! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:36:42'!
test15marsRoversHeadingWestRotateLeft

	| marsRovers |
	
	marsRovers := MarsRovers at: 1@2 heading: 'W'.
	
	marsRovers process: 'l'.

	self assert: (marsRovers isAt: 1@2 heading: 'S').! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'RPH 6/24/2024 00:44:33'!
test16marsRoversPointToInvalidCardinal

	self 
		should: [ MarsRovers at: 1@2 heading: 'x']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: MarsRovers invalidCardinalPointErrorDescription equals: anError messageText].! !


!classDefinition: #MarsRovers category: #MarsRovers!
Object subclass: #MarsRovers
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRovers methodsFor: 'as yet unclassified' stamp: 'RPH 6/24/2024 00:30:53'!
addToPosition: aPoint 
	
	 position := position + aPoint ! !


!MarsRovers methodsFor: 'initialization' stamp: 'RPH 6/23/2024 21:01:18'!
initializeAt: aPosition heading: aMarsRoversHeading

	position := aPosition.
	heading := aMarsRoversHeading.! !


!MarsRovers methodsFor: 'moving' stamp: 'RPH 6/24/2024 00:55:27'!
moveBackward
	position := position - heading forwardPoint.! !

!MarsRovers methodsFor: 'moving' stamp: 'RPH 6/24/2024 00:55:43'!
moveForward
	position := position + heading forwardPoint ! !


!MarsRovers methodsFor: 'processing' stamp: 'RPH 6/23/2024 19:45:46'!
invalidCommandException
	^ 'Invalid command'! !

!MarsRovers methodsFor: 'processing' stamp: 'RPH 6/23/2024 20:02:27'!
process: aSequenceOfCommands
	aSequenceOfCommands do: [ :aCommand | self processCommand: aCommand].
! !

!MarsRovers methodsFor: 'processing' stamp: 'RPH 6/24/2024 00:51:20'!
processCommand: aCommand

	(self isForwardCommand: aCommand ) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand ) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !

!MarsRovers methodsFor: 'processing' stamp: 'RPH 6/24/2024 00:18:28'!
signalInvalidCommand
	self error: self invalidCommandException.! !


!MarsRovers methodsFor: 'rotating' stamp: 'RPH 6/24/2024 01:02:51'!
rotateLeft
	heading := heading leftHeading.! !

!MarsRovers methodsFor: 'rotating' stamp: 'RPH 6/24/2024 01:02:43'!
rotateRight
	heading := heading rightHeading.! !


!MarsRovers methodsFor: 'rotating - private' stamp: 'RPH 6/24/2024 01:03:07'!
newHeadingFor: aCardinalPoint
	heading := self class headingFor: aCardinalPoint.! !


!MarsRovers methodsFor: 'testing' stamp: 'RPH 6/23/2024 21:03:46'!
isAt: aPosition heading: aCardinalPoint
	^ aPosition = position and: [heading cardinalPoint = aCardinalPoint ].! !

!MarsRovers methodsFor: 'testing' stamp: 'RPH 6/24/2024 00:49:11'!
isBackwardCommand: aCommand
	^aCommand = $b.! !

!MarsRovers methodsFor: 'testing' stamp: 'RPH 6/24/2024 00:48:53'!
isForwardCommand: aCommand
	^aCommand = $f.! !

!MarsRovers methodsFor: 'testing' stamp: 'RPH 6/24/2024 00:49:53'!
isRotateLeftCommand: aCommand
	^aCommand = $l.! !

!MarsRovers methodsFor: 'testing' stamp: 'RPH 6/24/2024 00:49:37'!
isRotateRightCommand: aCommand
	^aCommand = $r.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRovers class' category: #MarsRovers!
MarsRovers class
	instanceVariableNames: 'headings'!

!MarsRovers class methodsFor: 'instance creation' stamp: 'RPH 6/24/2024 00:18:49'!
at: aPosition heading: aCardinalPoint

	| newHeading |
	
	newHeading := self headingFor: aCardinalPoint.
	
	^self new initializeAt: aPosition heading: newHeading.! !

!MarsRovers class methodsFor: 'instance creation' stamp: 'RPH 6/24/2024 00:42:44'!
headingFor: aCardinalPoint

	^ headings at: aCardinalPoint ifAbsent: [ self error: self invalidCardinalPointErrorDescription ].
	
	! !

!MarsRovers class methodsFor: 'instance creation' stamp: 'RPH 6/23/2024 23:11:51'!
initialize

	self initializeHeadings! !

!MarsRovers class methodsFor: 'instance creation' stamp: 'RPH 6/24/2024 21:57:47'!
initializeHeadings

	headings := Dictionary new.
	
	(OrderedCollection 
		with: (MarsRoversHeading for: 'N' forwardWith: 0@1)
		with: (MarsRoversHeading for: 'E' forwardWith: 1@0)
		with: (MarsRoversHeading for: 'S' forwardWith: 0@-1)
		with: (MarsRoversHeading for: 'W' forwardWith: -1@0)
	)
		do: [: heading | headings at: heading cardinalPoint put: heading].
			

	(headings at: 'N') leftHeading: (headings at: 'W') rightHeading: (headings at: 'E').
	(headings at: 'S') leftHeading: (headings at: 'E') rightHeading: (headings at: 'W').
	(headings at: 'E') leftHeading: (headings at: 'N') rightHeading: (headings at: 'S').
	(headings at: 'W') leftHeading: (headings at: 'S') rightHeading: (headings at: 'N').! !

!MarsRovers class methodsFor: 'instance creation' stamp: 'RPH 6/24/2024 00:42:55'!
invalidCardinalPointErrorDescription
	^ 'Invalid cardinal point'! !


!classDefinition: #MarsRoversHeading category: #MarsRovers!
Object subclass: #MarsRoversHeading
	instanceVariableNames: 'cardinalPoint forwardPoint leftHeading rightHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:47:13'!
backwardPoint
	^ backwardPoint.! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:47:17'!
cardinalPoint
	^ cardinalPoint.! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:47:21'!
forwardPoint
	^ forwardPoint.! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 6/24/2024 00:57:39'!
initializeFor: aCardinalPoint forwardWith: aForwardPoint
	cardinalPoint := aCardinalPoint.
	forwardPoint := aForwardPoint.! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:47:07'!
initializeFor: aCardinalPoint forwardWith: aForwardPoint backwardWith: aBackwardPoint rightCardinalPoint: aRightCardinalPoint leftCardinalPoint: aLeftCardinalPoint 
	cardinalPoint := aCardinalPoint.
	forwardPoint := aForwardPoint.
	backwardPoint := aBackwardPoint.
	rightCardinalPoint := aRightCardinalPoint.
	leftCardinalPoint := aLeftCardinalPoint.! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 6/24/2024 00:56:34'!
initializeFor: aCardinalPoint forwardWith: aForwardPoint rightCardinalPoint: aRightCardinalPoint leftCardinalPoint: aLeftCardinalPoint 
	cardinalPoint := aCardinalPoint.
	forwardPoint := aForwardPoint.
	rightCardinalPoint := aRightCardinalPoint.
	leftCardinalPoint := aLeftCardinalPoint.! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:47:25'!
leftCardinalPoint
	^ leftCardinalPoint.! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 6/24/2024 00:58:56'!
leftHeading
	^leftHeading ! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 6/24/2024 00:58:46'!
leftHeading: aLeftHeading rightHeading: aRightHeading
	leftHeading := aLeftHeading.
	rightHeading := aRightHeading.! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:47:29'!
rightCardinalPoint
	^ rightCardinalPoint.! !

!MarsRoversHeading methodsFor: 'as yet unclassified' stamp: 'RPH 6/24/2024 21:58:43'!
rightHeading
	
	^rightHeading.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoversHeading class' category: #MarsRovers!
MarsRoversHeading class
	instanceVariableNames: ''!

!MarsRoversHeading class methodsFor: 'as yet unclassified' stamp: 'RPH 6/24/2024 21:58:04'!
for: aCardinalPoint forwardWith: aForwardPoint

	^self new initializeFor: aCardinalPoint forwardWith: aForwardPoint.! !

!MarsRoversHeading class methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:45:52'!
for: aCardinalPoint forwardWith: aForwardPoint backwardWith: aBackwardPoint rightCardinalPoint: rightCardinalPoint leftCardinalPoint: leftCardinalPoint
	^self new initializeFor: aCardinalPoint forwardWith: aForwardPoint backwardWith: aBackwardPoint rightCardinalPoint: rightCardinalPoint leftCardinalPoint: leftCardinalPoint ! !

!MarsRoversHeading class methodsFor: 'as yet unclassified' stamp: 'RPH 6/24/2024 00:56:43'!
for: aCardinalPoint forwardWith: aForwardPoint rightCardinalPoint: rightCardinalPoint leftCardinalPoint: leftCardinalPoint
	^self new initializeFor: aCardinalPoint forwardWith: aForwardPoint rightCardinalPoint: rightCardinalPoint leftCardinalPoint: leftCardinalPoint ! !


!classDefinition: #MarsRoversHeadingEast category: #MarsRovers!
Object subclass: #MarsRoversHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRoversHeadingEast methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:49:13'!
backwardPoint
	^(-1@0)! !

!MarsRoversHeadingEast methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:58:07'!
cardinalPoint
	^ 'E'! !

!MarsRoversHeadingEast methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:49:05'!
forwardPoint
	^(1@0)! !

!MarsRoversHeadingEast methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:06:54'!
leftCardinalPoint
	^ MarsRoversHeadingNorth.! !

!MarsRoversHeadingEast methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:07:02'!
rightCardinalPoint
	^ MarsRoversHeadingSouth.! !


!classDefinition: #MarsRoversHeadingNorth category: #MarsRovers!
Object subclass: #MarsRoversHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRoversHeadingNorth methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:42:41'!
backwardPoint
	^(0@-1)! !

!MarsRoversHeadingNorth methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:58:13'!
cardinalPoint
	^ 'N'! !

!MarsRoversHeadingNorth methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:42:25'!
forwardPoint
	^(0@1).! !

!MarsRoversHeadingNorth methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:07:07'!
leftCardinalPoint
	^ MarsRoversHeadingWest ! !

!MarsRoversHeadingNorth methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:07:14'!
rightCardinalPoint
	^ MarsRoversHeadingEast ! !


!classDefinition: #MarsRoversHeadingSouth category: #MarsRovers!
Object subclass: #MarsRoversHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRoversHeadingSouth methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:51:30'!
backwardPoint
	^(0@1)! !

!MarsRoversHeadingSouth methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:58:18'!
cardinalPoint
	^ 'S'! !

!MarsRoversHeadingSouth methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:51:25'!
forwardPoint
	^ (0@-1)! !

!MarsRoversHeadingSouth methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:07:19'!
leftCardinalPoint
	^MarsRoversHeadingWest ! !

!MarsRoversHeadingSouth methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:07:24'!
rightCardinalPoint
	^ MarsRoversHeadingEast ! !


!classDefinition: #MarsRoversHeadingWest category: #MarsRovers!
Object subclass: #MarsRoversHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRoversHeadingWest methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:50:57'!
backwardPoint
	^(1@0)! !

!MarsRoversHeadingWest methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:58:24'!
cardinalPoint
	^ 'W'! !

!MarsRoversHeadingWest methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 20:50:53'!
forwardPoint
	^ (-1@0)! !

!MarsRoversHeadingWest methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:07:29'!
leftCardinalPoint
	^ MarsRoversHeadingSouth ! !

!MarsRoversHeadingWest methodsFor: 'as yet unclassified' stamp: 'RPH 6/23/2024 21:07:34'!
rightCardinalPoint
	^ MarsRoversHeadingNorth ! !

MarsRovers initialize!