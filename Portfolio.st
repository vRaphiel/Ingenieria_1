!classDefinition: #PortfolioTest category: 'Portfolio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

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

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportPortfolioTests category: 'Portfolio'!
TestCase subclass: #ReportPortfolioTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReportPortfolioTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/26/2024 18:52:12'!
test01PortfolioCreated
	| johnsAccount angiesAccount friendsPortfolio printed |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	friendsPortfolio := Portfolio named: 'Portfolio de amigos' with: johnsAccount with: angiesAccount.
	
	printed := OrderedCollection
		with: 'Portfolio de amigos'
		with: (OrderedCollection with: 'Cuenta de Juan' with: (OrderedCollection with: 'Balance = 0'))
		with: (OrderedCollection with: 'Cuenta de Angeles' with: (OrderedCollection with: 'Balance = 0')).
		
	self assert: printed equals: friendsPortfolio accountSummary.! !

!ReportPortfolioTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/26/2024 16:42:36'!
testXXFinalPortfolioCreated
	| johnsAccount angiesAccount childrenPortfolio myAccount familyPortfolio |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: 	myAccount with: childrenPortfolio.
! !


!classDefinition: #ReportReceptiveAccountTests category: 'Portfolio'!
TestCase subclass: #ReportReceptiveAccountTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReportReceptiveAccountTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 15:30:24'!
test01ReportOfNewAccount
	"Hago un deposito en la cuenta emisora y uno en la cuenta receptora"
	| account |
	
	account := ReceptiveAccount new.
	
	self assert: (OrderedCollection with: 'Balance = 0') equals: account accountSummary.! !

!ReportReceptiveAccountTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:37:13'!
test02ReportOfAccountWithOneDeposit
	"Hago un deposito en la cuenta emisora y uno en la cuenta receptora"
	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	
	self assert: (OrderedCollection with: 'Depósito por 50' with: 'Balance = 50') equals: account accountSummary.! !

!ReportReceptiveAccountTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 15:49:16'!
test03ReportOfAccountWithOneDepositAndOneWithdraw
	"Hago un deposito en la cuenta emisora y uno en la cuenta receptora"
	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	Withdraw register: 20 on: account.
	
	self assert: (OrderedCollection with: 'Depósito por 50' with: 'Extracción por 20' with: 'Balance = 30') equals: account accountSummary.! !

!ReportReceptiveAccountTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 15:49:50'!
test04ReportOfAccountWithDifferentDepositAndWithdraw
	"Hago un deposito en la cuenta emisora y uno en la cuenta receptora"
	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	Withdraw register: 10 on: account.
	
	self assert: (OrderedCollection with: 'Depósito por 50' with: 'Extracción por 10' with: 'Balance = 40') equals: account accountSummary.! !

!ReportReceptiveAccountTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 16:30:08'!
test05TransfernetOfNewAccount
	"Hago un deposito en la cuenta emisora y uno en la cuenta receptora"
	| account |
	
	account := ReceptiveAccount new.
	
	self assert: 0 equals: account transferNet.! !

!ReportReceptiveAccountTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 16:30:11'!
test06TransfernetOfAccountWithDepositAndWithdraw
	"Hago un deposito en la cuenta emisora y uno en la cuenta receptora"
	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 70 on: account.
	Withdraw register: 20 on: account.
	
	self assert: 50 equals: account transferNet.! !

!ReportReceptiveAccountTests methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 16:30:14'!
test07TransfernetOfAccountTransfernetOfTwoDeposit
	"Hago un deposito en la cuenta emisora y uno en la cuenta receptora"
	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 70 on: account.
	Deposit register: 80 on: account.
	
	self assert: 150 equals: account transferNet.! !


!classDefinition: #TransferTest category: 'Portfolio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'RPH 5/20/2024 20:39:44'!
test01AnAccountSend10ToAReceiverAccount
	"Hago un deposito en la cuenta emisora y uno en la cuenta receptora"
	| accountSender accountReceiver |
	
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	
	Transfer betweenASender: accountSender andAReceptor: accountReceiver withAQuantity: 10.
	
	self assert: accountSender balance equals: -10.
	self assert: accountReceiver balance equals: 10.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'RPH 5/20/2024 20:39:44'!
