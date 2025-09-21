//
//  PreviewCard.swift
//  ServiceDeskPlus
//
//  Created by Matheus Henrique Portapilla on 20/09/25.
//
import SwiftUI

struct PreviewCard: View {
    let ticket: Ticket
    let onConfirm: () -> Void
    let onEdit: () -> Void
    


    var body: some View {
        VStack(spacing: 16) {
            if #available(iOS 17, macOS 14, *) {
                Label("Ticket preview", systemImage: "sparkles.rectangle.stack")
                    .font(.title2.bold())
                    .symbolEffect(.bounce, options: .repeat(1))
                    .imageScale(.medium)
            } else {
                Text("Ticket preview").font(.title2.bold())
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Title: \(ticket.title)")
                Text("ID: \(ticket.id.uuidString)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)
                    .lineLimit(1)
                    .truncationMode(.middle)
                Text("Description: \(ticket.detail)")
                Text("Type: \(ticket.requestType.label)")
                Text("Item: \(ticket.item.label)")
                Text("Priority: \(ticket.priority.label)").foregroundStyle(ticket.priority.color)
                Text("Status: \(ticket.status.rawValue)")
                Text("Created on: \(ticket.createdAt,style: .date)")
                Text("Time: \(ticket.createdAt,style: .time)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Button("Edit") { onEdit() }
                Spacer()
                Button {
                    onConfirm() } label: {
                        Label("Confirm", systemImage: "checkmark.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding(24)
        .frame(minWidth: 360)
    }
}


