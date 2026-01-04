//
//  Supabase.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 04.01.2026.
//

import Foundation
import Supabase

extension URL
{
    static func safe(_ string: String) -> URL {
        guard let url = URL(string: string) else {
            fatalError("Invalid URL string: \(string)")
        }
        return url
    }
}

enum SupabaseConfig
{
    static let url = URL.safe("https://yhrgykpzteuzxnnahivg.supabase.co")

    static let key = """
        eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.\
        eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlocmd5a3B6dGV1enhubmFoaXZnIiwicm9sZSI6\
        ImFub24iLCJpYXQiOjE3Njc0NjM3MzEsImV4cCI6MjA4MzAzOTczMX0.\
        NJkSojPr8Gu9pYz2Kamd_dr1IAqUXZfn78HgRWOdBMY
        """
}

final class SupabaseManager
{
    let supabase = SupabaseClient(
        supabaseURL: SupabaseConfig.url,
        supabaseKey: SupabaseConfig.key,
        options: .init(
            auth: .init(emitLocalSessionAsInitialSession: true)
        )
    )

    init() {}

    // регистрация в supabase
    func signUp(name: String, phone: String, email: String, password: String) async throws {
        try await supabase.auth.signUp(email: email, password: password)

        let user = try await supabase.auth.session.user

        let newUser = UserModel(id: user.id, name: name, email: email, phone: phone)

        try await supabase.database.from("users")
            .insert(newUser)
            .execute()

        try await supabase.auth.signOut()
    }

    // вход в supabase
    func signIn(email: String, password: String) async throws {
        try await supabase.auth.signIn(email: email, password: password)
    }

    // функция, которая выходит из аккаунта
    func logOut() async throws {
        try await supabase.auth.signOut()
    }
}
