//
//  Extensions.swift
//  CurrencyConverter
//
//  Created by Victor Bozelli Alvarez on 05/01/20.
//  Copyright © 2020 Victor Bozelli Alvarez. All rights reserved.
//

import UIKit

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
}

extension UIAlertController {
    static func createAlert(title: String, message: String, style: UIAlertController.Style, actions: [UIAlertAction]? = nil, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        }
        else {
            let ok = UIAlertAction(title: Localizable.ok.localized, style: .default)
            alert.addAction(ok)
        }
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}

extension UITableView {
    func dequeue<T: UITableViewCell>(index: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.className, for: index) as? T
    }
}
