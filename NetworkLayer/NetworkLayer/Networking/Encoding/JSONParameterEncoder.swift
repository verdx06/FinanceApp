//
//  JSONParametersEncoder.swift
//  NetworkLayer
//
//  Created by Виталий Багаутдинов on 26.11.2025.
//

import Foundation

public struct JSONParametersEncoder: ParameterEncoder {
    static func encoding(urlRequest: inout URLRequest, parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
    
}
