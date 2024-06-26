!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:53:44'!
test01PortfolioWithZeroAccountsHasBalanceZero

	self assert: 0 equals: Portfolio new balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:53:44'!
test02PortfolioWithTwoAccountsAddThirdAccountWithDepositAndWithdrawHasBalance

	| account1 account2 account3 portfolio |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Deposit register: 50 on: account2.
	
	Withdraw register: 70 on: account1.
	Withdraw register: 20 on: account2.
	
	Deposit register: 80 on: account3.
	Withdraw register: 10 on: account3.
	
	portfolio := Portfolio with: account1 with: account2.
	
	self assert: portfolio balance equals: 60.
	
	portfolio add: account3.
	
	self assert: portfolio balance equals: 130.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:53:44'!
test03PortfolioCalculateBalanceRecursively

	| account1 account2 account3 simplePortfolio composePortfolio |
	
	account1 := ReceptiveAccount new.
	Deposit register: 50 on: account1.
	account2 := ReceptiveAccount new.
	Deposit register: 20 on: account2.
	account3 := ReceptiveAccount new.
	Deposit register: 30 on: account3.
	
	simplePortfolio := Portfolio with: account1 with: account2.
	composePortfolio := Portfolio with: account3 with: simplePortfolio.
	
	self assert: composePortfolio balance equals: 100.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:53:44'!
test04PortfolioNotRegisteredNothingOnEmpty

	self deny: (Portfolio new hasRegistered: (Deposit for: 100)).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:53:44'!
