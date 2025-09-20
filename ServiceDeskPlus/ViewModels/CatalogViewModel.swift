//
//  CatalogViewModel.swift
//  ServiceDeskPlus
//
//  Created by Matheus Henrique Portapilla on 19/09/25.
//
import Foundation
import Combine

final class CatalogViewModel: ObservableObject {
    @Published var services: [ServiceItem] = [
        ServiceItem(name: "Reset de Senha", description: "Redefinição de senha corporativa"),
        ServiceItem(name: "Acesso a Sistema", description: "Solicitar acesso a uma aplicação"),
        ServiceItem(name: "Novo Equipamento", description: "Compra de computador, impressora e outros equipamentos"),
        ServiceItem(name: "Incidente de ServiceDesk", description: "Incidente de suporte técnico"),
        ServiceItem(name: "Dúvidas", description: "Duvidas e sugestões")
        
    ]
}
