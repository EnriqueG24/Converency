//
//  BitcoinView.swift
//  Converency
//
//  Created by Enrique Gongora on 1/25/21.
//

import SwiftUI

struct BitcoinView: View {
    
    @ObservedObject var bitcoinNetworkManager = BitcoinNetworkManager()
    @State private var pickerSelection = 0
    @State private var amount: String = ""
    
    var total: Double {
        // Ensure that our array has at least 1 item to avoid index out of range errors
        guard bitcoinNetworkManager.buyingPrice.count > 0 else { return 0 }
        
        let buyingPrice = bitcoinNetworkManager.buyingPrice[pickerSelection]
        let doubleAmount = Double(amount) ?? 0.0
        let totalAmount = buyingPrice * doubleAmount
        return totalAmount
    }
    
    var symbol: String {
        // Ensure that our array has at least 1 item to avoid index out of range errors
        guard bitcoinNetworkManager.symbolArray.count > 0 else { return "" }
        let currencySymbol = bitcoinNetworkManager.symbolArray[pickerSelection]
        return currencySymbol
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundBlue")
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("\(symbol)\(total, specifier: "%.2f")")
                    .font(.system(size: 30))
                
                Spacer()
                
                TextField("Enter Amount:", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()
                Picker("", selection: $pickerSelection) {
                    ForEach(0..<bitcoinNetworkManager.currencyCode.count) {
                        let currency = bitcoinNetworkManager.currencyCode[$0]
                        Text(currency)
                    }
                }
                .id(UUID())
                .labelsHidden()
            }.padding()
        }
    }
}

struct BitcoinView_Previews: PreviewProvider {
    static var previews: some View {
        BitcoinView()
    }
}
