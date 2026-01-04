//
//  URLParameterEncoder.swift
//  NetworkLayer
//
//  Created by Виталий Багаутдинов on 26.11.2025.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    static func encoding(urlRequest: inout URLRequest, parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), parameters.isEmpty == false {
            urlComponents.queryItems = [URLQueryItem]()

            for (key, value) in parameters {
                let queryItem = URLQueryItem(
                    name: key,
                    value: "\(value)".addingPercentEncoding(
                        withAllowedCharacters: .urlHostAllowed
                    )
                )

                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded: charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
