//
//  ValidateNameUseCase.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 06.01.2026.
//

import Foundation

protocol ValidateNameUseCaseProtocol
{
    func execute(_ name: String) throws
}

final class ValidateNameUseCase
{
    private let generalValidate = GeneralValidator()
}

extension ValidateNameUseCase: ValidateNameUseCaseProtocol
{
    func execute(_ name: String) throws {
        try self.generalValidate.isLenghtIsMin(filed: name, min: 2)
    }
}