test05PortfolioRegisterOperations

	| portfolio account deposit |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.

	self assert: (portfolio hasRegistered: 	deposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:53:44'!
test06PortfolioSearchRegisteredTransactionRecursively

	| account1 account2 account3 simplePortfolio composePortfolio deposit |
	
	account1 := ReceptiveAccount new.
	deposit := Deposit register: 50 on: account1.
	account2 := ReceptiveAccount new.
	Deposit register: 20 on: account2.
	account3 := ReceptiveAccount new.
	Deposit register: 30 on: account3.
	
	simplePortfolio := Portfolio with: account1 with: account2.
	composePortfolio := Portfolio with: account3 with: simplePortfolio.

	self assert: (composePortfolio hasRegistered: 	deposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:53:44'!
test07PortfolioHasNoTransactionsOnEmptyAccount

	self assert: Portfolio new transactions isEmpty.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:53:44'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account accountDeposit accountWithdraw portfolio |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 50 on: account.
	accountWithdraw := Withdraw register: 20 on: account.
	
	portfolio := Portfolio with: account.

	self deny: (portfolio transactions isEmpty).
	self assert: (portfolio transactions includes: accountDeposit).
	self assert: (portfolio transactions includes: accountWithdraw).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:53:44'!
test09PortfolioTransactionsIncludesAllItsAccountsTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:57:45'!
test10CannotAddTheSameAccountTwice

	| account portfolio |
	
	account := ReceptiveAccount new.
	
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: (Portfolio canNotAddAccountErrorMessage).
			self assert: (portfolio accountIncludes: account).
			self assert: (portfolio accountsSize) equals: 1.
		].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 20:27:23'!
test11CannotIncludeAccountsOfItsPortfolios

	| firstAccount secondAccount thirdAccount simplePortfolio composePortfolio |
	
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	thirdAccount := ReceptiveAccount new.
	
	simplePortfolio := Portfolio with: firstAccount with: secondAccount.
	composePortfolio := Portfolio with: thirdAccount with: simplePortfolio.
	
	self 
		should: [ composePortfolio add: firstAccount. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: (Portfolio canNotAddAccountErrorMessage).
			self assert: (composePortfolio accountIncludes: firstAccount).
			self assert: (composePortfolio accountIncludes: secondAccount).
			self assert: (composePortfolio accountIncludes: thirdAccount).
			self assert: (composePortfolio accountsSize) equals: 3.
		].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 21:07:31'!
test12PortfolioCannotAdItselfs
	| firstAccount secondAccount portfolio |
	
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	
	portfolio := Portfolio with: firstAccount with: secondAccount.
	
	self 
		should: [ portfolio add: firstAccount. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: (Portfolio canNotAddAccountErrorMessage).
		].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 21:08:46'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| firstAccount secondAccount portfolio |
	
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	
	portfolio := Portfolio with: firstAccount with: secondAccount.
	
	self 
		should: [ portfolio add: portfolio. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: (Portfolio canNotAddAccountErrorMessage).
		].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 21:43:37'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 21:17:10'!
test15

	| firstAccount secondAccount portfolio |
	
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	
	portfolio := Portfolio with: firstAccount with: secondAccount.
	
	self 
		should: [ portfolio add: portfolio. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: (Portfolio canNotAddAccountErrorMessage).
		].! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 6/25/2024 14:49:37'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated

	| account |
	
	account := ReceptiveAccount new.
	
	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 6/25/2024 15:25:13'!
test02DepositIncreasesBalanceOnTransactionValue 
	| account |
	
	account := ReceptiveAccount  new.
	
	Deposit register: 100 on: account.
	
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 6/25/2024 14:51:33'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	
	Withdraw register: 50 on: account.
	
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 6/25/2024 15:25:09'!
test04WithdrawValueMustBePositive

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 6/25/2024 15:25:04'!
test05ReceptiveAccountKnowsRegisteredTransactions 
	| account deposit withdraw |

	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
	
	withdraw := Withdraw register: 50 on: account.

	self assert: (account hasRegistered: deposit).
	
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 6/25/2024 15:18:16'!
test07AccountKnowsItsTransactions 
	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
	
	self assert: 1 equals: account1 transactions size.
	
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #Account category: #'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:46:15'!
balance

	self subclassResponsibility! !

!Account methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:46:18'!
hasRegistered: anOperation

	self subclassResponsibility! !

!Account methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:46:24'!
transactions

	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 20:34:37'!
accountIncludes: account 
	accounts do: [ :anAccount | 
		(anAccount isKindOf: ReceptiveAccount) ifTrue: [anAccount = account ifTrue: [ ^true.]].
		(anAccount isKindOf: Portfolio) ifTrue: [ (anAccount accountIncludes: account) ifTrue: [^true.]].
	].
	"^ accounts includes: account."! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 20:41:08'!
accountsSize
	| accountsSize | 
	accountsSize := 0.
	accounts do: [ :anAccount |
		(anAccount isKindOf: ReceptiveAccount) ifTrue: [ accountsSize := accountsSize + 1.].
		(anAccount isKindOf: Portfolio ) ifTrue: [ accountsSize := accountsSize + (anAccount accountsSize)].
	].
	^ accountsSize.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 20:11:50'!
add: anAccount
	self assertCanAdd: anAccount.
	
	accounts add: anAccount.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 21:15:56'!
assertCanAdd: anAccountToAdd
	" Si esta en accounts entonces listo. Si está en portfolio tengo que pedir las cuentas del portfolio, o preguntarle al portfolio si está en sus cuentas."
	(self = anAccountToAdd) ifTrue: [self error: self class canNotAddAccountErrorMessage.].
	accounts do: [ :anAccount |
		( anAccount isKindOf: ReceptiveAccount ) ifTrue: [ anAccountToAdd = anAccount ifTrue: [ self error: self class canNotAddAccountErrorMessage.]].
		( anAccount isKindOf: Portfolio )			ifTrue: [ 		(anAccount accountIncludes: anAccountToAdd) ifTrue: [self error: self class canNotAddAccountErrorMessage.].		].
	].
	"(accounts includes: anAccountToAdd) ifTrue: [ self error: self class canNotAddAccountErrorMessage.]"! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 18:29:25'!
balance
	^accounts sum: [:anAccount | anAccount balance] ifEmpty: [0].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 18:05:03'!
hasRegistered: anOperation
	
	| isOperationRegistered |
	isOperationRegistered := false.
	accounts do: [ :anAccount | (anAccount hasRegistered: anOperation) ifTrue: [ isOperationRegistered := true.]].
	^ isOperationRegistered .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 18:10:04'!
initialize
	accounts := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:37:39'!
transactions
	| transactions |
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | 
		anAccount transactions do: [ :aTransaction | transactions add: aTransaction ].
	].
	^transactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:57:52'!
canNotAddAccountErrorMessage
	^'Cannot add account'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:06:06'!
with: anAccount
	^ self new 
		add: anAccount.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 19:06:02'!
with: anAccount with: aSecondAccount
	^ self new 
		add: anAccount; 
		add: aSecondAccount; 
		yourself.! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'RPH 6/25/2024 14:53:31'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'RPH 6/25/2024 14:53:49'!
register: aTransaction

	transactions add: aTransaction
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'RPH 6/25/2024 14:53:43'!
transactions

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'RPH 6/25/2024 15:44:01'!
balance

	| totalBalance |
	
	totalBalance := 0.

	transactions do: [ :aTransaction | totalBalance := aTransaction balance: totalBalance. ].

	^totalBalance.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'RPH 6/25/2024 14:53:39'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'RPH 6/25/2024 14:52:25'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 15:34:52'!
balance: aBalance

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'RPH 6/25/2024 15:09:02'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'RPH 6/25/2024 14:52:28'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 15:35:11'!
balance: aBalance
	^ aBalance + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'RPH 6/25/2024 15:09:08'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'RPH 6/25/2024 14:52:34'!
value
	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'RPH 6/25/2024 15:44:26'!
balance: aBalance
	^ aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
