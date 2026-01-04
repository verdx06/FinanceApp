//
//  NetworkConfig.swift
//  NetworkLayer
//
//  Created by Виталий Багаутдинов on 05.12.2025.
//

import Foundation

protocol NetworkConfig
{
    var path: String { get }
    var endPoint: String { get }

    var task: HTTPTask { get }
    var method: HTTPMethod { get }
}
