//
//  ApiConfiguration.swift
//  NetworkLayer
//
//  Created by Виталий Багаутдинов on 10.12.2025.
//

import Foundation

struct ApiConfiguration
{
    private let apiEndpoint: String

    init(apiEndpoint: String) {
        self.apiEndpoint = apiEndpoint
    }

    var gatewayEndpoint: String {
        self.apiEndpoint + ""
    }
}
