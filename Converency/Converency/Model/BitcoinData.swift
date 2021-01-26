//
//  BitcoinData.swift
//  Converency
//
//  Created by Enrique Gongora on 1/25/21.
//

import Foundation

struct BitcoinData: Codable {
    let buy: Double
    let symbol: String
}

typealias Bitcoin = [String : BitcoinData]
