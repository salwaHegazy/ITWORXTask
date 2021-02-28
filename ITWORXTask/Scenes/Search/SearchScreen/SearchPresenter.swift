//
//  SearchPresenter.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/26/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//

import Foundation

class SearchPresenter {
   var view: SearchView?
   var searchVC: SearchVC?
   var country  = UserDefault.shared.getStringValue(Constants.country)
   var category1 = UserDefault.shared.getStringValue(Constants.category1)
   var category2 = UserDefault.shared.getStringValue(Constants.category2)
   var category3 = UserDefault.shared.getStringValue(Constants.category3)
   var qUrl = NConstants.NewsApiBASE
   var qParams = ""
   var sUrl = ""

     func attachView(view: SearchView? , searchVC: SearchVC?) {
         self.view = view
         self.searchVC = searchVC
    }
    func ValidateData (country : String , category : String ,apiKey : String ){
         if(!NetworkStatus.isConnectedToNetwork()) {
           self.searchVC?.showAlert(title: Localization.localizedString(forKey: KeyConstants.alert), description: Localization.localizedString(forKey: KeyConstants.nonetwork), btnAction: Localization.localizedString(forKey: KeyConstants.ok))
         } else if category.isEmpty{
            self.searchVC?.showAlert(title: Localization.localizedString(forKey: KeyConstants.alert), description: Localization.localizedString(forKey: KeyConstants.noCategory), btnAction: Localization.localizedString(forKey: KeyConstants.ok))
         }
         else {
            self.SendData(country: country, category: category, apiKey: apiKey)
         }
    }
 
    func SendData(country : String , category : String ,apiKey : String ){
            self.view?.startLoading()
            let parameters = ["apiKey" : apiKey , "category": category , "country" : country]
            print(parameters)
            for (key , value) in parameters {
              qParams += key + "=" + value + "&"
              print(qParams)
            }
          if !qParams.isEmpty {
              qParams = "?" + qParams
              if qParams.hasSuffix("&") {
                 qParams.removeLast()
              }
              sUrl = qUrl + qParams
            
          }
        
          ITWORXTaskAPI.getAlamoRequest(url: URL(string: sUrl)!, parameters, responseType: NewsModel.self) { (response, errorMessage, error) in
              self.view?.stopLoading()
              if response?.status == "ok" {
                 self.searchVC?.articlesList.append(contentsOf: response?.articles ?? [Article]())
                 self.qParams = ""
                 self.sUrl = ""
                 return
              } else {
                 self.searchVC?.showAlert(title: Localization.localizedString(forKey: KeyConstants.alert), description: response?.status ?? Localization.localizedString(forKey: KeyConstants.servererror), btnAction: Localization.localizedString(forKey: KeyConstants.ok))
              }
          }
    
       }
 
     func goToEmpty(articles : [Article]) {
         if articles.count == 0 {
             self.view?.navigateToEmpty()
         }
     }
 }



