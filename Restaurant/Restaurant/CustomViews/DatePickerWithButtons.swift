//
//  DatePickerWithButtons.swift
//  Restaurant
//
//  Created by Akhilesh Pratap Singh on 17/06/21.
//

import SwiftUI

struct DatePickerWithButtons: View {
    
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
    
    var body: some View {
        ZStack {
            VStack {
                DatePicker(Constants.dateText, selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                Divider()
                HStack {
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text(Constants.cancelText)
                    })
                    Spacer()
                    Button(action: {
                        savedDate = selectedDate
                        showDatePicker = false
                    }, label: {
                        Text(Constants.saveText)
                            .bold()
                    })
                }
                .padding(.horizontal)
            }
            .padding()
            .background(
                Color.white
                    .cornerRadius(30)
            )
        }
    }
}

struct DatePickerWithButtons_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerWithButtons(showDatePicker: .constant(true), savedDate: .constant(Date()))
    }
}
