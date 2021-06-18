//
//  AddReviewTest.swift
//  RestaurantTests
//
//  Created by Akhilesh Pratap Singh on 17/06/21.
//

import XCTest
@testable import Restaurant

class AddReviewTest: XCTestCase {

    var addReviewViewModel: AddReviewViewModel = AddReviewViewModel()
    let store = PersistenceController.shared.container
    
    func test_add_restaurant() throws {
        addReviewViewModel.viewContext = store.viewContext
        let newItem = Review(context: store.viewContext)
        newItem.restaurantId = UUID()
        newItem.reviewId = UUID()
        newItem.review = "review Text"
        newItem.rating = 5.0
        newItem.date = Date()
        
        do {
            try store.viewContext.save()
        } catch {
            let nsError = error as NSError
            XCTFail("\(nsError.userInfo)")
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
