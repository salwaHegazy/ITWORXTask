//
//  NConstants.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/26/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//

import Foundation

class NConstants {
    
    // Base URL
    static let NewsApiBASE:String = "http://newsapi.org/v2/top-headlines"
    
    // Endpoints
    static let headlines: String = "?country=us&category=business&apiKey=6967341f840d42839c7a35de78cd2aad"
    
    static let api_Key : String = "6967341f840d42839c7a35de78cd2aad"
  
 //   http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6967341f840d42839c7a35de78cd2aad
    
   // To concatenate Base URL and Endpoint
    static func endpoint(_ endpoint: String) -> URL {
        return "\(NewsApiBASE)\(endpoint)".url
    }
}
