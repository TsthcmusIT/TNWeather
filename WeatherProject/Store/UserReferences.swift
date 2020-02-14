//
//  UserReferences.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/13/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation

struct UserReferences {
    static let locationDBFlagKey = "LocationDBFlagKey"
    private static let userDefault = UserDefaults.standard
    
    static func saveLocationDBFlag(flag: Bool){
        userDefault.set(flag, forKey: locationDBFlagKey)
    }

    static func getLocationDBFlag() -> Bool {
        if (userDefault.object(forKey: locationDBFlagKey) != nil) {
            return userDefault.bool(forKey: "SwitchState")
        } else {
            return false
        }
    }
    
    static func clearLocationDBFlag(){
        userDefault.removeObject(forKey: locationDBFlagKey)
    }
}

