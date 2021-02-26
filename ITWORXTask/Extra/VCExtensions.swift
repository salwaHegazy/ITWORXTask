//
//  VCExtensions.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/26/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift
import MOLH


extension UIViewController {
  func openVC(storyBoard: String,identifier: String) {
        let vc = UIStoryboard(name: storyBoard, bundle: nil).instantiateViewController(withIdentifier: identifier)
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func TaskToast(_ message: String ) {
           var style = ToastStyle()
           style.messageAlignment = .center
           self.view.makeToast(message,style: style)
    }
    
    // Show Alert
    func showAlert(title: String, description: String, btnAction: String) {
        let alert = UIAlertController(title: title, message:description  , preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: btnAction, style: .default, handler: { (action) -> Void in})
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    // Show Toast
    func showToast(message: String) {
        self.TaskToast(message)
    }
    
    func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
     }

     @objc func dismissKeyboard() {
            view.endEditing(true)
     }
    
  
    // Hide Keyboard
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dissmisKeyboard() {
        view.endEditing(true)
    }
    
    func openLink(urlLink: String) {
         if let url = URL(string: urlLink)
            {
              if UIApplication.shared.canOpenURL(url)
                 {
                   UIApplication.shared.open(url, options: [:], completionHandler: {
                      (success) in
                       if (success)
                       {
                         print("OPENED \(url): \(success)")
                        }
                        else
                          {
                           print("FAILED to open \(url)")
                          }
                    })
                  }
                  else
                  {
                    print("CANNOT open \(url)")
                  }
              }
         }
    
    
}
