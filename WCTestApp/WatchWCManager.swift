//
//  WatchWCManager.swift
//  WCTestApp
//
//  Created by Ivan Grachev on 11/2/15.
//  Copyright © 2015 IvanGrachev. All rights reserved.
//

import Foundation
import WatchConnectivity

class WatchWCManager: NSObject, WCSessionDelegate {
    static let sharedManager = WatchWCManager()
    
    func setupSession() {
        if WCSession.isSupported() {
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    func sendMessage(message: String) {
        if WCSession.isSupported() {
            let session = WCSession.defaultSession()
            if session.reachable {
                let message = ["Body" : message]
                session.sendMessage(message,
                    replyHandler: { (reply: [String : AnyObject]) -> Void in },
                    errorHandler: nil
                )
            }
            else {
                print("Not reachable from Watch")
            }
        }
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        guard let messageString = message["Body"] as? String else { return }
        let notification = NSNotification(name: "Message Received", object: messageString)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
}
