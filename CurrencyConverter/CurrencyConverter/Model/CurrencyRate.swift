//
//  CurrencyRate.swift
//  CurrencyConverter
//
//  Created by Victor Bozelli Alvarez on 05/01/20.
//  Copyright © 2020 Victor Bozelli Alvarez. All rights reserved.
//

import Foundation

struct CurrencyRate: Codable {
    //MARK: Variables
    var aud: Float
    var usd: Float
    var cad: Float
    var gbp: Float
    var brl: Float
    var inr: Float
    
    //MARK: CodingKeys
    fileprivate enum CodingKeys: String, CodingKey {
        case aud = "AUD"
        case usd = "USD"
        case cad = "CAD"
        case gbp = "GBP"
        case brl = "BRL"
        case inr = "INR"
    }
    
    //MARK: Methods
    func getRate(currency: Currency) -> Float {
        if currency == .aud {
            return aud
        }
        if currency == .usd {
            return usd
        }
        if currency == .cad {
            return cad
        }
        if currency == .gbp {
            return gbp
        }
        if currency == .brl {
            return brl
        }
        if currency == .inr {
            return inr
        }
        return .zero
    }
}
