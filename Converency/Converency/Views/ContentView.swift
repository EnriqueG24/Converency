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
                    BitcoinView().tabItem {
                        Image(systemName: "bitcoinsign.square.fill")
                        Text("Bitcoin")
                    }.tag(0)
                    
                    CurrencyView().tabItem {
                        Image(systemName: "dollarsign.square.fill")
                        Text("Currency")
                    }.tag(1)
                })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
