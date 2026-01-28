//
//  ValidatePasswordUseCase.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 06.01.2026.
//

import Foundation

protocol ValidatePasswordUseCaseProtocol
{
    func execute(_ password: String, additional: Bool) throws
}

final class ValidatePasswordUseCase
{
    private let generalValidate = GeneralValidator()
}

extension ValidatePasswordUseCase: ValidatePasswordUseCaseProtocol
{
    func execute(_ password: String, additional: Bool) throws {
        try self.generalValidate.isLenghtIsMin(filed: password, min: 6)

        if additional {
            try self.generalValidate.isLowercase(field: password)
            try self.generalValidate.isUppercase(field: password)
            try self.generalValidate.isNumber(field: password)
        }
    }
}
