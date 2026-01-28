//
//  ValidateAuthUseCase.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 04.01.2026.
//

import Foundation

protocol ValidateAuthUseCaseProtocol
{
    func execute(_ field: String) throws
    func executeEmail(_ email: String) throws
    func executePassword(_ password: String, additional: Bool) throws
}

final class ValidateAuthUseCase
{
    private let generalValidate = GeneralValidator()

    enum EmailValidationError: Error
    {
        case invalidFormat
    }
}

extension ValidateAuthUseCase: ValidateAuthUseCaseProtocol
{
    func execute(_ field: String) throws {
        try self.generalValidate.isLenghtIsMin(filed: field, min: 2)
    }

    func executePassword(_ password: String, additional: Bool) throws {
        try self.generalValidate.isLenghtIsMin(filed: password, min: 5)

        if additional {
            try self.generalValidate.isLowercase(field: password)
            try self.generalValidate.isUppercase(field: password)
            try self.generalValidate.isNumber(field: password)
        }
    }

    func executeEmail(_ email: String) throws {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        guard emailPredicate.evaluate(with: email) else {
            throw EmailValidationError.invalidFormat
        }
    }
}
