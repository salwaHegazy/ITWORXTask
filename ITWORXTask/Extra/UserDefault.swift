//
//  UserDefault.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/27/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//

import Foundation

class UserDefault : UserDefaults {
    
    static let shared = UserDefault()
    
    func SaveUserInfo (country : String , favouriteCategories : [String] , checkLogin : Bool) {
        UserDefaults.standard.set(country, forKey: Constants.country)
        UserDefaults.standard.set(favouriteCategories[0], forKey: Constants.category1)
        UserDefaults.standard.set(favouriteCategories[1], forKey: Constants.category2)
        UserDefaults.standard.set(favouriteCategories[2], forKey: Constants.category3)
        

      }
    func getStringValue(_ key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    func getIntValue(_ key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    func getBoolValue(_ key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    func getDoubleValue(_ key: String) -> Double {
        return UserDefaults.standard.double(forKey: key)
    }
    func isUserLoggedIn() -> Bool {
        return UserDefault.shared.getStringValue(Constants.country).isEmpty == false
    }
   
}
