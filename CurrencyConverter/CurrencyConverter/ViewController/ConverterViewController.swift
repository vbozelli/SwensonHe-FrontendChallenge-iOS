//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Victor Bozelli Alvarez on 05/01/20.
//  Copyright © 2020 Victor Bozelli Alvarez. All rights reserved.
//

import UIKit

final class ConverterViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet fileprivate weak var currencyLabel: UILabel!
    @IBOutlet fileprivate weak var ammountTextField: UITextField!
    
    //MARK: Variables
    fileprivate var numberFormatter: NumberFormatter!
    var rate: Float!
    var currency: Currency!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyLabel.text = currency.rawValue
        ammountTextField.text = String(format: "%.2f", rate)
    }
    
    //MARK: Actions
    @IBAction func changedAmmountText(_ sender: UITextField) {
        if var text = sender.text {
            text = text.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ".", with: "")
            if var baseAmmount = Float(text) {
                baseAmmount /= 100
                let ammount = rate * baseAmmount
                ammountTextField.text = String(format: "%.2f", ammount)
            }
        }
    }
}
