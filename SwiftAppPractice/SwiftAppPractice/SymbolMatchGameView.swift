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
            AspectVGrid(items: Game.model.symbol, aspectRatio: 2/3, content: { index in
                SymbolView(index)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        Game.choose(index)
                    } // end onTapGesture -- when the shapes are tapped, do this body
            }) // end aspectVGrid
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
        GeometryReader(content: { geometry in
            ZStack{
                let shape = Circle().fill(Color.yellow) // when face up, change color to brighter yellow
                shape.overlay((Text(symbol.content)
                                .rotationEffect(Angle.degrees(symbol.isMatched ? 360: 0)) // if matched, rotate 360 degrees otherwise do not rotate
                                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false)) // placement of animation modifier affects what it animates, be careful, putting it at the end of the .scaleEffect will animate EVERYTHING ABOVE 
                                .font(Font.system(size: 32)))
                                .scaleEffect(scale(thatFits: geometry.size)))
                //overlay modifier changed the way things stacked, symbol is now on the circle centered with automatically adjusting size symbol
                // overlay makes text size to circle whereas .background would make the shape sized to the text and stacked Shape on Text
                Pie(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 0)).size(CGSize(width: 25, height: 25)).fill(Color.red) // small upper left circle that animates when timer goes down
            }// end zstack
            .symbolize(isFaceUp: symbol.isFaceUp, isMatch: symbol.isMatched)
        })// end geomteryReader
    } // end body
    
    private func scale(thatFits size: CGSize) -> CGFloat{
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    } // end scale -- return a float to scale the symbols
    
    private struct DrawingConstants{
        static let fontScale: CGFloat = 0.75
        static let fontSize: CGFloat = 32
    } // end DrawingConstants
} // end SymbolView
