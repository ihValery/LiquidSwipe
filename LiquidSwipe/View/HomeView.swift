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
                
                //MARK: - Left
                    .clipShape(LiquidShape(offset: offset, location: location, side: .left))
                    .overlay(
                        ChevronView(isDragging: isDragging, isAnimation: isAnimation, side: .left)
                            .gesture(
                                DragGesture()
                                    .updating($isDragging) { _, state, _ in
                                        state = true
                                    }
                                    .onChanged { value in
                                        offset = value.translation
//                                        oo.data[fakeIndex].offset = value.translation
                                        location = value.location
                                    }
                                    .onEnded { value in
                                        withAnimation(.easeOut) {
//                                            if oo.data[fakeIndex].offset.width > getRect().width / 5 * 4 {
//                                                oo.data[fakeIndex].offset.width = getRect().height * 2
//                                                fakeIndex += 1
//                                            } else {
                                            offset = .zero
//                                                oo.data[fakeIndex].offset = .zero
//                                            }
                                        }
                                    }
                            )
                        , alignment: .leading
                    )
                
//                //MARK: - Rigth
                    .clipShape(LiquidShape(offset: oo.data[index].offset, location: location, side: .right))
                    .overlay(
                        ChevronView(isDragging: isDragging, isAnimation: isAnimation, side: .right)
                            .gesture(
                                DragGesture()
                                    .updating($isDragging) { _, state, _ in
                                        state = true
                                    }
                                    .onChanged { value in
                                        oo.data[fakeIndex].offset = value.translation
                                        location = value.location
                                    }
                                    .onEnded { value in
                                        withAnimation(.easeOut) {
                                            if -oo.data[fakeIndex].offset.width > getRect().width / 5 * 4 {
                                                oo.data[fakeIndex].offset.width = -getRect().height * 2
                                                fakeIndex += 1

                                                //Обновление оригенального индекса
                                                if currentIndex == oo.data.count - 3 {
                                                    currentIndex = 0
                                                } else {
                                                    currentIndex += 1
                                                }

                                                //Когда fakeindex достигает предпоследнего элемента
                                                //Снова переключаемся на первый елемент, чтобы создать ощущение бесконечной карусели
                                                //Не большая задержка для завершения анимации смахивания
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    if fakeIndex == oo.data.count - 2 {
                                                        for i in 0..<oo.data.count - 2 {
                                                            oo.data[i].offset = .zero
                                                        }

                                                        fakeIndex = 0
                                                    }
                                                }


                                            } else {
                                                oo.data[fakeIndex].offset = .zero
                                            }
                                        }
                                    }
                            )
                        , alignment: .trailing
                    )
                //MARK: -
                
                    .ignoresSafeArea()
            }
            
            .onAppear {
                isAnimation.toggle()

                //Меняем последний элемент с первым
                //и первый с последним, чтобы создать ощущение бесконечной карусели
                guard let first = oo.data.first else { return }
                guard var last = oo.data.last else { return }

                last.offset.width = -getRect().height * 2

                oo.data.append(first)
                oo.data.insert(last, at: 0)

                fakeIndex = 1

                for i in 0..<oo.data.count {
                    print(oo.data[i].title)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
