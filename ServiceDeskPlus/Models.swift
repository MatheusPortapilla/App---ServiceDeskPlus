//
//  Models.swift
//  ServiceDeskPlus
//
//  Created by Matheus Henrique Portapilla on 19/09/25.
//
import Foundation


enum Priority: Int, CaseIterable, Identifiable {
    case low = 1,medium, higth, critical,none
    var id: Int { rawValue }
    var label: String {
        switch self {
        case .low: "Low"
        case .medium: "Medium"
        case .higth: "Higth"
        case .critical: "Crítical"
        case .none : "None"
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
    let id = UUID()
    var service: ServiceItem
    var requestType: RequestType
    var title: String
    var detail: String
    var item: ItemKind
    var priority: Priority
    var createdAt: Date = .now
    var status: Status = .draft
    
}

