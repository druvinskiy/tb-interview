//
//  TBError.swift
//  TBInterview
//
//  Created by David Ruvinskiy on 8/22/22.
//

import Foundation

enum TBError: String, Error {
    
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidData = "The data received from the server was invalid. Please try again."
}
