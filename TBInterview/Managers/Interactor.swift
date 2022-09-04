//
//  Interactor.swift
//  TBInterview
//
//  Created by Zachary Rhodes on 5/25/21.
//

import Foundation
import Combine

class Interactor {
    
    let api: API
    var observer: AnyCancellable?
    
    init(api: API) {
        self.api = api
    }
    
    func getExpenses(completed: @escaping (Result<[Expense], TBError>) -> Void) {
        observer = api.expenseData
            .sink(receiveCompletion: { [weak self] error in
                guard let self = self else { return }
                
                self.observer?.cancel()
                completed(.failure(.unableToComplete))
            }, receiveValue: { [weak self] data in
                guard let self = self else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let expenses = try decoder.decode([Expense].self, from: data)
                    completed(.success(expenses))
                } catch {
                    self.observer?.cancel()
                    completed(.failure(.invalidData))
                }
            })
    }
    
    func fetchMonthlyBudget(completion: @escaping (Float) -> Void) {
        api.fetchMonthlyBudget(completion: completion)
    }
}
