//
//  Utilities.swift
//  MoviesApp
//
//  Created by Ramiro Gutierrez on 17/07/24.
//

import Foundation
import Reachability

protocol ConnectivityChecker {
    func hasInternetConnection() -> Bool
}

class ReachabilityChecker: ConnectivityChecker {
    func hasInternetConnection() -> Bool {
        let reachability = try! Reachability()
        switch reachability.connection {
        case .unavailable:
            return false
        case .wifi, .cellular:
            return true
        }
    }
}
