//
//  SymbolMatchGame.swift
//  SwiftAppPractice
//
//  Created by Leeann Warren on 6/22/21.
//

import SwiftUI

class SymbolMatchGame: ObservableObject { //
    typealias Symbols = MatchingGame<String>.Symbols
    
    private static let symbols = ["🐭","🐹","🦄","🐙","🐕","🦤","🐔","🐝","🦉","🐬","🐀","🐄"] // 12 animals
    
    private static func createMatchingGame() -> MatchingGame<String> {
        MatchingGame<String>(numberOfSymbols: symbols.count){pairIndex in
            symbols[pairIndex] //
        } // create a model with # of total symbols in the array 'symbols'
    }// passes the string of the symbol -- private to restrict access
    
    @Published private(set) var model = createMatchingGame() // this does the same thing as below that is commented out
    //@Published will push this model again when it is updated
    
    //MARK: - Intent(s)
    
    func choose(_ inBoundSymbol: Symbols) {
       // objectWillChange.send()// model has changed -- we do not necessarily need this because of the above @Published 
        model.choose(inBoundSymbol)
    } // end choose -- invoke the model.choose
    
    
    //var symbols: Array<Symbols> {
    //    return model.symbol
    //} // end symbols return -- return the struct/array of symbols
    
} // end SymbolMatchGame -- initializes the model of MatchingGame
