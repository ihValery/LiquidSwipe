//
//  ChevronView.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 06.11.2021.
//

import SwiftUI

struct ChevronView: View {
    var isDragging: Bool
    var isAnimation: Bool
    var side: Side
    
    var body: some View {
        Image(systemName: side.image)
            .font(.largeTitle)
            .foregroundColor(.black)
            .opacity(isDragging ? 0 : 0.6)
            .animation(.linear, value: isDragging)
        
            .offset(x: side.offset(bool: isAnimation))
            .opacity(isAnimation ? 0 : 1)
            .animation(.easeInOut(duration: 2).delay(1).repeatForever(autoreverses: false), value: isAnimation)
        
            .frame(maxWidth: 10, maxHeight: .infinity)
            //Определяет форму содержимого для проверки попадания.
            //Область нажатия работает вся, а свайп только на offset
            .contentShape(Rectangle())
    }
}
