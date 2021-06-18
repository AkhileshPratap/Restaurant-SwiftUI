//
//  RestaurantView.swift
//  Restaurant
//
//  Created by Akhilesh Pratap Singh on 16/06/21.
//

import SwiftUI
import CoreData

struct RestaurantView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Restaurant.entity(), sortDescriptors: [])
    var restaurants: FetchedResults<Restaurant>
    @State var showAddRestaurantView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(restaurants) { restaurant in
                    NavigationLink(destination: ReviewView(restaurant)) {
                        RestaurantCellView(restaurant)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .navigationTitle(Constants.Title.restaurant)
            .navigationBarItems(trailing: Button(action: {
                showAddRestaurantView = true
            }, label: {
                Text(Constants.addText)
            }))
            .sheet(isPresented: $showAddRestaurantView) {
                AddRestaurantView()
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { restaurants[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct RestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
