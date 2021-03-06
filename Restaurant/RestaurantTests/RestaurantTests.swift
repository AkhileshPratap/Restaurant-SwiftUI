//
//  RestaurantTests.swift
//  RestaurantTests
//
//  Created by Akhilesh Pratap Singh on 16/06/21.
//

import XCTest
@testable import Restaurant

class RestaurantTests: XCTestCase {

    var addRestaurantViewModel: AddRestaurantViewModel = AddRestaurantViewModel()
    let store = PersistenceController.shared.container
    
    func test_add_restaurant() throws {
        addRestaurantViewModel.viewContext = store.viewContext
        let newItem = Restaurant(context: store.viewContext)
        newItem.restaurantId = UUID()
        newItem.name = "restaurant Name"
        newItem.type = "restaurant Type"
        newItem.rating = 0.0
        
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
