//
//  ChangeLanguagePresenter.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/28/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//

import Foundation
import MOLH

class ChangeLanguagePresenter {

    var view: ChangeLanguageView?
    var changeLang: ChangeLanguageVC?
   
    func attachView(view: ChangeLanguageView? , changeLang: ChangeLanguageVC?) {
    self.view = view
    }
    func  ValidateData (){
         if(!NetworkStatus.isConnectedToNetwork()) {
            self.changeLang?.showAlert(title: Localization.localizedString(forKey: KeyConstants.alert), description: Localization.localizedString(forKey: KeyConstants.nonetwork), btnAction: Localization.localizedString(forKey: KeyConstants.ok))
        } else {
          
        }
    }
    func saveLang(lang: String?) {
        if lang != nil
        {
            view?.showMessage()
        }
        else {
            view?.langEmpty()
        }
    }
}
