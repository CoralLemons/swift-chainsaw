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
        GeometryReader{ geometry in
        ZStack{
            if isFaceUp {
                if isMatch == true{
                    let shape = Circle().fill(Color("AccentColor"))
                    shape.opacity(0)
                }// end isMatch if statement -- if it is a match, change to this view, otherwise default below
                else{
                    content
                } // end else -- if there is not a match AND card is face up, return the content
            } // end if -- if the symbol card is face up, do this
            else{
                let shape = Circle().fill(Color("AccentColor"))
                if !isMatch {
                    shape.overlay(Image("custom.brain").font(.largeTitle) ,alignment: .center)
                } // if the card was not a match, still show it, otherwise make it dissapear
                else{
                    shape.opacity(0)
                } // end else 
            } // end else -- else just show brain symbol on the card face down
        }// end zstack
    } // end georeader
    } // end body of func
    
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 20 // for rectangle shapes in the future
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
