//
//  Localization.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/28/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//

import Foundation

class Localization {
    static func localizedString(forKey key: String) -> String {
        var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        
        if result == key {
            result = Bundle.main.localizedString(forKey: key, value: nil, table: "texts")
        }
        return result
    }
}
