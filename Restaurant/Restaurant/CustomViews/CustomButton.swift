//
//  CustomButton.swift
//  Restaurant
//
//  Created by Akhilesh Pratap Singh on 16/06/21.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var action: (() -> Void)
    var enable: Bool = false
    var body: some View {
        Button( action: action, label: {
            Spacer()
            Text(title)
                .padding()
                .foregroundColor(.white)
            Spacer()
        })
        .font(.system(size: 16, weight: .semibold))
        .background(changeColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
        .disabled(!enable)
    }
    
    var changeColor: Color {
        enable ? .blue : .gray
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
       CustomButton(title: "Add", action: action)
    }
    
    static func action() {
        
    }
}
