//
//  TipViewController.swift
//  TipCalculator
//
//  Created by Matt Cline on 4/2/15.
//  Copyright (c) 2015 Matt Cline. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        // initializes the tipLabela and totalLabel with $0.00
        super.viewDidLoad()
        
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        billField.placeholder = formatter.currencySymbol
        tipLabel.text = formatter.stringFromNumber(0.00)
        totalLabel.text = formatter.stringFromNumber(0.00)
    }
    
    override func viewWillAppear(animated: Bool) {
        getPreviousUserState()
    }
    
    override func viewWillDisappear(animated: Bool) {
        saveUserState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        updateValues()
    }
    
    func updateValues() {
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        var tipPercentages = [0.18, 0.20, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
    }
    
    func saveUserState() {
        // Stores bill amount, tipControl selected index and the current time in NSUserDefaults
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "last_bill_amount")
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "last_tip_index")
        defaults.setObject(NSDate(), forKey: "time_of_last_app_usage")
        defaults.synchronize()
    }
    
    func getPreviousUserState() {
        // Gets an index for tipControl and the previous bill amount if app is
        // re-launched within the timeout period. Skips if first app launch.
        var defaults = NSUserDefaults.standardUserDefaults()
        
        setTheme(defaults.integerForKey("theme_index"))
        
        if let lastAccessTime = defaults.objectForKey("time_of_last_app_usage") as? NSDate {
            let valueTimeout = 60
            let elapsedTime = Int(NSDate().timeIntervalSinceDate(lastAccessTime))
            if elapsedTime <= valueTimeout {
                billField.text = defaults.stringForKey("last_bill_amount")
                tipControl.selectedSegmentIndex = defaults.integerForKey("last_tip_index")
                updateValues()
            }
        } else {
            tipControl.selectedSegmentIndex = defaults.integerForKey("default_tip_index")
        }
    }
    
    func setTheme(themeIndex: Int) {
        var backgroundColor: UIColor
        var navColor: UIColor
        switch themeIndex {
        case 0:
            backgroundColor = UIColor.whiteColor()
        case 1:
            backgroundColor = UIColor.darkGrayColor()
        default:
            backgroundColor = UIColor.whiteColor()
        }
        
        
        self.view.backgroundColor = backgroundColor
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

