//
//  UIHelpers.swift
//  ServiceDeskPlus
//
//  Created by Matheus Henrique Portapilla on 20/09/25.
//
import SwiftUI

struct HeaderLabel: View{
    let title: String
    let systemName: String
    
    var body: some View {
        if #available(iOS 16,macOS 13, *) {
            Label(title, systemImage: systemName)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.mint, .secondary) //1 cor no traço, 2 no preenchimento
                .listRowBackground(Color.mint.opacity(0.07))
        } else {
            Label(title, systemImage: systemName)
                .foregroundStyle(.mint)
        }
    }
}

extension TicketPriority {
    var color: Color {
        switch self {
        case .critical: .red
        case .high:     .orange
        case .medium:   .yellow
        case .low:      .primary
        case .none:     .secondary
        }
    }
}
