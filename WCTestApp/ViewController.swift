//
//  ViewController.swift
//  WCTestApp
//
//  Created by Ivan Grachev on 11/2/15.
//  Copyright © 2015 IvanGrachev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var watchPingCount = 0
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var watchPingCounterLabel: UILabel!
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
        IphoneWCManager.sharedManager.sendMessage(textField.text ?? "Empty")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "watchMessageNotificationReceived:", name: "Message Received", object: nil)
    }
    
    func watchMessageNotificationReceived(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            self.watchPingCount++
            self.watchPingCounterLabel.text = "Watch ping count: \(self.watchPingCount)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

