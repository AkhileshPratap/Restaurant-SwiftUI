//
//  AddReviewViewModel.swift
//  Restaurant
//
//  Created by Akhilesh Pratap Singh on 17/06/21.
//

import Combine
import CoreData

private protocol AddReviewViewModelType {
    func validateName(_ restaurantName: String) -> Bool
    func addItem(type: String, for restaurant: Restaurant)
}

final class AddReviewViewModel: AddReviewViewModelType, ObservableObject {
   
    @Published var reviewText = ""
    @Published var rating = ""
    @Published var isValidForm = false
    @Published var savedDate: Date? = Date()
    
    var viewContext: NSManagedObjectContext?
    
    private var cancellables = Set<AnyCancellable>()
    
    private var isTextValidPublisher: AnyPublisher<Bool, Never> {
        $reviewText.debounce(for: 0.3, scheduler: RunLoop.main)
            .map{
                self.validateName($0)
            }
            .eraseToAnyPublisher()
    }
    
    private var isRatingValidPublisher: AnyPublisher<Bool, Never> {
        $rating.debounce(for: 0.3, scheduler: RunLoop.main)
            .map{ input in
                return input.count == 1
            }
            .eraseToAnyPublisher()
    }
    
    private var viewValidator: AnyPublisher< Bool, Never> {
        Publishers.CombineLatest(isTextValidPublisher, isRatingValidPublisher)
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

extension AddReviewViewModel {

    func validateName(_ name: String) -> Bool {
        if name.count > 3 && name.count < 50 {
            return true
        }
        return false
    }

    func addItem(type: String, for restaurant: Restaurant) {
        guard let context = viewContext else { return }

        let newItem = Review(context: context)
        newItem.restaurantId = restaurant.restaurantId
        newItem.reviewId = UUID()
        newItem.review = reviewText
        newItem.rating = Double(rating) ?? 0.0
        newItem.date = savedDate
        restaurant.addToReview(newItem)
        restaurant.rating = restaurant.getAverageRating()
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("error \(nsError), \(nsError.userInfo)")
        }
    }

}