test02ValidateBothAccountHasNewTransaction

	| transaction accountSender accountReceiver |
	
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	
	transaction := Transfer betweenASender: accountSender andAReceptor: accountReceiver withAQuantity: 10.
	
	self assert: (accountSender hasRegistered: transaction withdraw).
	self assert: (accountReceiver hasRegistered: transaction deposit).
	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'RPH 5/20/2024 21:20:52'!
test03AnAccountTransactionKnownsTransfer

	"Una cuenta puede almacenar las transferencias."

	| transaction accountSender accountReceiver |
	
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	
	transaction := Transfer betweenASender: accountSender andAReceptor: accountReceiver withAQuantity: 10.
	
	self assert: (transaction deposit transfer withdraw ) equals: (transaction withdraw ).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'RPH 5/20/2024 21:21:06'!
test04AnAccountKnownsTheirTransfers

	"Una cuenta puede almacenar las transferencias."

	| transaction accountSender accountReceiver |
	
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	
	transaction := Transfer betweenASender: accountSender andAReceptor: accountReceiver withAQuantity: 10.
	
	self assert: (transaction deposit transfer withdraw ) equals: (transaction withdraw ).! !


!classDefinition: #Account category: 'Portfolio'!
Object subclass: #Account
	instanceVariableNames: 'accountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'getter' stamp: 'RPH 5/26/2024 18:32:46'!
accountName
	^accountName.! !

!Account methodsFor: 'getter' stamp: 'RPH 5/23/2024 15:13:20'!
accountSummary

	self subclassResponsibility! !

!Account methodsFor: 'getter' stamp: 'RPH 5/23/2024 16:04:02'!
transferNet

	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'RPH 5/26/2024 18:32:46'!
initialize
	
	accountName := ''.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'RPH 5/26/2024 18:32:46'!
initializeWithACustomerName: aCustomerName.
	
	accountName := aCustomerName.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'getter' stamp: 'RPH 5/26/2024 18:36:41'!
accountSummary

	| reports sumary |
	
	reports := OrderedCollection with: accountName.
	
	accounts do: [ :anAccount | 
		sumary := OrderedCollection with: anAccount accountName with: anAccount accountSummary.
		reports add: sumary.	
	].

	parents do: [ :anAccount | 
		sumary := OrderedCollection with: anAccount accountName with: anAccount accountSummary.
		reports add: sumary.	
	].

	^ reports.! !

!Portfolio methodsFor: 'getter' stamp: 'RPH 5/23/2024 16:04:02'!
transferNet
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RPH 5/26/2024 16:38:39'!
named: aCustomerName with: anAccount

	^self new initializeWithACustomerName: aCustomerName;
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RPH 5/26/2024 16:38:47'!
named: aCustomerName with: anAccount with: anotherAccount

	^self new initializeWithACustomerName: aCustomerName;
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RPH 5/26/2024 16:38:26'!
with: anAccount
	^ self named: '' with: anAccount.
"
	^self new 
		add: anAccount;
		yourself
"! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RPH 5/26/2024 16:38:30'!
with: anAccount with: anotherAccount

	^ self named: '' with: anAccount with: anotherAccount.
"
	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself
"! !


!classDefinition: #ReceptiveAccount category: 'Portfolio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'RPH 5/26/2024 18:32:46'!
initialize

	super initialize.
	accountName := ''.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'RPH 5/26/2024 18:32:46'!
initializeWithACustomerName: aCustomerName

	super initialize.
	accountName := aCustomerName.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'getter' stamp: 'RPH 5/26/2024 18:33:21'!
accountSummary
	| report |
	report := AccountReportBuilder new.
	
	transactions do: [ :aTransaction | 
		aTransaction lineOfReport: report.
	].

	report balance: self balance.
	
	^report report.
	! !

!ReceptiveAccount methodsFor: 'getter' stamp: 'RPH 5/26/2024 18:27:54'!
transferNet
	| transfernet |
	transfernet := AccountTransfernetBuilder new.

	transactions do: [ :aTransaction | 
		aTransaction calculate: transfernet.
	].
	
	^ transfernet report.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'RPH 5/26/2024 16:15:33'!
