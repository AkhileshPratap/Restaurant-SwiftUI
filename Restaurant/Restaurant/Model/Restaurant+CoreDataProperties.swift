//
//  Restaurant+CoreDataProperties.swift
//  Restaurant
//
//  Created by AkhileshSingh on 18/06/21.
//
//

import Foundation
import CoreData


extension Restaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant")
    }

    @NSManaged public var name: String?
    @NSManaged public var rating: Double
    @NSManaged public var restaurantId: UUID?
    @NSManaged public var type: String?
    @NSManaged public var review: NSSet?

}

// MARK: Generated accessors for review
extension Restaurant {

    @objc(addReviewObject:)
    @NSManaged public func addToReview(_ value: Review)

    @objc(removeReviewObject:)
    @NSManaged public func removeFromReview(_ value: Review)

    @objc(addReview:)
    @NSManaged public func addToReview(_ values: NSSet)

    @objc(removeReview:)
    @NSManaged public func removeFromReview(_ values: NSSet)

}

extension Restaurant : Identifiable {

}
