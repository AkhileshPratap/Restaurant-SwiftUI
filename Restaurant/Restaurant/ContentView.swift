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
                    VStack(alignment: .leading) {
                        Text("Name: \(restaurant.name ?? "Empty")").font(.headline)
                        Text("Type: \(restaurant.type ?? "No Type") ").font(.subheadline)
                    }.padding(8)
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Restaurants")
            .navigationBarItems(trailing: Button(action: {
                showAddRestaurantView = true
            }, label: {
                Text("Add")
//                Image(systemName: "plus.circle").imageScale(.large)
            }))
            .sheet(isPresented: $showAddRestaurantView) {
                AddRestaurantView()
            }
            
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Restaurant(context: viewContext)
            newItem.name = ""

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { restaurants[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
