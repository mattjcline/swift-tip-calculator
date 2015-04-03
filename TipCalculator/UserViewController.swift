//
//  UserViewController.swift
//  TipCalculator
//
//  Created by Matt Cline on 4/2/15.
//  Copyright (c) 2015 Matt Cline. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet var defaultTipSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var defaults = NSUserDefaults.standardUserDefaults()
        defaultTipSegmentedControl.selectedSegmentIndex = defaults.integerForKey("default_tip_index")
    }
    
    override func viewWillDisappear(animated: Bool) {
        updateDefaultTip()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateDefaultTip() {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipSegmentedControl.selectedSegmentIndex, forKey: "default_tip_index")
        defaults.synchronize()
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
