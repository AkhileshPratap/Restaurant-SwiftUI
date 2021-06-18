//
//  ReviewCellView.swift
//  Restaurant
//
//  Created by Akhilesh Pratap Singh on 17/06/21.
//

import SwiftUI

struct ReviewCellView: View {
    var review: Review
    
    init(_ review: Review) {
        self.review = review
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(review.date!, formatter: itemFormatter)").font(.headline)
            Text("\(review.review ?? "")").font(.subheadline)
            Text("Rating: \(review.rating) ").font(.subheadline)
        }.padding(8)
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}


struct ReviewCellView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCellView(Review())
    }
}
