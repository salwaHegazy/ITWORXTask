//
//  HeadlinesCollectionViewCell.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/26/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//

import UIKit
import SDWebImage


class HeadlinesCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var imgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func config(articles : Article){
           self.titleLabel.text = articles.title
           self.nameLabel.text = articles.source.name
           let url = URL(string: articles.urlToImage ?? "noproducts")
           self.imgImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "noproducts"))
           
    }
    
    
    
    
}
