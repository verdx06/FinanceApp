//
//  TextFieldState.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 15.11.2025.
//

import Foundation

struct TextFieldState: Equatable
{
    let type: FieldType
    var content: String = ""
    var error: String?

    init(
        _ type: FieldType,
        content: String = "",
        error: String? = nil
    ) {
        self.type = type
        self.content = content
        self.error = error
    }
}

extension TextFieldState
{
    var isErrorShowing: Bool {
        self.error != nil
    }

    var isInvalid: Bool {
        self.type.isRequired == true && self.content.isEmpty == true || self.error != nil
    }

    var needsToBeValidated: Bool {
        self.type.isRequired == true || self.content.isEmpty == false
    }
}
