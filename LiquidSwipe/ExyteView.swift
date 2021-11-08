//
//  ExyteView.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 09.11.2021.
//

import SwiftUI

struct ExyteView: View {
//   @State private var leftData = Slide
   
    var body: some View {
       ZStack {
//          content()
//          slider()
       }
    }
}

struct ExyteView_Previews: PreviewProvider {
    static var previews: some View {
        ExyteView()
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
      self.centerY = side == .left ? 100 : 300
      self.progress = 0
   }
   
}
