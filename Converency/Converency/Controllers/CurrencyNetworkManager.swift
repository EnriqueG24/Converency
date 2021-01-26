//
//  CurrencyNetworkManager.swift
//  Converency
//
//  Created by Enrique Gongora on 1/25/21.
//

import SwiftUI

class NetworkManager: ObservableObject {
    
    @Published var currencyCode: [String] = []
    @Published var exchangePrice: [Double] = []
    
    init() {
        fetchCurrencyData { (currency) in
            switch currency {
            case .success(let prices):
                // Ensure this is done on the main thread so it loads up on time
                DispatchQueue.main.async {
                    self.currencyCode.append(contentsOf: prices.rates.keys)
                    self.exchangePrice.append(contentsOf: prices.rates.values)
                }
            case .failure(let error):
                print("Failed to fetch currency data", error)
            }
        }
    }
    
    func fetchCurrencyData(completion: @escaping (Result<CurrencyData, Error>) -> ()) {
        // Safely unwrap our URL
        guard let url = URL(string: "https://open.exchangerate-api.com/v6/latest") else { return }
        // Create our URLSession
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle any errors if there are any
            if let error = error {
                completion(.failure(error))
                return
            }
            // Safely unwrap our data
            guard let safeData = data else { return }
            do {
                // Decode our JSON Data
                let currency = try JSONDecoder().decode(CurrencyData.self, from: safeData)
                completion(.success(currency))
            } catch {
                // Catch any errors that may occur during the decoding process
                completion(.failure(error))
            }
        }.resume()
    }
}
