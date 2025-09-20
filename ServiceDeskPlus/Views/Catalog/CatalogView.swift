//
//  Untitled.swift
//  ServiceDeskPlus
//
//  Created by Matheus Henrique Portapilla on 19/09/25.
//
import SwiftUI

struct CatalogView: View {
    @StateObject private var vm = CatalogViewModel()
    
    var body: some View {
        NavigationStack {
            List(vm.services) { item in
                NavigationLink(item.name) {
                    RequestFormView(service: item)
                }
            }
            .navigationTitle("Catálogo de Serviços")
        }
    }
}
