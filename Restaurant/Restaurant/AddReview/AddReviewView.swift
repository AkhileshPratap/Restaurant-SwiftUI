//
//  AddReviewView.swift
//  Restaurant
//
//  Created by Akhilesh Pratap Singh on 16/06/21.
//

import SwiftUI

struct AddReviewView: View {
    // MARK: Stored Properties
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
    
    @ObservedObject private var viewModel = AddReviewViewModel()
    
    @State private var selection = 0
    @State private var dateSelection = Date()
    @State private var textfieldValue = ""
    @State private var isPickerShowing = false
    var values = ["Checking", "Saving", "Money Market", "CD's", "IRAs", "Brokerage"]
    
    @State var showDatePicker: Bool = false
    
    var restaurant: Restaurant
    init(_ restaurant: Restaurant) {
        self.restaurant = restaurant
    }

    
    // MARK: Views
    var body: some View {
        NavigationView {
            VStack {
                reviewText
                ratingText
                datePicker
                doneBtn
                
                Spacer()
            }
            .navigationTitle(Constants.Title.addRestaurant)
            .navigationBarItems(leading: Button(action: {
                dismissView()
            }, label: {
                Text("Cancel")
            }))
        }.onAppear {
          self.viewModel.viewContext = self.viewContext
      }
    }
    
    private func dismissView() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private var reviewText: some View {
        InputField(placeholder: Constants.Placeholder.review,
                   bindedText: $viewModel.reviewText)
    }
    
    private var ratingText: some View {
        InputField(placeholder: Constants.Placeholder.rating,
                   bindedText: $viewModel.rating)
            .keyboardType(.numberPad)
    }
    
    private var datePicker: some View {
        ZStack {
            HStack {
                Text(Constants.Placeholder.selectedDate)
                Spacer()
                Button(action: {
                    showDatePicker.toggle()
                }, label: {
                    Text(viewModel.savedDate?.description ?? "SELECT DATE")
                })
            }.padding()
            

            if showDatePicker {
                DatePickerWithButtons(showDatePicker: $showDatePicker, savedDate: $viewModel.savedDate, selectedDate: viewModel.savedDate ?? Date())
                    .animation(.linear)
                    .transition(.opacity)
            }
        }
    }

    private var doneBtn: some View {
        CustomButton(title: Constants.addText,
                     action: addRestaurant,
                     enable: viewModel.isValidForm)
    }
    
    func addRestaurant() {
        dismissView()
        viewModel.addItem(type: textfieldValue, for: restaurant)
    }
}

struct AddReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewView(Restaurant())
    }
}
