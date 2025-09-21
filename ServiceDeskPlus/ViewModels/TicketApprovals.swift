//
//  TicketApprovals.swift
//  ServiceDeskPlus
//
//  Created by Matheus Henrique Portapilla on 20/09/25.
//
import Foundation
import Combine
import CoreData

@MainActor
final class TicketApprovals: ObservableObject {
    
    private let context: NSManagedObjectContext
    
    //1) Estado observado pela UI (Somente leitura para o user)
    @Published private(set) var submitted: [Ticket] = []
    @Published private(set) var approvalQueue: [Ticket] = []
    
     //init para chamar o data core no loadFromStore()
    init(context: NSManagedObjectContext){
        self.context = context
        loadFromStore()
    }
    //Mapeamento dos tickets gerados
    private func loadFromStore() {
        let req: NSFetchRequest<TicketRecord> = TicketRecord.fetchRequest()
        req.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        do {
            let rows = try context.fetch(req)
            self.submitted = rows.map{ row in
                Ticket(
                    id: row.id ?? UUID(),
                    service: ServiceItem(name: row.serviceName ?? "", description: ""),
                    requestType: RequestType(rawValue: row.requestType ?? "") ?? .request,
                    title: row.title ?? "",
                    detail: row.detail ?? "",
                    item: ItemKind(rawValue: row.item ?? "") ?? .none,
                    priority: TicketPriority(rawValue: Int(row.priority)) ?? .low,
                    createdAt: row.createdAt ?? .now,
                    status: Status(rawValue: row.status ?? "" ) ?? .submitted
                   )
            }
            self.approvalQueue = self.submitted.filter { $0.status == .submitted}
        } catch {
            print("CoreData fetch error: \(error)")
        }
    }
    
    //2) Ação: enviar um ticket (vai para historico de entra em fila)
    func submit(_ ticket: Ticket) {
        let e = TicketRecord(context: context)
        e.id = ticket.id
        e.title = ticket.title
        e.detail = ticket.detail
        e.requestType = ticket.requestType.rawValue
        e.item = ticket.item.rawValue
        e.serviceName = ticket.service.name
        e.priority = Int16(ticket.priority.rawValue)
        e.createdAt = ticket.createdAt
        e.status = Status.submitted.rawValue
        
        do {
            try context.save()
            loadFromStore()
        } catch {
            print("CoreData save error (submit): \(error)")
        }
    }
    //3) Ações de aprovar ou rejeitar o ticket
    func approve(_ id: UUID) { updateStatus(id, to : .approved) }
    func reject(_ id :UUID) { updateStatus(id, to : .rejected) }
    
     //4) Interno Aplica a atualização na lista
    private func updateStatus(_ id: UUID, to newStatus: Status) {
        let req:NSFetchRequest<TicketRecord> = TicketRecord.fetchRequest()
        req.fetchLimit = 1
        req.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            if let record = try context.fetch(req).first {
                record.status = newStatus.rawValue
                try context.save()
                loadFromStore()
            }
        } catch {
            print("CoreData save error (submit): \(error)")
        }
    }
    
}//end final class
