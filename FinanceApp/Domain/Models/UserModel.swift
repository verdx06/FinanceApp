//
//  UserModel.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 04.01.2026.
//

import Foundation

struct UserModel: Codable
{
    let id: UUID
    let name: String
    let email: String
    let phone: String

    init(id: UUID = UUID(), name: String = "", email: String = "", phone: String = "") {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
    }
}
