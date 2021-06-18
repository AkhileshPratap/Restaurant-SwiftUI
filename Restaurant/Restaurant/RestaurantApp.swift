//
//  RestaurantApp.swift
//  Restaurant
//
//  Created by Akhilesh Pratap Singh on 16/06/21.
//

import SwiftUI

@main
struct RestaurantApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RestaurantView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
