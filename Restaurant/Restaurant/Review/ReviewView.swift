//
//  ReviewView.swift
//  Restaurant
//
//  Created by Akhilesh Pratap Singh on 16/06/21.
//

import SwiftUI
import CoreData

struct ReviewView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var fetchRequest: FetchRequest<Review>
    var reviews: FetchedResults<Review> {
        fetchRequest.wrappedValue
    }
    
    var restaurant: Restaurant
    init(_ restaurant: Restaurant) {
        let predicate = NSPredicate(format: "restaurantId == %@", restaurant.restaurantId! as CVarArg)
        fetchRequest = FetchRequest<Review>(entity: Review.entity(), sortDescriptors: [], predicate: predicate)
        self.restaurant = restaurant
    }

    @State var showAddRestaurantView = false
    var body: some View {
        List {
            ForEach(reviews) { review in
                ReviewCellView(review)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle(Constants.Title.review)
        .navigationBarItems(trailing: Button(action: {
            showAddRestaurantView = true
        }, label: {
            Text(Constants.addText)
        }))
        .sheet(isPresented: $showAddRestaurantView) {
            AddReviewView(restaurant)
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(Restaurant()).environment(\.managedObjectContext, PersistenceController.previewReview.container.viewContext)
    }
}
