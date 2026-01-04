//
//  AuthRepository.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 04.01.2026.
//

import Foundation

protocol AuthRepository
{
    func login(credentials: AuthCredentials) async throws
}
