//
//  Review+CoreDataProperties.swift
//  Restaurant
//
//  Created by AkhileshSingh on 18/06/21.
//
//

import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var date: Date?
    @NSManaged public var rating: Double
    @NSManaged public var restaurantId: UUID?
    @NSManaged public var review: String?
    @NSManaged public var reviewId: UUID?

}

extension Review : Identifiable {

}
