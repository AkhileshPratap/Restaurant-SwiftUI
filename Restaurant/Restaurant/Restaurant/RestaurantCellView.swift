//
//  RestaurantCellView.swift
//  Restaurant
//
//  Created by Akhilesh Pratap Singh on 17/06/21.
//

import SwiftUI

struct RestaurantCellView: View {
    @ObservedObject var restaurant: Restaurant
    init(_ restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(restaurant.name ?? "")").font(.headline)
            Text("Type: \(restaurant.type ?? "") ").font(.subheadline)
            Spacer()
            Text("Rating: \(restaurant.rating) ").font(.subheadline)
        }.padding(8)
    }
}

struct RestaurantCellView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCellView(Restaurant())
    }
}

