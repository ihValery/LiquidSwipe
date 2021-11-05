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
//                    .clipShape(LiquidShape(offset: offset, location: location, side: .left))
//                    .ignoresSafeArea()
                
                    //Left
                    .clipShape(LiquidShape(offset: offset, location: location, side: .left))
                    .overlay(
                        Image(systemName: "chevron.compact.right")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .opacity(0.3)
                            .offset(x: 5)
                            .frame(maxWidth: 10, maxHeight: .infinity)
                            //Определяет форму содержимого для проверки попадания.
                            //Область нажатия работает вся, а свайп только на offset
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        offset = value.translation
                                        location = value.location
                                    }
                                    .onEnded { value in
                                        withAnimation(.easeIn) {
                                            offset = .zero
                                        }
                                    }
                            )
                        , alignment: .leading
                    )
                
                    //Rigth
                    .clipShape(LiquidShape(offset: offset, location: location, side: .right))
                    .overlay(
                        Image(systemName: "chevron.compact.left")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .opacity(0.3)
                            .offset(x: -5)
                            .frame(maxWidth: 10, maxHeight: .infinity)
                            //Определяет форму содержимого для проверки попадания.
                            //Область нажатия работает вся, а свайп только на offset
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        offset = value.translation
                                        location = value.location
                                    }
                                    .onEnded { value in
                                        withAnimation(.easeIn) {
                                            offset = .zero
                                        }
                                    }
                            )
                        , alignment: .trailing
                    )
//                    .padding(.trailing)
                    .ignoresSafeArea()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
