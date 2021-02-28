//
//  HeadlinesPresenter.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/26/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//

import Foundation
import CoreData

class HeadlinesPresenter {
   var view: HeadlinesView?
   var headlinesVC: HeadlinesVC?
   var country  = UserDefault.shared.getStringValue(Constants.country)
   var category1 = UserDefault.shared.getStringValue(Constants.category1)
   var category2 = UserDefault.shared.getStringValue(Constants.category2)
   var category3 = UserDefault.shared.getStringValue(Constants.category3)
   var qUrl = NConstants.NewsApiBASE
   var qParams = ""
   var sUrl = ""
   let persistence = PersistenceService.shared

     func attachView(view: HeadlinesView? , headlinesVC: HeadlinesVC?) {
         self.view = view
         self.headlinesVC = headlinesVC
    }
    func ValidateData (country : String , category : String ,apiKey : String ){
         if(!NetworkStatus.isConnectedToNetwork()) {
            /*
             // fetch data from  CoreData when offline
            persistence.fetch(Article.self) { [weak self](articles) in
              //  self?.headlinesVC?.headlinesList .append(articles)
                print(articles)
            }
           */
           self.headlinesVC?.showAlert(title: Localization.localizedString(forKey: KeyConstants.alert), description: Localization.localizedString(forKey: KeyConstants.nonetwork), btnAction: Localization.localizedString(forKey: KeyConstants.ok))
            
            
         } else {
           
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
            print(sUrl)
        }
        

        ITWORXTaskAPI.getAlamoRequest(url: URL(string: sUrl)!, parameters, responseType: NewsModel.self) { (response, errorMessage, error) in
            self.view?.stopLoading()
            if response?.status == "ok" {
               self.headlinesVC?.headlinesList.append(contentsOf: response?.articles ?? [ArticleData]())
               self.qParams = ""
               self.sUrl = ""
                // save data to CoreData
                let article = Article(context: self.persistence.context)
                for art in response?.articles ?? [ArticleData]() {
                    article.name = art.source.name
                    article.title = art.title
                    article.url   = art.url
                    article.articleDescription = art.articleDescription
                    article.urlToImage = art.urlToImage
                    article.publishedAt = art.publishedAt
                    print("Articles From Core Data" , article)
                }
                self.persistence.save()
               return
            } else {
               self.headlinesVC?.showAlert(title: Localization.localizedString(forKey: KeyConstants.alert), description: response?.status ?? Localization.localizedString(forKey: KeyConstants.servererror), btnAction: Localization.localizedString(forKey: KeyConstants.ok))
            }
        }
  
     }
    
     func goToEmpty(articles : [ArticleData]) {
         if articles.count == 0 {
             self.view?.navigateToEmpty()
         }
     }
 }



