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
    var replyCount = 0
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var watchPingCounterLabel: UILabel!
    @IBOutlet weak var replyCounterLabel: UILabel!
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
        IphoneWCManager.sharedManager.sendMessage(textField.text ?? "Empty")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "watchMessageNotificationReceived:", name: "Message Received", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "replyNotificationReceived:", name: "Reply Received", object: nil)
    }
    
    func watchMessageNotificationReceived(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            self.watchPingCount++
            self.watchPingCounterLabel.text = "Watch ping count: \(self.watchPingCount)"
        }
    }
    
    func replyNotificationReceived(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            self.replyCount++
            self.replyCounterLabel.text = "Reply count: \(self.replyCount)"
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

