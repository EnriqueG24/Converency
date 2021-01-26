//
//  BitcoinNetworkManager.swift
//  Converency
//
//  Created by Enrique Gongora on 1/25/21.
//

import SwiftUI

class BitcoinNetworkManager: ObservableObject {
    
    // We'll use Published so whenever any of these properties change, it will notify all the listeners
    @Published var currencyCode: [String] = []
    @Published var buyingPrice: [Double] = []
    @Published var symbolArray: [String] = []
    
    init() {
        fetchCryptoData { (bitcoin) in
            switch bitcoin {
            case .success(let currency):
                currency.forEach { (currencies) in
                    // Ensure this is done on the main thread to prevent the data from not loading with the app
                    DispatchQueue.main.async {
                        self.currencyCode.append(currencies.key)
                        self.symbolArray.append(currencies.value.symbol)
                        self.buyingPrice.append(currencies.value.buy)
                    }
                }
            case .failure(let error):
                print("Failed to fetch courses", error)
            }
        }
    }
    
    /// This Function is our network call to the API to fetch our necessary data
    func fetchCryptoData(completion: @escaping (Result<Bitcoin, Error>) -> ()) {
        // Safely unwrap our URL
        guard let url = URL(string: "https://blockchain.info/ticker") else { return }
        // Create a URLSession
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle any errors
            if let error = error {
                completion(.failure(error))
                return
            }
            // Safely unwrap our data
            guard let safeData = data else { return }
            
            do {
                // Decode our JSON Data
                let bitcoin = try JSONDecoder().decode(Bitcoin.self, from: safeData)
                completion(.success(bitcoin))
            } catch let jsonError {
                // Catch any errors when we try to decode our JSON Data
                completion(.failure(jsonError))
            }
        }.resume()
    }
}
