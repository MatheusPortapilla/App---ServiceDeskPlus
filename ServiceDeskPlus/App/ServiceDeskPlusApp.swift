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
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
