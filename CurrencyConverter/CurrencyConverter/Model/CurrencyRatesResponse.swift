//
//  CurrencyRatesResponse.swift
//  CurrencyConverter
//
//  Created by Victor Bozelli Alvarez on 05/01/20.
//  Copyright © 2020 Victor Bozelli Alvarez. All rights reserved.
//

import Foundation

struct CurrencyRatesResponse: Codable {
    //MARK: Variables
    var success: Bool!
    var timestamp: Int64!
    var base: String!
    var date: String!
    var rates: CurrencyRate!
    
    //MARK: Coding Keys
    fileprivate enum CodingKeys: String, CodingKey {
        case success = "success"
        case timestamp = "timestamp"
        case base = "base"
        case date = "date"
        case rates = "rates"
    }
}
