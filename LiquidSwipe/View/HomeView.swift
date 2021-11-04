//
//  HomeView.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 04.11.2021.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var oo = TimeOfDayOO()
    
    var body: some View {
        ZStack {
            //Почему мы используем indices...
            //Так как offset обновляется в реальном времени
            ForEach(oo.data.indices.reversed(), id: \.self) { index in
                OnePage(timeOfDay: oo.data[index])
            }
        }
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
