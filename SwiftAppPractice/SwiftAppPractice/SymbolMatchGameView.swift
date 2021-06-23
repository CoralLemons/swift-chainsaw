//
//  ContentView.swift
//  SwiftAppPractice
//
//  Created by Leeann Warren on 6/22/21.
//


// The stuff that goes in this file is the stuff that shows up
// on the device itself

import SwiftUI

let lemonYellow = Color(hue: 0.1639, saturation: 1, brightness: 1)

struct SymbolMatchGameView: View {
    @ObservedObject var Game : SymbolMatchGame
    // @ObservedObject means that this body will be rebuilt when changed
    
    var body: some View {
        ZStack{
        VStack{
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    ForEach(Game.model.symbol){ index in
                        SymbolView(index)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                Game.choose(index)
                            } // end onTapGesture -- when the shapes are tapped, do this body
                    }// end forEach --
                }// end LazyVGrid
                .padding(.all) // provide padding for the buttons/cards
            }// end scrollView
        }// end vStack
        }.background(Color("colorBackground")).edgesIgnoringSafeArea(.all) // fill the background with a color
        // end ZStack
        .padding(.top, 5) // notch the top
    } // end body
} // end contentView

struct SymbolView: View {
    private let symbol: SymbolMatchGame.Symbols // read only
    init(_ Symbol: SymbolMatchGame.Symbols) {
        self.symbol = Symbol
    } // end init
    
    var body: some View {
        let shape = Circle()
        ZStack{
            if symbol.isFaceUp {
                shape.fill(Color(.orange)).foregroundColor(.orange)
                shape.strokeBorder(Color.yellow, lineWidth: 3)
                shape.overlay(Text(symbol.content).font(.largeTitle) , alignment: .center) //overlay modifier changed the way things stacked, symbol is now on the circle centered
                    // overlay makes text size to circle whereas .background would make the shape sized to the text and stacked Shape on Text
                    .padding(.all)
            } // end if -- if the symbol card is face up, do this
            else if symbol.isMatched{
                shape.opacity(0) // like magic
            }// end else if -- if the symbols are matched, make them dissapear
            else{
                shape.overlay(Image("custom.brain").font(.largeTitle) , alignment: .center).foregroundColor(Color("AccentColor"))
            } // end else -- else just show brain symbol on the card face down
        }// end zstack
    } // end body
} // end SymbolView
