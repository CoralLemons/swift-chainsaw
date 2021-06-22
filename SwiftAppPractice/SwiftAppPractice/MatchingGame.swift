//
//  MatchingGame.swift
//  SwiftAppPractice
//
//  Created by Leeann Warren on 6/22/21.
//

// This file is the outline/model with the bits of logic and information not displayed immediately

import Foundation // imports stuff like String, Array, etc.

struct MatchingGame<SymbolContent> {
    private(set) var symbol: Array<Symbols> // Symbols type - create below -- private(set) to set and protect the Symbol array
    
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
        let chosenIndex = index(of: symbolPick)
        symbol[chosenIndex].isFaceUp.toggle() // if the card is face up -- toggle the view of the card
        //print("tapped card =  \(chosenCard)")
    } // end choose -- function chooses the Symbol
    
    func index(of symb: Symbols) -> Int{
        for index in 0..<symbol.count{
            if symbol[index].id == symb.id{
                return index
            } // end if statement -- if the id values match, return the index
        } // end for loop -- iterate through the array 
        return 0 // returns 0 if bogus
    } // end indexOf
    
} // end MatchingGame -- generic field that accepts the symbol being passed to it
