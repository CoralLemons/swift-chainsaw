//
//  ContentView.swift
//  SwiftAppPractice
//
//  Created by Leeann Warren on 6/22/21.
//


// The stuff that goes in this file is the stuff that shows up
// on the device itself

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewGame : SymbolMatchGame
    // @ObservedObject means that this body will be rebuilt when changed
    
    var body: some View {
        VStack{
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    ForEach(viewGame.model.symbol){ index in
                        SymbolView(symbol: index)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewGame.choose(index)
                            } // end onTapGesture -- when the shapes are tapped, do this body
                    }// end forEach --
                }// end LazyVGrid
            }// end scrollView
        }// end vStack
        .padding(.horizontal)
    } // end body
    
} // end contentView

struct SymbolView: View {
    let symbol: MatchingGame<String>.Symbols // read only
    
    var body: some View {
        let shape = RoundedRectangle.init(cornerRadius: 20)
        ZStack{
            if symbol.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(Color.orange, lineWidth: 3)
                Text(symbol.content).font(.largeTitle)
                    .padding(.all)
            } // end if -- if the symbol card is face up, do this
            else if symbol.isMatched{
                shape.opacity(0) // like magic
            }// end else if -- if the symbols are matched, make them dissapear
            else{
                shape.fill(Color.purple)
            } // end else -- else just show the symbol shape filled
        }// end zstack
    } // end body
} // end SymbolView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SymbolMatchGame()
        ContentView(viewGame: game)
    }
}// end preview struct
