//
//  SymbolMatchGame.swift
//  SwiftAppPractice
//
//  Created by Leeann Warren on 6/22/21.
//

import SwiftUI

class SymbolMatchGame: ObservableObject { //
    typealias Symbols = MatchingGame<String>.Symbols
    
    private static let symbols = ["ð­","ðđ","ðĶ","ð","ð","ðĶĪ","ð","ð","ðĶ","ðŽ","ð","ð", "ðĶĐ","ð","ðĶ","ðĶ"] // 16  animals
    
    private static func createMatchingGame() -> MatchingGame<String> {
        MatchingGame<String>(numberOfSymbols: symbols.count){pairIndex in // hard coded in to array.count <-- change for levels later!!
            symbols[pairIndex] //
        } // create a model with # of total symbols in the array 'symbols'
    }// passes the string of the symbol -- private to restrict access
    
    @Published private(set) var model = createMatchingGame()
    //@Published will push this model again when it is updated
    
    //MARK: - Intent(s)
    
    func choose(_ inBoundSymbol: Symbols) {
        model.choose(inBoundSymbol)
    } // end choose -- invoke the model.choose
    
    
    func shuffle(){
        model.shuffle()
    } // end func shuffle -- this function shuffles the cards
    
} // end SymbolMatchGame -- initializes the model of MatchingGame
