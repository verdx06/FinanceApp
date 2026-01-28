//
//  MainProfileUseCase.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 28.01.2026.
//

import Foundation

protocol MainProfileUseCaseProtocol
{
    func execute() async throws -> UserModel
}

final class MainProfileUseCase
{}

extension MainProfileUseCase: MainProfileUseCaseProtocol
{
    func execute() async throws -> UserModel {
        UserModel(id: UUID(), name: "", email: "", phone: "")
    }
}
