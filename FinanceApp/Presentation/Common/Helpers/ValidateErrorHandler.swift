//
//  ValidateErrorHandler.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 05.01.2026.
//

import Foundation

enum ValidateErrorHandler
{
    static func message(_ error: Error) -> String {
        if let emailError = error as? ValidateEmailUseCase.EmailValidationError {
            return self.emailMessage(emailError)
        }

        if let generalError = error as? GeneralValidator.GeneralValidatorError {
            return self.generalMessgae(generalError)
        }
        return "Неизвестная ошибка"
    }
}

extension ValidateErrorHandler
{
    private static func emailMessage(_ error: ValidateEmailUseCase.EmailValidationError) -> String {
        switch error {
        case .invalidFormat:
            "Неверный формат почты"
        }
    }

    private static func generalMessgae(_ error: GeneralValidator.GeneralValidatorError) -> String {
        switch error {
        case .lenghtIsMin:
            "Длина меньше требуемой"
        case .noNumber:
            "Добавьте цифры"
        case .noLower:
            "Добавьте нижний регистр"
        case .noUpper:
            "Добавьте верхний регистр"
        }
    }
}
