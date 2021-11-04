//
//  ContentView.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 04.11.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("morning")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getRect().width, height: getRect().height)
                .clipped()
            
            Text("Morning")
                .font(.largeTitle).bold()
                .foregroundColor(.white)
                .shadow(color: .white, radius: 10, x: 0, y: 0)
                .padding(30)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
