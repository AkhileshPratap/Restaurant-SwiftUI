//
//  InputField.swift
//  Restaurant
//
//  Created by Akhilesh Pratap Singh on 17/06/21.
//

import SwiftUI

struct InputField: View {
    var placeholder: String
    @Binding var bindedText: String
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $bindedText)
                .padding()
            Divider().background(Color.gray)
                .padding(.top, -16)
                .padding(.horizontal, 16)
        }
    }
}
