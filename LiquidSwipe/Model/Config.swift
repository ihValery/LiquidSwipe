//
//  Config.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 12.11.2021.
//

import SwiftUI

struct Config {
   static let leftStartY = 100.0                            //Стартовая позиция
   static let rightStartY = 300.0
   static let swipeCancelThreshold = 0.15                   //Порог отмены
   static let swipeVelocity = 0.45                          //Скорость смахивания
   static let colors: [Color] = [.green, .yellow, .red]
}
