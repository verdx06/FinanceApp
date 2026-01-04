//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Виталий Багаутдинов on 26.11.2025.
//

import Foundation

enum NetworkError: Error
{
    case noConnect
    case missingURL
    case invalidData
    case unauthorized
    case requestFailed
    case decodingError
    case encodingError
    case encodingFailed
    case invalidResponse
    case methodNotAllowed
}
