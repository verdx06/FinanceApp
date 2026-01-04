//
//  LoginViewModel+Router.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 14.11.2025.
//

import Foundation

extension LoginViewModel
{
    struct Router
    {
        let showRegisterFlowHandler: () -> Void
        let showMainFlowHandler: () -> Void
    }
}
