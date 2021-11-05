//
//  HomeView.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 04.11.2021.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var oo = TimeOfDayOO()
    @State private var offset: CGSize = .zero
    @State private var location: CGPoint = .zero
    
    var body: some View {
        ZStack {
            //Почему мы используем indices...
            //Так как offset обновляется в реальном времени
            ForEach(oo.data.indices.reversed(), id: \.self) { index in
                OnePage(timeOfDay: oo.data[index])
                    .clipShape(LiquidShape(offset: offset, location: location))
                    .ignoresSafeArea()
                    .overlay(
                        Button(action: { print("Tap!") },
                               label: {
                                   Image(systemName: "chevron.compact.left")
                                       .font(.largeTitle)
                                       .foregroundColor(.gray)
                                       .offset(x: -5, y: getRect().height > 750 ? 327 : 155)
                                       .frame(maxWidth: 10, maxHeight: .infinity)
                                        //Определяет форму содержимого для проверки попадания.
                                        //Область нажатия работает вся, а свайп только на offset
                                       .contentShape(Rectangle())
                                       .gesture(
                                        DragGesture()
                                            .onChanged { value in
//                                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                                                    offset = value.translation
                                                    location = value.location
//                                                }
                                            }
                                            .onEnded { value in
                                                offset = .zero
                                            }
                                       )
                               })
                        , alignment: .bottomTrailing
                    )
//                    .padding(.trailing)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct LiquidShape: Shape {
    var offset: CGSize
    var location: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: 0, y: 0))
        p.addLine(to: CGPoint(x: rect.width, y: 0))
        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))
        
        let A = CGPoint(x: rect.width, y: location.y - offset.height - 280)// + offset.width)
        let B = CGPoint(x: rect.width + offset.width, y: location.y)
        let C = CGPoint(x: rect.width, y: location.y - offset.height + 280)// - offset.width)
        
//        let D = CGPoint(x: (A.x + B.x) / 2, y: (A.y + B.y) / 2)
//        let E = CGPoint(x: (B.x + C.x) / 2, y: (B.y + C.y) / 2)
//        let O = CGPoint(x: (D.x + E.x) / 2, y: (D.y + E.y) / 2)
//
        let pOffset = CGPoint(x: rect.width + offset.width, y: location.y)
        let t = 0.5
        let p05 = CGPoint(
            x: (pOffset.x - (pow(1 - t, 2) * A.x) - (pow(t, 2) * C.x)) / (2 * (1 - t) * t),
            y: (pOffset.y - (pow(1 - t, 2) * A.y) - (pow(t, 2) * C.y)) / (2 * (1 - t) * t))

//        let p2 = CGPoint(
//            x: (p05.x - (pow(0, 2) * one.x) - (pow(1, 2) * three.x)) / (2 * (1 - 1) * 1),
//            y: (p05.y - (pow(0, 2) * one.y) - (pow(1, 2) * three.y)) / (2 * (1 - 1) * 1))
        
        p.move(to: A)
//        p.addLine(to: B)
//        p.addLine(to: C)
        p.addQuadCurve(to: C, control: p05)
//        p.addCurve(to: C, control1: B, control2: B)
        
        
        //из
//        let from: CGFloat = location.y - offset.height
//        p.move(to: CGPoint(x: rect.width, y: from - 80))
//
//        p.addCurve(to: CGPoint(x: rect.width, y: from + 80),
//                   control1: CGPoint(x: rect.width + (offset.width / 2), y: location.y),
//                   control2: CGPoint(x: rect.width + (offset.width / 2), y: location.y))

        
        
        
        
//        p.addLine(to: CGPoint(x: rect.width + offset.width, y: location.y))
//        p.addLine(to: CGPoint(x: rect.width, y: from + 80))
        
//        //Середина между 80 - 180
//        let mid: CGFloat = (rect.height - 130)
//        p.addCurve(to: CGPoint(x: rect.width, y: from + 80),
//                   control1: CGPoint(x: width, y: mid),
//                   control2: CGPoint(x: width, y: mid))
        
//        print(pOffset)
//        print("offset \(offset)")
//        print("rect.width + offset.width \(rect.width + offset.width)")
        return p
    }
}
