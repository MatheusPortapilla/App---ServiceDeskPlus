//
//  TicketApprovalls.swift
//  ServiceDeskPlus
//
//  Created by Matheus Henrique Portapilla on 20/09/25.
//
import Foundation
import Combine

@MainActor
final class TicketApprovals: ObservableObject {
    
    //1) Estado observado pela I (Somente leitura para o user)
    @Published private(set) var submitted: [Ticket] = []
    @Published private(set) var approvalQueue: [Ticket] = []
    
    //2) Ação: enviar um ticket (vai para historico de entra em fila)
    func submit(_ ticket: Ticket) {
        var t = ticket
        t.status = .submitted    //chamado enviado
        submitted.append(t)    //historico
        approvalQueue.append(t)  //fila de aprovação
    }
    
    //3) Ações de aprovar ou rejeitar o ticket
    func approve(_ id: UUID) { update(id) { $0.status = .approved} }
    func reject(_ id :UUID) { update(id) { $0.status = .rejected} }
    
     //4) Interno Aplica a atualização na lista
    private func update(_ id: UUID, _ mutate: (inout Ticket) -> Void) {
        if let i = submitted.firstIndex(where: { $0.id == id }) {
            mutate(&submitted[i]) //pega o id do ticket gerado
        }
        if let j = approvalQueue.firstIndex(where: {$0.id == id}) {
            mutate(&approvalQueue[j]) //atualiza na fila
            approvalQueue.remove(at: j) //remove o ticket novo da fila apos atualizar
        }
    }
    
}//end final class
