//
//  GeneralValidator.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 05.01.2026.
//

import Foundation

final class GeneralValidator
{
    enum GeneralValidatorError: Error
    {
        case lenghtIsMin
        case noNumber
        case noLower
        case noUpper
    }

    func isLenghtIsMin(filed: String, min: Int) throws {
        guard filed.count >= min else { throw GeneralValidatorError.lenghtIsMin }
    }

    func isNumber(field: String) throws {
        guard field.contains(where: { $0.isNumber }) else {
            throw GeneralValidatorError.noNumber
        }
    }

    func isUppercase(field: String) throws {
        guard field.contains(where: { $0.isUppercase }) else {
            throw GeneralValidatorError.noUpper
        }
    }

    func isLowercase(field: String) throws {
        guard field.contains(where: { $0.isLowercase }) else {
            throw GeneralValidatorError.noLower
        }
    }
}
