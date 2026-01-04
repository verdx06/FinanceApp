//
//  ProfileDetailsView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 13.12.2025.
//

import SwiftUI

struct ProfileDetailsView: View
{
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }
    }
}

#Preview {
    ProfileDetailsView()
}
