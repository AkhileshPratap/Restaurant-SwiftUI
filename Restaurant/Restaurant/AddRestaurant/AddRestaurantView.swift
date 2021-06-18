//
//  AddRestaurantView.swift
//  Restaurant
//
//  Created by Akhilesh Pratap Singh on 16/06/21.
//

import SwiftUI

struct AddRestaurantView: View {
    // MARK: Properties
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
    
    @ObservedObject private var viewModel = AddRestaurantViewModel()
    
    @State private var selection = 0
    @State private var textfieldValue = ""
    @State private var isPickerShowing = false
    
    // MARK: Views
    var body: some View {
        NavigationView {
            VStack {
                restaurantName
                accTypePickerField
                doneBtn
                Spacer()
            }
            .navigationTitle(Constants.Title.addRestaurant)
            .navigationBarItems(leading: Button(action: {
                dismissView()
            }, label: {
                Text(Constants.cancelText)
            }))
        }.onAppear {
            self.viewModel.viewContext = self.viewContext
        }
    }
    
    private func dismissView() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private var restaurantName: some View {
        InputField(placeholder: Constants.Placeholder.restaurantName,
                   bindedText: $viewModel.restaurantName)
    }
    
    private var accTypePickerField: some View {
        VStack {
            HStack {
            TextField(Constants.Placeholder.restaurantType,
                      text: $viewModel.restaurantType,
                      onEditingChanged: { edit in
                        isPickerShowing = edit
                      })
                .disabled(true)
                .foregroundColor(.blue)
                .padding()
                Spacer()
                Button(action: {
                    isPickerShowing.toggle()
                }, label: {
                    Image(systemName: "arrow.down")
                })
                .padding()
            }
            Divider().background(Color.gray)
                .padding(.top, -16)
                .padding(.horizontal, 16)
            if isPickerShowing {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.restaurantType = Constants.pickerValues[self.selection]
                            isPickerShowing = false
                        }, label: {
                            Text(Constants.doneText)
                        }).padding()
                    }
                    CustomPickerView(values: Constants.pickerValues,
                                     selection: $selection)
                }
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
        viewModel.addItem()
    }
}

struct AddRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        AddRestaurantView()
    }
}
