'From Squeak4.5 of 19 February 2014 [latest update: #13680] on 19 March 2015 at 5:54:58 am'!Object subclass: #PartialCorrectChecker	instanceVariableNames: ''	classVariableNames: 'Solution SolutionSize'	poolDictionaries: ''	category: 'Mastermind'!"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!PartialCorrectChecker class	instanceVariableNames: ''!!PartialCorrectChecker class methodsFor: 'as yet unclassified' stamp: 'JJG 3/17/2015 01:28'!checkPartialCorrect: playerGuess	"takes an array of player guesses and returns the number that are partially correct"	| numPartRight alreadyChosenArray alreadyChosen numUsed done |	alreadyChosenArray := Array new: SolutionSize.	numPartRight := 0.	numUsed := 0.	alreadyChosen := False.	done := False.	"first go through guess once to mark pegs that are completely correct so they won't be used as half correct pegs"	1 to: SolutionSize do: [:t|		((Solution at: t) = (playerGuess at: t)) ifTrue: [			numUsed:=numUsed + 1.			alreadyChosenArray at: numUsed put: t.		].	].	1 to: SolutionSize do: [ :i |		done := False.		1 to: SolutionSize do: [:j |			alreadyChosen := False.			"check to see if answer peg i has already been marked as half correct"			1 to: numUsed do: [:k|				j = (alreadyChosenArray at: k) ifTrue: [					"should break out of loop here but I don't know if that is possible..."					alreadyChosen := True.				].			].			((playerGuess at: i) = (Solution at: j) & (i~=j) & (alreadyChosen~=True) & (done ~=True)) ifTrue: [				"done variable used to indicate that a match has been found. break statement would be better..."				done := True.				numPartRight := numPartRight + 1.				numUsed := numUsed + 1.				"keep track that the solution at i has been used as half right peg"				(numUsed<=SolutionSize) ifTrue:[					alreadyChosenArray at: numUsed put: j.				].				].		].	].	Transcript show: numPartRight.	^numPartRight.	! !!PartialCorrectChecker class methodsFor: 'as yet unclassified' stamp: 'JJG 3/16/2015 23:51'!setAnswer: answerArray size: arraySize	"sets the class variables of answer and number of pegs"	Solution := answerArray.	SolutionSize := arraySize.! !