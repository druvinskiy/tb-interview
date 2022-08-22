//
//  Interactor.swift
//  TBInterview
//
//  Created by Zachary Rhodes on 5/25/21.
//

import Combine

class Interactor {
    
    let api: API
    var observer: AnyCancellable?
    
    init(api: API) {
        self.api = api
    }
    
    func getExpenses() { }
    
}
