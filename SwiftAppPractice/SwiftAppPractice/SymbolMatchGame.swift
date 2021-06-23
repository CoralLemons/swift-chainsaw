//
//  SymbolMatchGame.swift
//  SwiftAppPractice
//
//  Created by Leeann Warren on 6/22/21.
//

import SwiftUI

class SymbolMatchGame: ObservableObject { //
    typealias Symbols = MatchingGame<String>.Symbols
    
    private static let symbols = ["🐭","🐹","🦄","🐙","🐕","🦤","🐔","🐝","🦉","🐬","🐀","🐄", "🦩","🐘","🦙","🦔"] // 16  animals
    
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
    
} // end SymbolMatchGame -- initializes the model of MatchingGame
