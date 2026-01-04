//
//  ValidateAuthUseCase.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 04.01.2026.
//

import Foundation

protocol ValidateAuthUseCaseProtocol
{
    func executeEmail(_ email: String) throws
    func executePassword(_ password: String) throws
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
    func executePassword(_ password: String) throws {
        try self.generalValidate.isLenghtIsMin(filed: password, min: 5)
    }

    func executeEmail(_ email: String) throws {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        guard emailPredicate.evaluate(with: email) else {
            throw EmailValidationError.invalidFormat
        }
    }
}
