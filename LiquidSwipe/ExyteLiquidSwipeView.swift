//
//  ExyteView.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 09.11.2021.
//

import SwiftUI

struct ExyteLiquidSwipeView: View {
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

struct WaveView: View {
   var body: some View {
      ZStack {
         
      }
   }
}

struct ExyteView_Previews: PreviewProvider {
    static var previews: some View {
        ExyteLiquidSwipeView()
    }
}

enum SliderSide {
   case left
   case right
}

struct SliderData {
   let side: SliderSide
   let centerY: Double
   let progress: Double
   
   init(side: SliderSide) {
      self.side = side
      self.centerY = side == .left ? Config.leftStartY : Config.rightStartY
      self.progress = 0
   }
   
   init(side: SliderSide, centerY: Double, progress: Double) {
      self.side = side
      self.centerY = centerY
      self.progress = progress
   }
   
   static var width: Double {
      UIScreen.main.bounds.width
   }
   
   ///Прогресс линейно зависит от горизонтального положения волны, а центр волны равен точке касания.
   func drag(value: DragGesture.Value) -> SliderData {
      let dx = (side == .left ? 1 : -1) * Double(value.translation.width)
      let progress = min(1, max(0, dx * Config.swipeVelocity / SliderData.width))
      return SliderData(side: side, centerY: Double(value.location.y), progress: progress)
   }
   
   ///Проверяем достаточно ли длинна свайпа
   func isCancelled(value: DragGesture.Value) -> Bool {
      drag(value: value).progress < Config.swipeCancelThreshold
   }
   
   ///Начало волны progress: 0
   func initialWave() -> SliderData {
      SliderData(side: side, centerY: centerY, progress: 0)
   }
   
   ///Конец волны progress: 1
   func finalWave() -> SliderData {
      SliderData(side: side, centerY: centerY, progress: 1)
   }
}

struct Config {
   static let leftStartY = 100.0                            //Стартовая позиция
   static let rightStartY = 300.0
   static let swipeCancelThreshold = 0.15                   //Порог отмены
   static let swipeVelocity = 0.45                          //Скорость смахивания
   static let colors: [Color] = [.green, .yellow, .red]
}
