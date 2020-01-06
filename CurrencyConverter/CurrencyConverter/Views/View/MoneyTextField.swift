//
//  MoneyTextField.swift
//  MoneyTextFIeld
//
//  Created by Adam Hartford on 5/22/15.
//  Copyright (c) 2015 Adam Hartford. All rights reserved.
//

import UIKit

final class MoneyTextField: UITextField {
    
    let nonDecimal = NSCharacterSet(charactersIn: "0123456789").inverted
    let numberFormatter = NumberFormatter()
    
    public var negative = false {
        didSet {
            text = format(s: numberFormatter.string(from: numberValue)!).replacingOccurrences(of: "¤", with: "")
        }
    }
    
    public var locale = NSLocale.current {
        didSet {
            numberFormatter.locale = locale
            text = format(s: numberFormatter.string(from: numberValue)!).replacingOccurrences(of: "¤", with: "")
        }
    }
    
    var prevRange: UITextRange?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        text = format(s: numberFormatter.string(from: NSNumber(value: 1))!).replacingOccurrences(of: "¤", with: "")
    }
    
    @objc func editingChanged() {
        text = format(s: numberFormatter.string(from: numberValue)!).replacingOccurrences(of: "¤", with: "")
        if let range = prevRange {
            selectedTextRange = range
            prevRange = nil
        }
    }
    
    public override func deleteBackward() {
        prevRange = selectedTextRange
        
        
        
        let loc = offset(from: beginningOfDocument, to: selectedTextRange!.start)
        
        
        let selection = text(in: selectedTextRange!)
        if selection == "" {
            let prev = (text! as NSString).character(at: loc - 1)
            if prev >= 48 && prev <= 57 { // ASCII characters 0...9
                super.deleteBackward()
                return
            }
        } else {
            super.deleteBackward()
            return
        }
        
        let temp = abs(numberValue.doubleValue / 10)
        let s: NSString = "\(temp)" as NSString
        let val = (s.substring(to: s.length - 1) as NSString).doubleValue
        
        text = format(s: numberFormatter.string(from: NSNumber(value: val))!, val: val).replacingOccurrences(of: "¤", with: "")
        sendActions(for: UIControl.Event.editingChanged)
    }
    
    func format(s: String, val: Double? = nil) -> String {
        var v = val
        if v == nil {
            v = numberValue.doubleValue
        }
        
        if v == 0 {
            return s
        } else if !negative {
            return s
        } else {
            
            return "(" + s.replacingOccurrences(of: "-", with: "") + ")"
        }
    }
    
    public var numberValue: NSNumber {
        let s = text! as NSString
        let arr = s.components(separatedBy: nonDecimal) as NSArray
        let n = arr.componentsJoined(by: "") as NSString
        
        var d = n.doubleValue / base * (negative ? -1 : 1)
        if d == -0 {
            d = 0
        }
        return NSNumber(value: d)
    }
    
    var base: Double {
        let test = numberFormatter.string(from: NSNumber(value: 0))! as NSString
        return test.contains(".") || test.contains(",") ? 100 : 1
    }
    
}
