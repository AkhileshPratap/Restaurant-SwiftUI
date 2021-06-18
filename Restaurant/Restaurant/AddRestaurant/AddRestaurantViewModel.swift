//
//  AddRestaurantViewModel.swift
//  Restaurant
//
//  Created by Akhilesh Pratap Singh on 16/06/21.
//

import Foundation
import Combine
import CoreData

private protocol AddRestaurantViewModelType {
    func validateName(_ restaurantName: String) -> Bool
    func addItem()
}

final class AddRestaurantViewModel: AddRestaurantViewModelType, ObservableObject {
   
    // MARK: Stored Properties
    @Published var restaurantName = ""
    @Published var restaurantType = ""
    @Published var isValidForm = false
    
    var viewContext: NSManagedObjectContext?
    
    private var cancellables = Set<AnyCancellable>()
    
    private var isNameValidPublisher: AnyPublisher<Bool, Never> {
        $restaurantName.debounce(for: 0.3, scheduler: RunLoop.main)
            .map{
                self.validateName($0)
            }
            .eraseToAnyPublisher()
    }
    
    private var isTypeValidPublisher: AnyPublisher<Bool, Never> {
        $restaurantType.debounce(for: 0.3, scheduler: RunLoop.main)
            .map{ input in
                return input.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    private var viewValidator: AnyPublisher< Bool, Never> {
        Publishers.CombineLatest(isNameValidPublisher, isTypeValidPublisher)
            .map { $0 && $1 == true }
            .eraseToAnyPublisher()
    }
    
    // MARK: Initialization
    init() {
        viewValidator.receive(on: RunLoop.main)
            .assign(to: \.isValidForm, on: self)
            .store(in: &cancellables)
    }
    
}

extension AddRestaurantViewModel {

    func validateName(_ name: String) -> Bool {
        if name.count > 3 && name.count < 50 {
            return true
        }
        return false
    }

    func addItem() {
        guard let context = viewContext else { return }

        let newItem = Restaurant(context: context)
        newItem.restaurantId = UUID()
        newItem.name = restaurantName
        newItem.type = restaurantType
        newItem.rating = 0.0
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
