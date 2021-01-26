//
//  ContentView.swift
//  Converency
//
//  Created by Enrique Gongora on 1/25/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab,
                content:  {
                    BitcoinView().tabItem { Text("Bitcoin") }.tag(1)
                    
                    CurrencyView().tabItem { Text("Currency") }.tag(2)
                })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
