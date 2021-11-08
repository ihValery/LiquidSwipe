//
//  OnePage.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 04.11.2021.
//

import SwiftUI

struct OnePage: View {
   var timeOfDay: TimeOfDayDO
   
   var body: some View {
      ZStack {
         timeOfDay.image
            .resizable()
            .scaledToFill()
            .offset(y: getRect().height > 1000 ? -180 : 0)
            .frame(maxWidth: getRect().width)
            .frame(maxHeight: .infinity)
            .clipped()
         
         Text(timeOfDay.title)
            .font(.largeTitle).bold()
            .foregroundColor(.white)
            .shadow(color: .white, radius: 10, x: 0, y: 0)
            .padding(30)
            .padding(.bottom, getRect().height > 1000 ? 200 : 0)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
      }
   }
}

struct OnePage_Previews: PreviewProvider {
   static var previews: some View {
      let timeOfDay = TimeOfDayOO().data[0]
      OnePage(timeOfDay: timeOfDay)
   }
}
