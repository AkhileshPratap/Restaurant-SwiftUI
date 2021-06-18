//
//  CustomPickerView.swift
//  Restaurant
//
//  Created by Akhilesh Pratap Singh on 16/06/21.
//

import SwiftUI

private enum PickerConstant {
    static let selectRestaurantType = Constants.Placeholder.selectRestaurantType
}

struct CustomPickerView: View {
    @State var values: [String]
    @Binding var selection: Int
    
    var body: some View {
        GeometryReader { geometry in
            Picker(selection: $selection, label:
                    Text(PickerConstant.selectRestaurantType)
                   , content: {
                    ForEach(0 ..< values.count) { index in
                        Text(self.values[index])
                            .tag(index)
                    }
                   })
                .pickerStyle(DefaultPickerStyle())
                .background(Color.clear)
                .frame(width: geometry.size.width, height: 180, alignment: .center)
        }
    }
}

struct CustomPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomPickerView(values: ["1", "2"], selection: .constant(0))
    }
}
