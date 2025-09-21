//
//  ApprovalsView.swift
//  ServiceDeskPlus
//
//  Created by Matheus Henrique Portapilla on 20/09/25.
//
import SwiftUI

struct ApprovalsView: View {
    @EnvironmentObject private var approvals: TicketApprovals
    
    private enum StatusFilter: String, CaseIterable, Identifiable {
        case Submitted, Approved, Rejected, All
        var id: String { rawValue }
        var label: String { rawValue.capitalized }
    }
    
    
    
    private func badgeBG( for status: Status) -> some ShapeStyle {
        switch status {
        case .submitted: return Color.blue.opacity(0.2)
        case .approved: return Color.green.opacity(0.2)
        case .rejected: return Color.red.opacity(0.2)
        case .resolved: return Color.mint.opacity(0.2)
        case .pending: return Color.gray.opacity(0.2)
        case .draft: return Color.gray.opacity(0.15)
        }
    }
    
    private var filteredTickets: [Ticket]{
        var items = approvals.submitted
        switch filter {
        case .Submitted:
            items = items.filter( { $0.status == .submitted })
        case .Approved:
            items = items.filter( { $0.status == .approved })
        case .Rejected:
            items = items.filter( { $0.status == .rejected})
        case .All:
            break
        }
        if sortByRecent {
            items.sort{ $0.createdAt > $1.createdAt}
        } else {
            items.sort{ $0.createdAt < $1.createdAt}
        }
        return items
    }
    
    @State private var filter: StatusFilter = .Submitted
    @State private var sortByRecent: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 20) {
                HStack {
                    Picker("Filter", selection: $filter){
                        ForEach(StatusFilter.allCases){ f in
                            Text(f.label).tag(f)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Menu {
                        Button {
                            sortByRecent = true
                        } label: {
                            Label("Recent firts", systemImage: sortByRecent ? "checkmark": "")}
                        Button {
                            sortByRecent = false
                        } label: {
                            Label("Oldest first", systemImage: !sortByRecent ? "checkmark" : "")
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }//FIM config MENU
            }//FIM VSTACK
            .padding(.horizontal)
            
            //LISTA
            if filteredTickets.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "tray")
                        .font(.system(size:44))
                        .foregroundStyle(.secondary)
                    Text("No tickets to show")
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(filteredTickets) { t in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack { //Configuração dos tickets para aprovar
                                Text(t.title).font(.headline)
                                Spacer()
                                Text(t.status.rawValue.capitalized)
                                    .font(.caption)
                                    .padding(.horizontal,8).padding(.vertical, 4)
                                    .background(badgeBG(for: t.status))
                                    .clipShape(Capsule())
                            }
                            Text("\(t.service.name) • \(t.priority.label)")
                                .foregroundStyle(.secondary)
                            Text(t.detail)
                                .font(Font.body.monospacedDigit())
                                .foregroundStyle(.secondary)
                            Text(t.createdAt.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                        //SWIPE ACTION
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                approvals.reject(t.id)
                            } label: {
                                Label("Reject", systemImage: "xmark.circle")
                            }
                            Button {
                                approvals.approve(t.id)
                            } label: {
                                Label("Approved", systemImage: "checkmark.circle")
                            }
                        }//fim SwipeAction
                    }// fim ForEach
                }//fim list
                .listStyle(.inset)
                //NOVO: pull-to-refresh (pornto simples no VM
                .refreshable {
                    await approvals.refresh()}
            } // fim else se tiver chamados
        }//fim navigation stack
                .navigationTitle("Tickets to Approvals")
            }//fim body
        }//fim struct
    
