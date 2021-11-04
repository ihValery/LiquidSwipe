//
//  TimeOfDayOO.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 04.11.2021.
//

import SwiftUI

class TimeOfDayOO: ObservableObject {
    @Published var data: [TimeOfDayDO] = [TimeOfDayDO(title: "Morning", image: Image("morning")),
                                          TimeOfDayDO(title: "Day", image: Image("day")),
                                          TimeOfDayDO(title: "Night", image: Image("night"))]
}
