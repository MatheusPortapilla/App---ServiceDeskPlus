//
//  Models.swift
//  ServiceDeskPlus
//
//  Created by Matheus Henrique Portapilla on 19/09/25.
//
import Foundation


enum TicketPriority: Int, CaseIterable, Identifiable {
    case none = 0, low = 1, medium, high, critical

    var id: Int { rawValue }

    var label: String {
        switch self {
        case .none:     "None"
        case .low:      "Low"
        case .medium:   "Medium"
        case .high:     "High"
        case .critical: "Critical"
        }
    }
}

enum Status:String, CaseIterable {
    case draft, submitted, approved, rejected, resolved, pending
}

enum ItemKind: String, CaseIterable, Identifiable{
    case iphone, macbook, mouse, keyboard, printer, airpods, password,none
    var id: String { rawValue }
    var label: String {
        rawValue.capitalized
    }
}
enum RequestType: String, CaseIterable, Identifiable{
    case software, hardware, change, request, doubt, suggestion, none
    var id: String { rawValue }
    var label: String {
        rawValue.capitalized
    }
}

                
struct ServiceItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let description: String
}

struct Ticket: Identifiable {
    // use **uma** chave só: id (minúsculo)
    let id: UUID

    var service: ServiceItem
    var requestType: RequestType
    var title: String
    var detail: String
    var item: ItemKind
    var priority: TicketPriority
    var createdAt: Date
    var status: Status
    
    // UM init que cobre os dois cenários:
    // - criação pela UI: não passa `id` => usa UUID()
    // - mapeamento do Core Data: passa `id: row.id`
    init(
        id: UUID = UUID(),
        service: ServiceItem,
        requestType: RequestType,
        title: String,
        detail: String,
        item: ItemKind,
        priority: TicketPriority,
        createdAt: Date = .now,
        status: Status = .draft
    ) {
        self.id = id
        self.service = service
        self.requestType = requestType
        self.title = title
        self.detail = detail
        self.item = item
        self.priority = priority
        self.createdAt = createdAt
        self.status = status
    }
}

