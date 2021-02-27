//
//  HeadlinesVC.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/26/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift
import NVActivityIndicatorView

class HeadlinesVC : UIViewController , HeadlinesView ,EmptyDataSetSource, EmptyDataSetDelegate {
   // MARK: - Outlets
   @IBOutlet weak var countryBtn: UIBarButtonItem!
   @IBOutlet weak var firstCatLabel: UILabel!
   @IBOutlet weak var secondCatLabel: UILabel!
   @IBOutlet weak var thirdCatLabel: UILabel!
   @IBOutlet weak var headlinesCollectionView: UICollectionView!
   @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
   
   var categoryName : String?
   var headlinesList = [Article]()
       {
         didSet {
            headlinesCollectionView.reloadData()
         }
       }
   let presenter = HeadlinesPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headlinesCollectionView.delegate = self
        headlinesCollectionView.dataSource = self
        headlinesCollectionView.emptyDataSetSource = self
        headlinesCollectionView.emptyDataSetDelegate = self
        presenter.attachView(view: self, headlinesVC: self)
        presenter.ValidateData(country: "us", category: "business", apiKey: "6967341f840d42839c7a35de78cd2aad")
        presenter.goToEmpty(articles: headlinesList)
        
    }
    func navigateToEmpty() {
     //   self.showEmptyResultMessage(show: true,KeyConstants.empty, "", headlinesCollectionView)
    }
    func startLoading() {
         loadingIndicator.startAnimating()
    }
    func stopLoading() {
        loadingIndicator.stopAnimating()
    }
    

}

extension HeadlinesVC : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headlinesList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadlinesCollectionViewCell", for: indexPath) as! HeadlinesCollectionViewCell
        cell.config(articles: headlinesList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openLink(urlLink: headlinesList[indexPath.row].url ?? "")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let yourWidth = collectionView.bounds.width/1.0
         return CGSize(width: yourWidth, height: 260)
    }
    
}
