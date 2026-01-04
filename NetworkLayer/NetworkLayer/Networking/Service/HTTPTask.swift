//
//  HTTPTask.swift
//  NetworkLayer
//
//  Created by Виталий Багаутдинов on 26.11.2025.
//

import Foundation

typealias Parameters = [String: Any]

enum HTTPTask
{
    case request
    case requestBody(Data)
    case requestUrlParameters(Parameters)
}
