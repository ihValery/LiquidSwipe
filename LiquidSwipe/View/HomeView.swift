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
    @GestureState private var isDragging = false
    @State private var isAnimation = false
    
    @State private var fakeIndex: Int = 0
    @State private var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            //Почему мы используем indices...
            //Так как offset обновляется в реальном времени
            ForEach(oo.data.indices.reversed(), id: \.self) { index in
                OnePage(timeOfDay: oo.data[index])
//                    .clipShape(LiquidShape(offset: offset, location: location, side: .left))
//                    .ignoresSafeArea()
                
                    //Left
//                    .clipShape(LiquidShape(offset: offset, location: location, side: .left))
//                    .overlay(
//                        Image(systemName: "chevron.compact.right")
//                            .font(.largeTitle)
//                            .foregroundColor(.black)
//                            .opacity(isDragging ? 0 : 0.6)
//                            .animation(.linear, value: isDragging)
//
//                            .offset(x: isAnimation ? 10 : -10)
//                            .opacity(isAnimation ? 0 : 1)
//                            .animation(.easeInOut(duration: 2).delay(1).repeatForever(autoreverses: false), value: isAnimation)
//
//                            .frame(maxWidth: 10, maxHeight: .infinity)
//                            //Определяет форму содержимого для проверки попадания.
//                            //Область нажатия работает вся, а свайп только на offset
//                            .contentShape(Rectangle())
//                            .gesture(
//                                DragGesture()
//                                    .updating($isDragging) { _, state, _ in
//                                        state = true
//                                    }
//                                    .onChanged { value in
//                                        offset = value.translation
//                                        location = value.location
//                                    }
//                                    .onEnded { value in
//                                        withAnimation(.easeIn) {
//                                            offset = .zero
//                                        }
//                                    }
//                            )
//                        , alignment: .leading
//                    )
                
                    //Rigth
                    .clipShape(LiquidShape(offset: oo.data[index].offset, location: location, side: .right))
                    .overlay(
                        Image(systemName: "chevron.compact.left")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .opacity(isDragging ? 0 : 0.6)
                            .animation(.linear, value: isDragging)

                            .offset(x: isAnimation ? -10 : 10)
                            .opacity(isAnimation ? 0 : 1)
                            .animation(.easeInOut(duration: 2).delay(1).repeatForever(autoreverses: false), value: isAnimation)
                        
                            .frame(maxWidth: 10, maxHeight: .infinity)
                            //Определяет форму содержимого для проверки попадания.
                            //Область нажатия работает вся, а свайп только на offset
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .updating($isDragging) { _, state, _ in
                                        state = true
                                    }
                                    .onChanged { value in
                                            oo.data[currentIndex].offset = value.translation
                                            location = value.location
                                    }
                                    .onEnded { value in
                                        withAnimation(.easeIn) {
                                            if -oo.data[currentIndex].offset.width > getRect().width / 5 * 4 {
                                                oo.data[currentIndex].offset.width = -getRect().height * 1.5
                                            } else {
                                                oo.data[currentIndex].offset = .zero
                                            }
                                        }
                                    }
                            )
                        , alignment: .trailing
                    )
//                    .padding(.trailing)
                    .ignoresSafeArea()
            }
            
            .onAppear {
                isAnimation.toggle()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
