//
//  Symbolize.swift
//  SwiftAppPractice
//
//  Created by Leeann Warren on 6/24/21.
//
import Foundation
import SwiftUI

struct Symbolize: AnimatableModifier {
    //var isFaceUp: Bool
    var isMatch: Bool
    
    init(isFaceUp: Bool){
        rotationDegrees = isFaceUp ? 0 : 180
        isMatch = false
    }// end init -- initialize the Bool var isFaceUp to be assigned to rotationDegrees
    
    var animatableData: Double {
        get {rotationDegrees}
        set {rotationDegrees = newValue}
    } // for degrees instead of emptyAnimateableData -- getter and setter inside
    var rotationDegrees: Double
    
    func body(content: Content) -> some View {
        ZStack{
            content.opacity(rotationDegrees < 90 ? 1:0)
            if (rotationDegrees > 90){ // rotation > 90
                let shape = Circle().fill(Color("AccentColor"))
                shape.overlay(Image("custom.brain").font(.largeTitle) ,alignment: .center)
            // if it is not a match, show the default logo, otherwise make them dissapear
            } // end else -- else just show brain symbol on the card face down
        }// end zstack
        .rotation3DEffect(
            Angle.degrees(rotationDegrees > 90 ? 0 : 180),
            axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
        ) // end 3D 'flip' effect animation
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
         self.modifier(Symbolize(isFaceUp: isFaceUp))
     } // end symbolize func -- return the view so .symbolize can be called in place of .modifier(Symbolize(isFaceUp))
 } // end View extension
