//
//  LiquidShape.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 05.11.2021.
//

import SwiftUI

struct LiquidShape: Shape {
    var offset: CGSize
    var location: CGPoint
    var side: Side

    var animatableData: AnimatablePair<CGSize.AnimatableData, CGPoint.AnimatableData> {
        get {
            AnimatablePair(offset.animatableData, location.animatableData)
        }
        set {
            offset.animatableData = newValue.first
            location.animatableData = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        //Прямоугольник во весь акран и внутри "кляксу"
        p.move(to: CGPoint(x: 0, y: 0))
        p.addLine(to: CGPoint(x: rect.width, y: 0))
        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))
        
        //Строить "кляксу" по 4 точкам Безье
        let A = CGPoint(x: side.width(rect.width), y: location.y + side.minHeight + offset.width)
        let B = CGPoint(x: side.width(rect.width) + offset.width, y: location.y)
        let C = CGPoint(x: side.width(rect.width), y: location.y - side.minHeight - offset.width)
        
        let ABcontrol1 = CGPoint(x: side.width(rect.width), y: (A.y + B.y) / 2)
        let ABcontrol2 = CGPoint(x: side.width(rect.width) + offset.width, y: (A.y + B.y) / 2)
        let BCcontrol1 = CGPoint(x: side.width(rect.width) + offset.width, y: (B.y + C.y) / 2)
        let BCcontrol2 = CGPoint(x: side.width(rect.width), y: (B.y + C.y) / 2)
        
        p.move(to: A)
        p.addCurve(to: B, control1: ABcontrol1, control2: ABcontrol2)
        p.addCurve(to: C, control1: BCcontrol1, control2: BCcontrol2)
        
        return p
    }
}
