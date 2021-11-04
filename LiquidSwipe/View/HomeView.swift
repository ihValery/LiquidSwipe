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
    
    var body: some View {
        ZStack {
            //Почему мы используем indices...
            //Так как offset обновляется в реальном времени
            ForEach(oo.data.indices.reversed(), id: \.self) { index in
                OnePage(timeOfDay: oo.data[index])
                    .clipShape(LiquidShape(offset: offset))
                    .ignoresSafeArea()
                    .overlay(
                        Button(action: { print("Tap!") },
                               label: {
                                   Image(systemName: "chevron.compact.left")
                                       .font(.largeTitle)
                                       .foregroundColor(.gray)
                                       .offset(x: -5, y: getRect().height > 750 ? 327 : 155)
                                       .frame(maxWidth: 10, maxHeight: .infinity)
                                        //Определяет форму содержимого для проверки попадания. Не понятно.
                                       .contentShape(Rectangle())
                                       .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                                                    offset = value.translation
                                                }
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
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width + offset.width
        
        var p = Path()
        p.move(to: CGPoint(x: 0, y: 0))
        p.addLine(to: CGPoint(x: rect.width, y: 0))
        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))
        
        //из
        let from: CGFloat = (rect.height - 180)
        p.move(to: CGPoint(x: rect.width, y: from))
        
        //Середина между 80 - 180
        let mid: CGFloat = (rect.height - 130)
        p.addCurve(to: CGPoint(x: rect.width, y: rect.height - 80),
                   control1: CGPoint(x: width, y: mid),
                   control2: CGPoint(x: width, y: mid))
        
        return p
    }
}
