//
//  ITWORXTaskAPI.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/26/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//


import Foundation
import UIKit
import Alamofire
import MOLH

class ITWORXTaskAPI {
    class func ITWORXTaskRequest<ResponseType: Decodable>(_ endpoint: String,_ responseType: ResponseType.Type,_ params: Parameters = [:],isHeaders: Bool = true,_ method: HTTPMethod = .get, encoder : JSONEncoding = JSONEncoding.default ,_ language: String = "", completionHandler: @escaping (ResponseType?,String?) -> Void) {
           
        getAlamoRequest(url: NConstants.endpoint(endpoint), params ,isHeaders: isHeaders,method: method, encoder: JSONParameterEncoder.prettyPrinted, responseType: ResponseType.self,language: language) { (response, errorMessage, error) in
               if error != nil {
                   completionHandler(nil,error?.localizedDescription ?? "Error".localized)
                   return
               }
               if errorMessage.isEmpty == false {
                   completionHandler(nil,errorMessage)
               } else {
                   completionHandler(response,nil)
               }
           }
       }
    class func getAlamoRequest<ResponseType: Decodable>(url: URL,_ params: Parameters,isHeaders: Bool = true,method: HTTPMethod = .get, encoder : JSONParameterEncoder = JSONParameterEncoder.prettyPrinted , responseType: ResponseType.Type,language:String = "", completion: @escaping (ResponseType?,String, Error?) -> Void) {
          var headers: HTTPHeaders
          headers = [
            "Accept-Language": MOLHLanguage.currentAppleLanguage()]
           (language.isEmpty) ? (headers[
           "Accept-Language"] = MOLHLanguage.currentAppleLanguage()) : (headers[
           "Accept-Language"] = language)
//           (isHeaders) ? (headers[
//               "Cookie"] = "session_id=\(UserDefault.shared.getStringValue(Constants.session_id))") : nil
       let manager = Alamofire.Session()
        manager.request(url,method: method ,parameters: params).validate().responseJSON { response in
            print("url \(url)")
//            print(String(data:response.data!,encoding:.utf8)!)
               let decoder = JSONDecoder()
               switch response.result {
               case .success:
                   do {
                       let responseObject = try decoder.decode(ResponseType.self, from: response.data!)
                       DispatchQueue.main.async {
                           completion(responseObject,"",nil)
                       }
                   } catch {
                       print(error)
                   }
               case .failure(let error):
                DispatchQueue.main.async {
                   completion(nil,"",error)
                }
               }
               manager.session.invalidateAndCancel()
           }
       }
  
  }
 
