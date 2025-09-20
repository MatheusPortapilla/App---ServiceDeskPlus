//
//  ApprovalsView.swift
//  ServiceDeskPlus
//
//  Created by Matheus Henrique Portapilla on 20/09/25.
//
import SwiftUI

struct ApprovalsView: View {
    @EnvironmentObject private var approvals: TicketApprovals

    var body: some View {
        NavigationStack {
            List {
                if approvals.approvalQueue.isEmpty {
                    Text("No pending approvals")
                        .foregroundStyle(.secondary)
                } else {

                    // percorre pelos índices para evitar o overload de Binding
                    ForEach(approvals.approvalQueue.indices, id: \.self) { i in
                        let t = approvals.approvalQueue[i]

                        VStack(alignment: .leading, spacing: 4) {
                            Text(t.title).font(.headline)
                            Text("\(t.service.name) • \(t.priority.label)")
                                .foregroundStyle(.secondary)
                            // use o nome real do seu campo de data: createdAt ou createAt
                            Text(t.createdAt.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)

                        HStack {
                            Button("Reject", role: .destructive) { approvals.reject(t.id) }
                            Spacer()
                            Button("Approve") { approvals.approve(t.id) }
                                .buttonStyle(.borderedProminent)
                        }
                        .padding(.bottom, 6)
                    }
                }
            }
            .navigationTitle("Approvals")
        }
    }
}
