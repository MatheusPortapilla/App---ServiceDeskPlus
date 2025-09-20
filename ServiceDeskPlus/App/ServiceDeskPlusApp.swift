//
//  ServiceDeskPlusApp.swift
//  ServiceDeskPlus
//
//  Created by Matheus Henrique Portapilla on 19/09/25.
//

import SwiftUI
import CoreData

@main
struct ServiceDeskPlusApp: App {
    private let persistenceController = PersistenceController.shared
    @StateObject private var approvals: TicketApprovals
    init() {
        let ctx = persistenceController.container.viewContext
        _approvals = StateObject(wrappedValue: TicketApprovals(context: ctx))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(approvals)
        }
    }
}
