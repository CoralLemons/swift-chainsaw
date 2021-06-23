//
//  SwiftAppPracticeApp.swift
//  SwiftAppPractice
//
//  Created by Leeann Warren on 6/22/21.
//

// This is the main for the contentView file to open and run

import SwiftUI

@main
struct SwiftAppPracticeApp: App {
    private let game = SymbolMatchGame() // uses the init in SymbolMatchGame
    
    var body: some Scene {
        WindowGroup {
            SymbolMatchGameView(Game: game)
        }
    } // end body
} // end SwiftAppPracticeApp
