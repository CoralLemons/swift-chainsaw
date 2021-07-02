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
    
    private var indexOfFaceCard: Int? {
        get{
            symbol.indices.filter{symbol[$0].isFaceUp}.oneAndOnly // if [<-- filter] the card is face up, put it inside the array && return the array extension optional
        }// end getter -- get the one face up card
        set {
            symbol.indices.forEach{symbol[$0].isFaceUp = ($0 == newValue)} // assign bool value if the card is faceUp or not
            // end forEach loop -- traverse the loop and set isFaceUp to false if the index of the card does not match the index of the faceUp card (newValue <-- this is used because Swift provides this as a setter)
        } // end setter -- set where the face up card is
    }// index of the ONLY card that is face up -- optional for build nil when init
    
    init(numberOfSymbols: Int, createSymbolContent: (Int) -> SymbolContent){ // createSymbolContent is an int func that returns SymbolContent
        symbol = []
        for pairIndex in 0..<numberOfSymbols{ // add # of symbols * 2 to the symbol array
            let content: SymbolContent = createSymbolContent(pairIndex) // invokes the passed parameters
            // create two matching symbols
            symbol.append(Symbols(content: content, id: pairIndex*2)) // first card is always even
            symbol.append(Symbols(content: content, id: pairIndex*2+1)) // second card is always odd && 1 more than card it matches
        } // end for loop -- iterate through the contents of the Symbol array
    } // end init -- init symbol array
    
    struct Symbols: Identifiable {
        var isFaceUp = false // game starts with face down
        var isMatched = false // game starts unmatched
        let content: SymbolContent // reference the content of the SymbolArray itself
        let id: Int // can be whatever, used Int for this one
        // a single var used to identify this symbol vs all other symbols (Identifiable)
        
    } // end Symbols struct -- nested inside the MatchingGame to be directly accesssed by MatchingGame.Symbols <--
    
    mutating func choose(_ symbolPick: Symbols){ // keyword "mutating" denotes that this func will change the value
        if let chosenIndex = symbol.firstIndex(where: {$0.id == symbolPick.id}),
           !symbol[chosenIndex].isFaceUp,
           !symbol[chosenIndex].isMatched{
        // if this symbol id matches the symbol id of the array && the chosenIndex card is NOT face up && the card is NOT matched, execute code body below
            if let potentialMatchIndex = indexOfFaceCard{
                if symbol[chosenIndex].content == symbol[potentialMatchIndex].content { // this uses the 'where: Equatable' clause
                    symbol[chosenIndex].isMatched = true
                    symbol[potentialMatchIndex].isMatched = true
                } // if their content is the same, changed their matched values to true to trigger next func
                symbol[chosenIndex].isFaceUp = true;
            } // end if-let -- if the face up card matches the tapped card's index, check to see if the content is the same
            else {
                indexOfFaceCard = chosenIndex 
            } //end else -- else there is more than two cards face up, flip all cards in for loop
        } // end if-let -- chosenIndex
    } // end choose -- function chooses the Symbol
    
    mutating func shuffle(){
        symbol.shuffle() 
    } // end shuffle function
    
} // end MatchingGame -- generic field that accepts the symbol being passed to it

extension Array{
    var oneAndOnly: Element? {// optional return with generics
        if self.count == 1 {
            return self.first // theres only one face up card, return the card
        }else {
            return nil // otherwise return nil -- theres either 0 or more than 1 face up card
        } // end else
    }
} // end array extension
