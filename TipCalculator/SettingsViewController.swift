//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Matt Cline on 4/2/15.
//  Copyright (c) 2015 Matt Cline. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    @IBOutlet var defaultTipSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var defaults = NSUserDefaults.standardUserDefaults()
        defaultTipSegmentedControl.selectedSegmentIndex = defaults.integerForKey("default_tip_index")
        themeSegmentedControl.selectedSegmentIndex = defaults.integerForKey("theme_index")
        setTheme(themeSegmentedControl.selectedSegmentIndex, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        updateValues()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onThemeChanged(sender: AnyObject) {
        setTheme(themeSegmentedControl.selectedSegmentIndex, animated: true)
    }
    
    func updateValues() {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipSegmentedControl.selectedSegmentIndex, forKey: "default_tip_index")
        defaults.setInteger(themeSegmentedControl.selectedSegmentIndex, forKey: "theme_index")
        defaults.synchronize()
    }
    
    func setTheme(themeIndex: Int, animated: Bool) {
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
        
        
        if animated {
            UIView.animateWithDuration(1, animations: {
                self.view.backgroundColor = backgroundColor
            })
        } else {
            self.view.backgroundColor = backgroundColor
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
