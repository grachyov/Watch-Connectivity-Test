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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "watchMessageNotificationReceived:", name: "Message Received", object: nil)
    }

    func watchMessageNotificationReceived(notification: NSNotification) {
        guard let messageString = notification.object as? String else { return }
        dispatch_async(dispatch_get_main_queue()) {
            self.messageFromIphoneLabel.setText("Message from iPhone: \(messageString)")
        }
    }
    
    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}
