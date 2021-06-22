//
//  MatchingGame.swift
//  SwiftAppPractice
//
//  Created by Leeann Warren on 6/22/21.
//

// This file is the outline/model with the bits of logic and information not displayed immediately

import Foundation // imports stuff like String, Array, etc. and is UI INDEPENDANT

struct MatchingGame<SymbolContent> where SymbolContent: Equatable{ // Equatable means that you can do == on optionals (AKA the 'dont care' generic)
    private(set) var symbol: Array<Symbols> // Symbols type - create below -- private(set) to set and protect the Symbol array
    
    private var indexOfFaceCard: Int? // index of the ONLY card that is face up -- optional for build nil when init
    
    init(numberOfSymbols: Int, createSymbolContent: (Int) -> SymbolContent){ // createSymbolContent is an int func that returns SymbolContent
        symbol = Array<Symbols>() // add # of symbols * 2 to the symbol array
        for pairIndex in 0..<numberOfSymbols{
            let content: SymbolContent = createSymbolContent(pairIndex) // invokes the passed parameters
            // create two matching symbols
            symbol.append(Symbols(content: content, id: pairIndex*2)) // first card is always even
            symbol.append(Symbols(content: content, id: pairIndex*2+1)) // second card is always odd && 1 more than card it matches
        } // end for loop -- iterate through the contents of the Symbol array
    } // end init -- init symbol array
    
    struct Symbols: Identifiable {
        var isFaceUp: Bool = false // game starts with face down
        var isMatched: Bool = false // game starts unmatched
        var content: SymbolContent // reference the content of the SymbolArray itself
        var id: Int // can be whatever, used Int for this one
        // a single var used to identify this symbol vs all other symbols (Identifiable)
        
    } // end Symbols struct -- nested inside the MatchingGame to be directly accesssed by MatchingGame.Symbols <--
    
    mutating func choose(_ symbolPick: Symbols){ // keyword "mutating" denotes that this func will change the value
        if let chosenIndex = symbol.firstIndex(where: {$0.id == symbolPick.id}),
           !symbol[chosenIndex].isFaceUp,
           !symbol[chosenIndex].isMatched{
        // if this symbol id matches the symbol id of the array, execute code body below && the chosenIndex card is NOT face up && the card is NOT matched
            if let potentialMatchIndex = indexOfFaceCard{
                if symbol[chosenIndex].content == symbol[potentialMatchIndex].content { // this uses the where: Equatable clause
                    symbol[chosenIndex].isMatched = true
                    symbol[potentialMatchIndex].isMatched = true
                } // if their content is the same, changed their matched values to true to trigger next func
                indexOfFaceCard = nil
            } // end if-let -- if the face up card matches the tapped card's index, check to see if the content is the same
            else {
                for index in 0..<symbol.count {
                    symbol[index].isFaceUp = false // reset value
                } // end for loop -- traverse the loop and set isFaceUp to false
                indexOfFaceCard = chosenIndex 
            } //end else -- else there is more than two cards face up, flip all cards in for loop
            symbol[chosenIndex].isFaceUp.toggle() // if the card is face up -- toggle the view of the card
            //above line will crash the game if nil is returned when using ! to force unwrap
        } // end if-let -- chosenIndex
    } // end choose -- function chooses the Symbol
    
} // end MatchingGame -- generic field that accepts the symbol being passed to it
