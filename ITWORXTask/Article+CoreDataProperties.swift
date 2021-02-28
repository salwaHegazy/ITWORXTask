//
//  Article+CoreDataProperties.swift
//  
//
//  Created by Salwa Hegazy on 2/28/21.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var articleDescription: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var url: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var name: String?

}
