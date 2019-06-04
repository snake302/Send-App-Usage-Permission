//
//  AppUsagePermission.swift
//  Send App Usage Permission
//
//  Created by Akim Kasabulatov on 6/4/19.
//  Copyright © 2019 Akim Kasabulatov. All rights reserved.
//

import Foundation
import UIKit

enum PermissionStatus{
    case allowed
    case denied
    case notAsked
    case undefined
}

class AppUsagePermission{
    
    private static let alertTitle = "Send App Usage"
    private static let customAppName = "YourAppName"
    private static let displayAppName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? customAppName
    private static let UserDefaultsKey = "AppUsagePermission.value"
    
    //Displaying dialogue window
    static func displayAlert(viewController: UIViewController, completionHandler: ((PermissionStatus) -> Void)? = nil){
       
        let message = "Help improve the \(displayAppName) app and our products and services by sending data to us about how you use the \(displayAppName) app.\n\n For details see the Privacy Policy, which applies to the use of the \(displayAppName) app."
        
        let ac = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title:"Don't Send", style: .default, handler: { _ in
            let data = PermissionStatus.denied
            setValue(status: data)
            completionHandler?(data)
        }))
        ac.addAction(UIAlertAction(title:"Automatically Send", style: .default, handler: { _ in
            let data = PermissionStatus.allowed
            setValue(status: data)
            completionHandler?(data)
        }))
        viewController.present(ac, animated: true){}
    }
    
    //Get status
    static func status() -> PermissionStatus{
        if let value = UserDefaults.standard.object(forKey: UserDefaultsKey){
            var status = PermissionStatus.undefined
            switch(value as! Int){
                case 1: status = PermissionStatus.allowed
                case 2: status = PermissionStatus.denied
                default: break;
            }
                return status
        }
        return PermissionStatus.notAsked
    }
    
    //Is data usage allowed
    static func isAllowed() -> Bool{
        if (status() == PermissionStatus.allowed){
            return true
        }
            return false
    }
    
    //Is data usage asked
    static func isAsked() -> Bool{
        if (status() != PermissionStatus.notAsked){
            return true
        }
        return false
    }
    
    static func resetValue(){
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey)
    }
    
    //Saving dailogue window value
    private static func setValue(status: PermissionStatus){
        var valueToRecord = 0
        switch(status){
        case PermissionStatus.allowed: valueToRecord = 1
        case PermissionStatus.denied: valueToRecord = 2
        case .notAsked: break;
        case .undefined: break;
        }
        UserDefaults.standard.set(valueToRecord, forKey: UserDefaultsKey)
    }    
}
