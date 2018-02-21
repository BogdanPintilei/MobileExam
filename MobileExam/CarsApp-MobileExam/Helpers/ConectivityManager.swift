//
//  ConectivityManager.swift
//  LostProperty
//
//  Created by Bogdan Pintilei on 11/26/17.
//  Copyright © 2017 Wolfpack Digital. All rights reserved.
//

import Reachability

class ConnectivityManager {
    
    static let sharedInstance = ConnectivityManager()
    
    private let reachability = Reachability()!
    
    private init() { }
    
    class func shared() -> ConnectivityManager {
        return sharedInstance
    }
    
    func isConnectedToInternet() -> Bool {
        return reachability.connection != .none
    }
    
//    func listenForReachability() {
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(self.reachabilityChanged(_:)),
//            name: Notification.Name.reachabilityChanged,
//            object: reachability)
//        do {
//            try reachability.startNotifier()
//        } catch {
//            print("could not start reachability notifier")
//        }
//    }
    
    func listenForReachability() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reachabilityChanged(_:)),
            name: Notification.Name.reachabilityChanged,
            object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
        }
    }
    @objc private func reachabilityChanged(_ notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.connection {
        case .none:
            NotificationCenter.default.post(Notification(name: Notification.Name("NoInternetConnection")))
        default:
            () //NOOP
        }
    }
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ConnectivityManager.handleNoInternetConnectivity),
            name: NSNotification.Name(rawValue: "NoInternetConnection"),
            object: nil
        )
    }
    
    @objc private func handleNoInternetConnectivity() {
        if !ConnectivityManager.shared().isConnectedToInternet() {
            print("not connected to the internet")
        }
    }
    
}
