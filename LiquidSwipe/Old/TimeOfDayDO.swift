//
//  TimeOfDayDO.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 04.11.2021.
//

import SwiftUI

struct TimeOfDayDO: Identifiable {
   var id = UUID().uuidString
   var title: String
   var image: Image
   var offset: CGSize = .zero
}