named: aCustomerName
	^ self new initializeWithACustomerName: aCustomerName.! !


!classDefinition: #AccountReportTransfernerBuilder category: 'Portfolio'!
Object subclass: #AccountReportTransfernerBuilder
	instanceVariableNames: 'updateValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountReportTransfernerBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:51:07'!
balance: aBalance
	self subclassResponsibility.! !

!AccountReportTransfernerBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:56:40'!
operationOverDeposit: aDeposit
	self subclassResponsibility.! !

!AccountReportTransfernerBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:56:44'!
operationOverDepositLeg: aDepositLeg
	self subclassResponsibility.! !

!AccountReportTransfernerBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:56:34'!
operationOverWithdraw: aWithdraw
	self subclassResponsibility.! !

!AccountReportTransfernerBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:56:03'!
operationOverWithdrawLeg: aWithdrawLeg
	self subclassResponsibility.! !

!AccountReportTransfernerBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/26/2024 18:34:08'!
report
	^updateValue ! !


!classDefinition: #AccountReportBuilder category: 'Portfolio'!
AccountReportTransfernerBuilder subclass: #AccountReportBuilder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountReportBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:51:16'!
balance: aBalance
	updateValue add: 'Balance = ', aBalance asString.! !

!AccountReportBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/26/2024 18:30:23'!
initialize
	updateValue := OrderedCollection new.! !

!AccountReportBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:57:23'!
operationOverDeposit: aDeposit
	updateValue add: 'Depósito por ', aDeposit value asString.! !

!AccountReportBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:56:53'!
operationOverDepositLeg: aDepositLeg
	updateValue add: 'Salida por transferencia de ', aDepositLeg value asString.! !

!AccountReportBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:57:50'!
operationOverWithdraw: aWithdraw
	updateValue add: 'Extracción por ', aWithdraw value asString.! !

!AccountReportBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:55:37'!
operationOverWithdrawLeg: aWithdrawLeg
	updateValue add: 'Entrada por transferencia de ', aWithdrawLeg value asString.! !


!classDefinition: #AccountTransfernetBuilder category: 'Portfolio'!
AccountReportTransfernerBuilder subclass: #AccountTransfernetBuilder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTransfernetBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:40:47'!
balance: aBalance
	^ deposit.! !

!AccountTransfernetBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:51:55'!
initialize
	updateValue := 0.! !

!AccountTransfernetBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:57:31'!
operationOverDeposit: aDeposit
	updateValue := updateValue + aDeposit value.! !

!AccountTransfernetBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:57:04'!
operationOverDepositLeg: aDepositLeg
	updateValue := updateValue + aDepositLeg value.! !

!AccountTransfernetBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:57:57'!
operationOverWithdraw: aWithdraw
	updateValue := updateValue - aWithdraw value.! !

!AccountTransfernetBuilder methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:56:13'!
operationOverWithdrawLeg: aWithdrawLeg
	updateValue := updateValue - aWithdrawLeg value.! !


!classDefinition: #AccountTransaction category: 'Portfolio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:42:52'!
calculate: aTransfernet
	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:30:44'!
lineOfReport: aReport
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:58:11'!
calculate: aTransfernet
	aTransfernet operationOverDeposit: self.! !

!Deposit methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:58:08'!
lineOfReport: aReport
	aReport operationOverDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'Portfolio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferLeg methodsFor: 'value' stamp: 'RPH 5/20/2024 21:06:30'!
value 

	self subclassResponsibility ! !


!TransferLeg methodsFor: 'balance' stamp: 'RPH 5/20/2024 21:06:30'!
affectBalance: aBalance

	self subclassResponsibility ! !


!TransferLeg methodsFor: 'as yet unclassified' stamp: 'RPH 5/20/2024 21:13:54'!
transfer

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'RPH 5/20/2024 21:10:50'!
register: aValue on: account withTransfer: aTransfer

	| transaction |
	
	transaction := self for: aValue withTransfer: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #DepositLeg category: 'Portfolio'!
