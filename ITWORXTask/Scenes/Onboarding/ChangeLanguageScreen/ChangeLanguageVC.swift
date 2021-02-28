//
//  ChangeLanguageVC.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/28/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//

import UIKit
import MOLH

class ChangeLanguageVC: UIViewController , ChangeLanguageView {
    
    @IBOutlet weak var englishBtn: UIButton!
    @IBOutlet weak var arabicBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    var lang : String?
    var presenter = ChangeLanguagePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self , changeLang: self)
    }
    override func viewWillAppear(_ animated: Bool) {
      self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func englishbtn(_ sender: UIButton) {
        setEnglish()
        print("test")
    }
    @IBAction func arabicBtn(_ sender: UIButton) {
        setArabic()
    }
    func save() {
        Constants.langState = true
        presenter.saveLang(lang: self.lang)
    }
    func showMessage() {
        showMessageResetApp(lang: self.lang!)
    }
    func langEmpty() {
        self.TaskToast(Localization.localizedString(forKey: KeyConstants.changeLangBtn))
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
         save()
         openVC(storyBoard: "Headlines", identifier: "HeadlinesVC")
    }
   
}
extension ChangeLanguageVC {
  
    func setEnglish() {
        englishBtn.borderColor = UIColor(red: 20.0/255.0, green: 124.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        arabicBtn.borderColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        self.lang = KeyConstants.en
        save()
        print("test")
        UserDefaults.standard.set(self.lang, forKey: Constants.lang)
    }
    func setArabic() {
        arabicBtn.borderColor = UIColor(red: 20.0/255.0, green: 124.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        englishBtn.borderColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        self.lang = KeyConstants.ar
        UserDefaults.standard.set(self.lang, forKey: Constants.lang)
        save()
    }
    
    
    
}

