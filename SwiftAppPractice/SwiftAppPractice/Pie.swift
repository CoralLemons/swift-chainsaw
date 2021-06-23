//
//  Pie.swift
//  SwiftAppPractice
//
//  Created by Leeann Warren on 6/23/21.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockWise: Bool = true // default true for clockwise rotation
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY) // get the center point of both X and Y of a rectangle
        let radius = min(rect.width, rect.height) / 2 // formula for radius
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(sin(startAngle.radians))
        )// end start point -- using trig to find the starting point -- CGFloat() type conversion used
        
        var pth = Path() // new empty path
        pth.move(to: center)
        pth.addLine(to: start)
        pth.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockWise)
        pth.addLine(to: center)
        return pth
    } // end path -- will return a struct Path AKA drawing instructions
}// end Pie struct -- custom shape that will allow the animation of the timer Circle
