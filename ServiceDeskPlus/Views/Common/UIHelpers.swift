//
//  UIHelpers.swift
//  ServiceDeskPlus
//
//  Created by Matheus Henrique Portapilla on 20/09/25.
//
import SwiftUI
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
