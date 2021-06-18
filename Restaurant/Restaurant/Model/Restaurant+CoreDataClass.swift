//
//  Restaurant+CoreDataClass.swift
//  Restaurant
//
//  Created by AkhileshSingh on 18/06/21.
//
//

import Foundation
import CoreData

@objc(Restaurant)
public class Restaurant: NSManagedObject {

    func getAverageRating()-> Double {
        guard let reviewsObj = self.review,
              let reviews = Array(reviewsObj) as? [Review] else {
            return 0.0
        }
        if reviews.count > 0 {
           return reviews.reduce(0.0) { $0 + $1.rating } / Double(reviews.count)
        }
        return 0.0
    }

}
