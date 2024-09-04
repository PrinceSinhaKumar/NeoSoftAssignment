//
//  DataParser.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 04/09/24.
//

import Foundation

protocol Parser {
    func dataParser<T: Decodable>(for data: Data) async throws -> T
}

class DataParser: Parser {
    func dataParser<T: Decodable>(for data: Data) async throws -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ErrorHandler.decodingError
        }
    }
}
