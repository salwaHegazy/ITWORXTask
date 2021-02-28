//
//  OnboardingVC.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/26/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//

import UIKit
import iOSDropDown

class OnboardingVC: UIViewController {
    @IBOutlet weak var countryDropDown: DropDown!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var fifthBtn: UIButton!
    @IBOutlet weak var sixBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var countries = ["Egypt" , "US" , "Saudi Arabia" , "Malaysia" , "Maldives" , "Qatar" , "Syria"]
    var favouriteCategories = [String]()
    var selectedCountry : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       countryDropDown.selectedRowColor   = #colorLiteral(red: 0.07843137255, green: 0.4862745098, blue: 0.7568627451, alpha: 1)
       countryDropDown.optionArray = countries
       countryDropDown.didSelect { (selectedText , index ,id) in
         self.selectedCountry = selectedText
       }
    }
    
    @IBAction func checkBtnPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            selectCheckedBtn(Button: firstBtn, category: "Business")
            print(favouriteCategories)
        case 1:
            selectCheckedBtn(Button: secondBtn, category: "Engineering")
            print(favouriteCategories)
        case 2:
            selectCheckedBtn(Button: thirdBtn, category: "Fashion")
            print(favouriteCategories)
        case 3:
            selectCheckedBtn(Button: fourthBtn, category: "E-commerce")
            print(favouriteCategories)
        case 4:
            selectCheckedBtn(Button: fifthBtn, category: "Dessign")
            print(favouriteCategories)
        case 5:
            selectCheckedBtn(Button: sixBtn, category: "Medical")
            print(favouriteCategories)
        default:
            print("please select")
        }
    }
   
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        if selectedCountry != nil && favouriteCategories.count == 3 {
           UserDefault.shared.SaveUserInfo(country: selectedCountry ?? "Egypt", favouriteCategories: favouriteCategories, checkLogin: true)
           openVC(storyBoard: "Onboarding", identifier: "ChangeLanguageVC")
          
        } else {
           showToast(message: "Please Select Country and 3 Favourite Categories")
        }
    }
   
    func selectCheckedBtn (Button : UIButton , category : String ) {
        if favouriteCategories.count <= 2 {
          Button.setImage(UIImage(named: "checkedfilled"), for: .normal)
          addFavouriteCategories (category: category)
        } else {
          unSelectCheckedBtn(Button: Button, category: category)
        }
    }
    
    func unSelectCheckedBtn(Button : UIButton  , category : String ){
         Button.setImage(UIImage(named: "checkedempty"), for: .normal)
            for (index,value) in favouriteCategories.enumerated(){
                if value == category{
                self.favouriteCategories.remove(at: index)
                print( "Filtered Array" , favouriteCategories)
                }
            }
    }
    
    func addFavouriteCategories (category : String) {
        if favouriteCategories.count <= 2 {
            if favouriteCategories.contains(category) != true {
               favouriteCategories.append(category)
            }
      } else {
        print("Select only 3 categories")
      }
    }

}
