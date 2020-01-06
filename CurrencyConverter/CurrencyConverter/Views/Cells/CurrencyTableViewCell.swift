//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Victor Bozelli Alvarez on 05/01/20.
//  Copyright © 2020 Victor Bozelli Alvarez. All rights reserved.
//

import UIKit

final class CurrencyTableViewCell: UITableViewCell {
    //MARK: Outlets
    @IBOutlet fileprivate weak var flagImageView: UIImageView!
    @IBOutlet fileprivate weak var currencyLabel: UILabel!
    @IBOutlet fileprivate weak var rateLabel: UILabel!
    
    //MARK: Methods
    func setupCell(currency: Currency, rate: Float) {
        currencyLabel.text = currency.rawValue
        rateLabel.text = String(format: "%.2f", rate)
        if currency == .aud {
            flagImageView.image = #imageLiteral(resourceName: "flag_australia")
        }
        else if currency == .usd {
            flagImageView.image = #imageLiteral(resourceName: "flag_usa")
        }
        else if currency == .cad {
            flagImageView.image = #imageLiteral(resourceName: "flag_canada")
        }
        else if currency == .gbp {
            flagImageView.image = #imageLiteral(resourceName: "flag_united_kingdom")
        }
        else if currency == .brl {
            flagImageView.image = #imageLiteral(resourceName: "flag_brazil")
        }
        else if currency == .inr {
            flagImageView.image = #imageLiteral(resourceName: "flag_india")
        }
    }
}
