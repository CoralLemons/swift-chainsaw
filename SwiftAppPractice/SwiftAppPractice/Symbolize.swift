//
//  Symbolize.swift
//  SwiftAppPractice
//
//  Created by Leeann Warren on 6/24/21.
//
import Foundation
import SwiftUI

struct Symbolize: ViewModifier {
    var isFaceUp: Bool
    var isMatch: Bool
    
    func body(content: Content) -> some View {
        ZStack{
            content.opacity(isFaceUp ? 1:0)
            if !isFaceUp && !isMatch{
                let shape = Circle().fill(Color("AccentColor"))
                shape.overlay(Image("custom.brain").font(.largeTitle) ,alignment: .center)
            // if it is not a match, show the default logo, otherwise make them dissapear
            } // end else -- else just show brain symbol on the card face down
        }// end zstack
} // end body of func
    
    private struct DrawingConstants{
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    } // end DrawingConstants
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    } // end font func
} // end Symbolize --  returns a 'card' AKA a symbol circle of a given or passed emoji

extension View {
    func symbolize(isFaceUp: Bool, isMatch: Bool) -> some View{
         self.modifier(Symbolize(isFaceUp: isFaceUp, isMatch: isMatch))
     } // end symbolize func -- return the view so .symbolize can be called in place of .modifier(Symbolize(isFaceUp))
 } // end View extension
