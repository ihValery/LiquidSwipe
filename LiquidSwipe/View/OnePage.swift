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
                .aspectRatio(contentMode: .fill)
                .frame(width: getRect().width, height: getRect().height)
                .clipped()
            
            Text(timeOfDay.title)
                .font(.largeTitle).bold()
                .foregroundColor(.white)
                .shadow(color: .white, radius: 10, x: 0, y: 0)
                .padding(30)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        }
    }
}

struct OnePage_Previews: PreviewProvider {
    static var previews: some View {
        let timeOfDay = TimeOfDayOO().data.first!
        OnePage(timeOfDay: timeOfDay)
    }
}
