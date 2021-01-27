//
//  CurrencyView.swift
//  Converency
//
//  Created by Enrique Gongora on 1/25/21.
//

import SwiftUI

struct CurrencyView: View {
    
    @ObservedObject var currencyNetworkManager = CurrencyNetworkManager()
    @State private var pickerSelection = 0
    @State private var amount: String = ""
    
    var total: Double {
        guard currencyNetworkManager.exchangePrice.count > 0 else { return 0}
        let buyingPrice = currencyNetworkManager.exchangePrice[pickerSelection]
        let doubleAmount = Double(amount) ?? 0.0
        let totalAmount = buyingPrice * doubleAmount
        return totalAmount
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundBlue")
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("\(total, specifier: "%.2f")")
                    .font(.system(size: 30))
                Spacer()
                TextField("Enter Amount", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()
                Picker("", selection: $pickerSelection) {
                    ForEach(0..<currencyNetworkManager.currencyCode.count) {
                        let currency = currencyNetworkManager.currencyCode[$0]
                        Text(currency)
                    }
                }
                .id(UUID())
                .labelsHidden()
            }.padding()
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