TransferLeg subclass: #DepositLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!DepositLeg methodsFor: 'initialization' stamp: 'RPH 5/20/2024 21:09:00'!
initializeFor: aValue withTransfer: aTransfer

	value := aValue .
	transfer := aTransfer.
	! !


!DepositLeg methodsFor: 'value' stamp: 'RPH 5/20/2024 21:06:40'!
value

	^ value! !


!DepositLeg methodsFor: 'balance' stamp: 'RPH 5/20/2024 21:06:40'!
affectBalance: aBalance

	^aBalance + value ! !


!DepositLeg methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:58:17'!
calculate: aTransfernet
	aTransfernet operationOverDepositLeg: self.! !

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:58:19'!
lineOfReport: aReport
	aReport operationOverDepositLeg: self.! !

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'RPH 5/20/2024 21:14:03'!
transfer
	^transfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositLeg class' category: 'Portfolio'!
DepositLeg class
	instanceVariableNames: ''!

!DepositLeg class methodsFor: 'instance creation' stamp: 'RPH 5/20/2024 21:08:22'!
for: aValue withTransfer: aTransfer

	^ self new initializeFor: aValue withTransfer: aTransfer! !


!classDefinition: #WithdrawLeg category: 'Portfolio'!
TransferLeg subclass: #WithdrawLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!WithdrawLeg methodsFor: 'initialization' stamp: 'RPH 5/20/2024 21:09:14'!
initializeFor: aValue withTransfer: aTransfer

	value := aValue .
	transfer := aTransfer.
	! !


!WithdrawLeg methodsFor: 'value' stamp: 'RPH 5/20/2024 21:06:57'!
value

	^ value! !


!WithdrawLeg methodsFor: 'balance' stamp: 'RPH 5/20/2024 21:06:57'!
affectBalance: aBalance

	^aBalance - value! !


!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:58:36'!
calculate: aTransfernet
	aTransfernet operationOverWithdrawLeg: self.! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:58:29'!
lineOfReport: aReport
	aReport operationOverWithdrawLeg: self.! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'RPH 5/20/2024 21:14:14'!
transfer
	^transfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawLeg class' category: 'Portfolio'!
WithdrawLeg class
	instanceVariableNames: ''!

!WithdrawLeg class methodsFor: 'instance creation' stamp: 'RPH 5/20/2024 21:09:31'!
for: aValue withTransfer: aTransfer

	^ self new initializeFor: aValue withTransfer: aTransfer! !


!classDefinition: #Withdraw category: 'Portfolio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:58:41'!
calculate: aTransfernet
	aTransfernet operationOverWithdraw: self.! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'RPH 5/23/2024 23:58:42'!
lineOfReport: aReport
	aReport operationOverWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio'!
Object subclass: #Transfer
	instanceVariableNames: 'senderAccount receiverAccount deposit withdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Transfer methodsFor: 'initializate' stamp: 'RPH 5/23/2024 15:06:58'!
initializeBetweenASender: aSenderAccount andAReceptor: aReceptorAccount withAQuantityOf: aMoneyQuantity
	" REVISAR SI SENDERACCOUNT Y RECEIVERACCOUNT VAN O NO"
	senderAccount := aSenderAccount.
	receiverAccount := aReceptorAccount.
	deposit := DepositLeg register: aMoneyQuantity on: aReceptorAccount withTransfer: self.
	withdraw := WithdrawLeg register: aMoneyQuantity on: aSenderAccount withTransfer: self.! !


!Transfer methodsFor: 'accessing' stamp: 'RPH 5/20/2024 20:29:11'!
deposit
	^deposit.! !

!Transfer methodsFor: 'accessing' stamp: 'RPH 5/20/2024 20:29:18'!
withdraw
	^withdraw.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'RPH 5/20/2024 20:22:57'!
betweenASender: aSenderAccount andAReceptor: aReceptorAccount withAQuantity: aMoneyQuantity
	^self new initializeBetweenASender: aSenderAccount andAReceptor: aReceptorAccount withAQuantityOf: aMoneyQuantity.
! !
