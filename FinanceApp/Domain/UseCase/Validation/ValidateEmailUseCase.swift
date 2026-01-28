//
//  ValidateEmailUseCase.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 06.01.2026.
//

import Foundation

protocol ValidateEmailUseCaseProtocol
{
    func execute(_ email: String) throws
}

final class ValidateEmailUseCase: ValidateEmailUseCaseProtocol
{
    func execute(_ email: String) throws {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        guard emailPredicate.evaluate(with: email) else {
            throw EmailValidationError.invalidFormat
        }
    }

    enum EmailValidationError: Error
    {
        case invalidFormat
    }
}
