//
//  ContentView.swift
//  SwiftAppPractice
//
//  Created by Leeann Warren on 6/22/21.
//


// The stuff that goes in this file is the stuff that shows up
// on the device itself

import SwiftUI

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
        GeometryReader(content: { geometry in
            ZStack{
                if symbol.isFaceUp {
                    // commented the two below shape modifiers because they cut off the automatically adjusting overlay <-- find a fix!
                    //shape.fill(Color(.orange)).foregroundColor(.orange)
                    shape.strokeBorder(Color.yellow, lineWidth: DrawingConstants.lineWidth)
                    shape.overlay(Text(symbol.content)
                                    //.background(Color.yellow) // <-- take all of this background and text stuff and find a way to put it together into the overlay!!!!!!!!!!!!!!!!!!!!!!!!!
                                    .font(font(in: geometry.size))) //overlay modifier changed the way things stacked, symbol is now on the circle centered with automatically adjusting size symbol
                        // overlay makes text size to circle whereas .background would make the shape sized to the text and stacked Shape on Text
                } // end if -- if the symbol card is face up, do this
                else if symbol.isMatched{
                    shape.opacity(0) // like magic
                    // some code here for score later
                }// end else if -- if the symbols are matched, make them dissapear
                else{
                    shape.overlay(Image("custom.brain").font(.largeTitle) , alignment: .center).foregroundColor(Color("AccentColor"))
                } // end else -- else just show brain symbol on the card face down
            }// end zstack
        })// end geomteryReader
    } // end body
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    } // end font func
    
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 20 // for rectangle
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    } // end DrawingConstants
} // end SymbolView
