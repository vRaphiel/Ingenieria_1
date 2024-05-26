!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 5/19/2024 20:48:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated

	| account |
	
	account := ReceptiveAccount new.
	
	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 5/19/2024 20:48:44'!
test02DepositIncreasesBalanceOnTransactionValue

	| account |

	account := ReceptiveAccount  new.
	
	Deposit register: 100 on: account.
	
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 5/19/2024 20:48:42'!
test03WithdrawDecreasesBalanceOnTransactionValue

	| account |
	
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	
	Withdraw register: 50 on: account.
	
	self assert: 50 equals: account balance.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 5/19/2024 20:48:37'!
test04WithdrawValueMustBePositive

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 5/19/2024 20:48:28'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
	
	withdraw := Withdraw register: 50 on: account.
	
	self assert: (account hasRegistered: deposit).
	
	self assert: (account hasRegistered: withdraw).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 5/19/2024 20:48:32'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	
	deposit :=  Deposit for: 200.
	
	withdraw := Withdraw for: 50.
	
	self deny: (account hasRegistered: deposit).
	
	self deny: (account hasRegistered:withdraw).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 5/19/2024 20:48:26'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |

	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.

	self assert: 1 equals: account1 transactions size.
	
	self assert: (account1 transactions includes: deposit1).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 5/19/2024 21:46:34'!
test08PortfolioHaveZeroAsBalanceWhenCreated

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 5/19/2024 21:54:55'!
test09PortfolioAddReceptiveAccountWithBalance50AndPortfolioBalance50Is50

	| portfolio account |
	
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	
	portfolio := Portfolio new.
	portfolio addAccount: account.
	
	self assert: 50 equals: portfolio balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 5/19/2024 21:57:15'!
test09PortfolioAddTwoReceptiveAccountPortfolioBalanceMustBeSum

	| portfolio account |
	
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	
	portfolio := Portfolio new.
	portfolio addAccount: account.
	
	self assert: 50 equals: portfolio balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 5/19/2024 22:24:11'!
test10PortfolioAddTwoReceptiveAccountWithBalanceAndWithdrawAndBeBalanceOfPortfolio

	| portfolio account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	Withdraw register: 10 on: account1.
	Deposit register: 100 on: account2.
	Withdraw register: 20 on: account1.
	
	portfolio := Portfolio new.
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	
	self assert: 120 equals: portfolio balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 5/19/2024 23:03:56'!
test11PortfolioAddReceptiveAccountReturnPortfolioTransactions

	| portfolio account |
	
	account := ReceptiveAccount new.

	Deposit register: 50 on: account.
	Withdraw register: 10 on: account.
	Withdraw register: 20 on: account.
	
	portfolio := Portfolio new.
	portfolio addAccount: account.
	
	self assert: (account transactions) equals: (portfolio transactions ).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RPH 5/19/2024 23:07:02'!
test12PortfolioAddTwoReceptiveAccountReturnPortfolioTransactions

	| portfolio account1 account2 transactionArr |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	Withdraw register: 10 on: account1.
	Deposit register: 100 on: account2.
	Withdraw register: 20 on: account1.
	
	portfolio := Portfolio new.
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	
	transactionArr := account1 transactions.
	account2 transactions do: [ :aTransaction | 
		transactionArr add: aTransaction.
	].
	
	self assert: transactionArr equals: (portfolio transactions ).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'RPH 5/19/2024 20:54:38'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'RPH 5/19/2024 21:24:32'!
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

!Deposit methodsFor: 'initialization' stamp: 'RPH 5/19/2024 20:54:34'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'RPH 5/19/2024 20:54:29'!
value

	^ value! !

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

!Withdraw methodsFor: 'initialization' stamp: 'RPH 5/19/2024 20:54:25'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'RPH 5/19/2024 20:54:22'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'RPH 5/19/2024 21:53:38'!
initialize
	accounts := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'RPH 5/19/2024 21:51:49'!
addAccount: anAccount
	accounts add: anAccount.! !

!Portfolio methodsFor: 'transactions' stamp: 'RPH 5/19/2024 22:33:39'!
transactions 

	| allTransactions |
	
	allTransactions := OrderedCollection new.
	
	accounts do: [ :anAccount | 
		anAccount transactions do: [
			:aTransaction | allTransactions add: aTransaction.	
		].
	].
	
	^ allTransactions.! !


!Portfolio methodsFor: 'balance' stamp: 'RPH 5/19/2024 21:54:49'!
balance
	^accounts sum: [ :anAccount | 
		anAccount balance.
	] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'testing' stamp: 'RPH 5/19/2024 21:41:52'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction
! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'RPH 5/19/2024 22:32:00'!
initialize
	
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'RPH 5/19/2024 20:54:08'!
register: aTransaction

	transactions add: aTransaction
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'RPH 5/19/2024 20:54:12'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'RPH 5/19/2024 21:26:06'!
balance
	^transactions sum: [ :aTransaction | 
		(aTransaction isKindOf: Deposit) 
			ifTrue: [ aTransaction value] 
			ifFalse: [ (-1)*aTransaction value]
	] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'RPH 5/19/2024 20:54:03'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction
! !
