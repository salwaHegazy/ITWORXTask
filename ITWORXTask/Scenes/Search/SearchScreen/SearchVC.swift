//
//  SearchVC.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/26/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift
import NVActivityIndicatorView

class SearchVC: UIViewController , SearchView ,EmptyDataSetSource, EmptyDataSetDelegate {
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var firstCategoryBtn: UIButton!
    @IBOutlet weak var secondCategoryBtn: UIButton!
    @IBOutlet weak var thirdCategoryBtn: UIButton!
    @IBOutlet weak var articlesCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    
    var categoryName : String?
    var articlesList = [Article]()
        {
          didSet {
              articlesCollectionView.reloadData()
          }
         }
       let presenter = SearchPresenter()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            articlesCollectionView.delegate = self
            articlesCollectionView.dataSource = self
            articlesCollectionView.emptyDataSetSource = self
            articlesCollectionView.emptyDataSetDelegate = self
            presenter.attachView(view: self, searchVC: self)
            self.countryLabel.text = presenter.country
            self.firstCategoryBtn.setTitle(presenter.category1, for: .normal)
            self.secondCategoryBtn.setTitle(presenter.category2, for: .normal)
            self.thirdCategoryBtn.setTitle(presenter.category3, for: .normal)
            presenter.ValidateData(country: presenter.country, category:presenter.category1, apiKey: NConstants.api_Key)
            presenter.goToEmpty(articles: articlesList)
            
        }
        override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
           self.navigationController?.navigationBar.isHidden = true
        }
        func navigateToEmpty() {
            self.showEmptyResultMessage(show: true,KeyConstants.defaultImage, KeyConstants.noArticles,articlesCollectionView)
        }
        func startLoading() {
             loadingIndicator.startAnimating()
        }
        func stopLoading() {
            loadingIndicator.stopAnimating()
        }
        
        @IBAction func searchBtnPressed(_ sender: Any) {
            articlesList.removeAll()
            presenter.ValidateData(country: presenter.country, category: searchTextField.text ?? presenter.category1 , apiKey: NConstants.api_Key)
            presenter.goToEmpty(articles: articlesList)
        }
    
        @IBAction func searchByCategoryBtnPressed(_ sender: UIButton) {
            articlesList.removeAll()
            presenter.ValidateData(country: presenter.country, category: sender.titleLabel!.text ?? presenter.category1 , apiKey: NConstants.api_Key)
            presenter.goToEmpty(articles: articlesList)
        }
       
       @IBAction func backBtnPressed(_ sender: Any) {
          openVC(storyBoard: "Headlines", identifier: "HeadlinesVC")
       }
}

    extension SearchVC : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return articlesList.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadlinesCollectionViewCell", for: indexPath) as! HeadlinesCollectionViewCell
            cell.config(articles: articlesList[indexPath.row])
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.openLink(urlLink: articlesList[indexPath.row].url ?? "")
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             let yourWidth = collectionView.bounds.width/1.0
             return CGSize(width: yourWidth, height: 260)
        }
        
    }
