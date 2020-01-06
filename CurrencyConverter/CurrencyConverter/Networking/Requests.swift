//
//  Requests.swift
//  CurrencyConverter
//
//  Created by Victor Bozelli Alvarez on 05/01/20.
//  Copyright © 2020 Victor Bozelli Alvarez. All rights reserved.
//

import Alamofire

final class Requests {
    //MARK: Constants
    fileprivate static let baseUrl = "http://data.fixer.io/api/latest?access_key=15f1bc0caaf7a90e428021e342d19d6a"
    
    //MARK: Methods
    static func conectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func requestData(path: String, completion: @escaping (Bool, String?, Data?) -> Void) {
        Alamofire.request(baseUrl + path).responseData { response in
            if let error = response.error?.localizedDescription {
                completion(false, error, nil)
            }
            else if let data = response.result.value {
                completion(true, nil, data)
            }
        }
    }
}
