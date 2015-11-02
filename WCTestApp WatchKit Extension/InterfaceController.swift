//
//  InterfaceController.swift
//  WCTestApp WatchKit Extension
//
//  Created by Ivan Grachev on 11/2/15.
//  Copyright © 2015 IvanGrachev. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    var replyCount = 0
    
    @IBOutlet var messageFromIphoneLabel: WKInterfaceLabel!
    @IBOutlet var replyCountLabel: WKInterfaceLabel!
    
    @IBAction func pingIphoneButtonTapped() {
        WatchWCManager.sharedManager.sendMessage("Ping")
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "iphoneMessageNotificationReceived:", name: "Message Received", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "replyNotificationReceived:", name: "Reply Received", object: nil)
    }

    func iphoneMessageNotificationReceived(notification: NSNotification) {
        guard let messageString = notification.object as? String else { return }
        dispatch_async(dispatch_get_main_queue()) {
            self.messageFromIphoneLabel.setText("Message from iPhone: \(messageString)")
        }
    }
    
    func replyNotificationReceived(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            self.replyCount++
            self.replyCountLabel.setText("Reply count: \(self.replyCount)")
        }
    }
    
    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}
