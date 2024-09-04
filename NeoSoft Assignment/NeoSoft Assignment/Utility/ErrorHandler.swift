//
//  ErrorHandler.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 04/09/24.
//

import Foundation

enum ErrorHandler: Error {
    case fileNotAvailable
    case decodingError
    case error
    
    var message: String {
        switch self {
        case .fileNotAvailable:
            "Required json path not available"
        case .decodingError:
            "JSON decoding fail due to \(self.localizedDescription)"
        case .error:
            self.localizedDescription
        }
    }
}
