//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by Victor Bozelli Alvarez on 05/01/20.
//  Copyright © 2020 Victor Bozelli Alvarez. All rights reserved.
//

import Alamofire
import MBProgressHUD
import UIKit

final class CurrencyViewController: UIViewController {
    //MARK: Constants
    fileprivate struct Constants {
        static let converterSegue = "ConverterSegue"
        static let euroHeaderView = "EuroHeaderView"
        static let currencies = [Currency.aud, Currency.usd, Currency.cad, Currency.gbp, Currency.brl, Currency.inr]
    }
    
    //MARK: Variables
    fileprivate var currencyRate: CurrencyRate!
    fileprivate var selectedCurrency: Currency!
    fileprivate var networkReachabilityManager: NetworkReachabilityManager!
    
    //MARK: Outlets
    @IBOutlet fileprivate weak var currenciesTableView: UITableView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        currenciesTableView.isHidden = true
        if let euroHeaderView = Bundle.main.loadNibNamed(Constants.euroHeaderView, owner: self, options: nil)?.first as? UIView {
            euroHeaderView.backgroundColor = .white
            navigationItem.titleView = euroHeaderView
        }
        if Requests.conectedToInternet() {
            getCurrencyRates()
        }
        else {
            networkReachabilityManager = NetworkReachabilityManager()
            networkReachabilityManager.listener = { status in
                if status != .notReachable && status != .unknown {
                    self.getCurrencyRates()
                    self.networkReachabilityManager.stopListening()
                }
            }
            networkReachabilityManager.startListening()
            UIAlertController.createAlert(title: Localizable.attention.localized, message: Localizable.notConnectedToInternet.localized, style: .alert, viewController: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? ConverterViewController {
            destinationViewController.currency = selectedCurrency
            let rate = currencyRate.getRate(currency: selectedCurrency)
            destinationViewController.rate = rate
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    //MARK: Methods
    fileprivate func getCurrencyRates() {
        let progressHud = MBProgressHUD.showAdded(to: view, animated: true)
        progressHud.label.text = Localizable.loading.localized
        progressHud.detailsLabel.text = Localizable.loadingCurrencyRates.localized
        CurrencyRatesRequest.getCurrencyRates { (success, error, curencyRate) in
            DispatchQueue.main.async {
                progressHud.hide(animated: true)
                if success, let curencyRate = curencyRate {
                    self.currencyRate = curencyRate
                    self.currenciesTableView.isHidden = false
                    self.currenciesTableView.reloadData()
                }
                else if let error = error {
                    UIAlertController.createAlert(title: Localizable.attention.localized, message: error, style: .alert, viewController: self)
                }
            }
        }
    }
}

//MARK: UITableViewDataSource
extension CurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currencyRate == nil {
            return .zero
        }
        return Constants.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currency = Constants.currencies[indexPath.row]
        let rate = currencyRate.getRate(currency: currency)
        if let cell: CurrencyTableViewCell = tableView.dequeue(index: indexPath) {
            cell.setupCell(currency: currency, rate: rate)
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: UITableViewDataSource
extension CurrencyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCurrency = Constants.currencies[indexPath.row]
        performSegue(withIdentifier: Constants.converterSegue, sender: nil)
    }
}
