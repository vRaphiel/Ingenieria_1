!classDefinition: #HundredDoorsTests category: 'HundredDoors'!
TestCase subclass: #HundredDoorsTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'HundredDoors'!

!HundredDoorsTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/16/2024 23:25:00'!
HundredDoorsChangeStateAtSecondPhase
	| hundredDoors |
	hundredDoors := OrderedCollection new.
	1 to: 100 do: [ :a | hundredDoors add: true.].
	2 to: 100 do: [ :a | 	(a \\ 2 == 0) ifTrue: [ hundredDoors at: a put: false]	].
	^hundredDoors.! !

!HundredDoorsTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/16/2024 23:15:23'!
HundredDoorsFirstOpen
	| hundredDoors |
	hundredDoors := OrderedCollection new.
	1 to: 100 do: [ :a | hundredDoors add: true.].
	^hundredDoors.! !

!HundredDoorsTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/16/2024 23:23:02'!
HundredDoorsMultiplySecondOpen
	| hundredDoors |
	hundredDoors := OrderedCollection new.
	1 to: 100 do: [ :a | hundredDoors add: false.].
	1 to: 100 do: [ :a | (a \\ 2 == 0) ifTrue: [ hundredDoors at: a put: true]	].
	^hundredDoors.! !

!HundredDoorsTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/16/2024 22:33:14'!
test01allDoorsAreCloses
	" all doors are close"
	| hundredDoorsFirstOpen hundredDoors |
	hundredDoorsFirstOpen := self HundredDoorsFirstOpen.
	hundredDoors := HundredDoors new.
	
	self assert: hundredDoorsFirstOpen equals: (hundredDoors openDoorsVisitNumber: 	1).! !

!HundredDoorsTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/16/2024 23:22:41'!
test02allDoorsAreClosesOpened2
	" all doors are close"
	| hundredDoorsFirstOpen hundredDoors |
	hundredDoorsFirstOpen := self HundredDoorsMultiplySecondOpen.
	hundredDoors := HundredDoors new.
	
	self assert: hundredDoorsFirstOpen equals: (hundredDoors openDoorsVisitNumber: 	2).! !

!HundredDoorsTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/16/2024 23:25:24'!
test02allDoorsChangedState
	" all doors are close"
	| hundredDoorsFirstOpen hundredDoors |
	hundredDoorsFirstOpen := self HundredDoorsChangeStateAtSecondPhase .
	hundredDoors := HundredDoors new.
	
	hundredDoors openDoorsVisitNumber: 1.
	
	self assert: hundredDoorsFirstOpen equals: (hundredDoors openDoorsVisitNumber: 	2).! !


!classDefinition: #HundredDoors category: 'HundredDoors'!
Object subclass: #HundredDoors
	instanceVariableNames: 'doorsCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'HundredDoors'!

!HundredDoors methodsFor: 'initialize' stamp: 'RPH 5/16/2024 22:36:20'!
initialize
	doorsCollection := OrderedCollection new.
	1 to: 100 do: [ :a |
		doorsCollection 	add: false.
	]! !


!HundredDoors methodsFor: 'evaluating' stamp: 'RPH 5/16/2024 23:24:51'!
openDoorsVisitNumber: aNumber

	1 to: 100 do: [ :a |
		(a >= aNumber) ifTrue: [
			(a \\ aNumber == 0) 
				ifTrue: [ 
					doorsCollection 
						at: a 
						put: ((doorsCollection at: a) not)
				].
		]
	].

	^ doorsCollection.! !
