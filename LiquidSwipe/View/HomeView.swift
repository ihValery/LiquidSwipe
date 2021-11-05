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
                                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                                            offset = .zero
                                        }
                                    }
                            )
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
