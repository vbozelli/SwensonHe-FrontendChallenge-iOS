//
//  CurrencyRatesRequest.swift
//  CurrencyConverter
//
//  Created by Victor Bozelli Alvarez on 05/01/20.
//  Copyright © 2020 Victor Bozelli Alvarez. All rights reserved.
//

import Foundation

final class CurrencyRatesRequest {
    //MARK: Constants
    fileprivate static let path = "&symbols=AUD,USD,CAD,GBP,BRL,INR"
    
    //MARK: Methods
    static func getCurrencyRates(completion: @escaping (Bool, String?, CurrencyRate?) -> Void) {
        Requests.requestData(path: path) { (success, error, data) in
            if success, let data = data {
                do {
                    let currencyRatesResponse = try JSONDecoder().decode(CurrencyRatesResponse.self, from: data)
                    completion(true, nil, currencyRatesResponse.rates)
                }
                catch let e {
                    completion(false, e.localizedDescription, nil)
                }
            }
            else if let error = error {
                completion(false, error, nil)
            }
        }
    }
}
