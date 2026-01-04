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
    }

    func isLenghtIsMin(filed: String, min: Int) throws {
        guard filed.count >= min else { throw GeneralValidatorError.lenghtIsMin }
    }
}
