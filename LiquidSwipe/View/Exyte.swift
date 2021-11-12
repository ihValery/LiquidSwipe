//
//  Exyte.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 12.11.2021.
//

import SwiftUI

struct Exyte: View {
   @State private var leftData = SliderData(side: .left)
   @State private var rightData = SliderData(side: .right)
   
   @State private var topSlider = SliderSide.right
   @State private var sliderOffset: CGFloat = 0
   
   @State private var pageIndex: Int = 0
   
    var body: some View {
       ZStack {
          content()
          slider(data: $leftData)
          slider(data: $rightData)
       }
       .edgesIgnoringSafeArea(.vertical)
    }
   
   func content() -> some View {
      Rectangle().fill(Config.colors[pageIndex])
   }
   
   func slider(data: Binding<SliderData>) -> some View {
      ZStack {
         wave(data: data)
//         button(data: data.wrappedValue)
//         ChevronView
      }
      .zIndex(topSlider == data.wrappedValue.side ? 1 : 0)
      .offset(x: data.wrappedValue.side == .left ? -sliderOffset : sliderOffset)
   }
   
   ///Возвращает индекс следующей (или предыдущей) страницы - в зависимости от стороны ползунка.
   ///Также обрабатывает переключение между первой и последней страницей:
   private func index(of data: SliderData) -> Int {
      let last = Config.colors.count - 1
      if data.side == .left {
         return pageIndex == 0 ? last : pageIndex - 1
      } else {
         return pageIndex == last ? 0 : pageIndex + 1
      }
   }
   
   ///Иинициирование переключения страниц отвечает отдельная
   private func swipe(data: Binding<SliderData>) {
      withAnimation() {
         data.wrappedValue = data.wrappedValue.finalWave()
      }
      
   }
   
   func wave(data: Binding<SliderData>) -> some View {
      let gesture = DragGesture()
         .onChanged {
            topSlider = data.wrappedValue.side
            data.wrappedValue = data.wrappedValue.drag(value: $0)
         }
         .onEnded { value in
            if data.wrappedValue.isCancelled(value: value) {
               withAnimation(.spring(dampingFraction: 0.5)) {
                  data.wrappedValue = data.wrappedValue.initialWave()
               }
            } else {
               swipe(data: data)
            }
         }
         .simultaneously(with: TapGesture().onEnded{
            topSlider = data.wrappedValue.side
            swipe(data: data)
         })
      return WaveView().gesture(gesture)
   }
}

struct Exyte_Previews: PreviewProvider {
    static var previews: some View {
        Exyte()
    }
}
