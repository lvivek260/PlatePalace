//
//  Rechibility.swift
//  MVVM_Loading_Internet_Demo
//
//  Created by PHN MAC 1 on 03/06/23.
//

import Foundation
import SystemConfiguration

public class Reachability {
    
    class func isConnected() -> Bool {
        
        var noAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        noAddress.sin_len = UInt8(MemoryLayout.size(ofValue: noAddress))
        noAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &noAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {noSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, noSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
}
