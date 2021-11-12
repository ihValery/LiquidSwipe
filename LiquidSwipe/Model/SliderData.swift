//
//  SliderData.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 12.11.2021.
//

import SwiftUI

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
