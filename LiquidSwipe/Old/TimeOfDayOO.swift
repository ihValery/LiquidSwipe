//
//  TimeOfDayOO.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 04.11.2021.
//

import SwiftUI

class TimeOfDayOO: ObservableObject {
   @Published var data: [TimeOfDayDO] = [
      TimeOfDayDO(title: "1   Morning", image: Image("morning")),
      TimeOfDayDO(title: "2   Day", image: Image("day")),
      TimeOfDayDO(title: "3   Night", image: Image("night"))
   ]
}
