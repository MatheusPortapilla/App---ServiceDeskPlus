//
//  RequestFormView.swift
//  ServiceDeskPlus
//
//  Created by Matheus Henrique Portapilla on 19/09/25.
//
import SwiftUI

struct RequestFormView: View {
    let service: ServiceItem
    
    //Setar os campos vazios no inicio do formulario -- Default Value
    @State private var title: String = ""
    @State private var detail: String = ""
    @State private var requestType: RequestType = .none
    @State private var item: ItemKind = .none
    @State private var priority: Priority = .low
    
    @State private var preview: Ticket?
    @State private var showPreview = false
    
    var body: some View {
        Form {
            Section{
                Text(service.name).font(.headline)
                Text(service.description).font(.subheadline)
            }header: {
                Label("Service", systemImage: "wrench.and.screwdriver")
            }
            
            Section {
                TextField("Título (por que você precisa do serviço)", text: $title)
                    .textInputAutocapitalization(.sentences)
                TextField("Descrição detalhada", text: $detail, axis: .vertical)
                    .lineLimit(3...6)
            } header: {
                Label("Ticket info", systemImage: "square.and.pencil") //cabeçalho das seções
            }
            Section{
                Picker("Request Type", selection: $requestType) {
                    ForEach(RequestType.allCases){ t in
                        Text(t.label).tag(t)
                    }
                }
                Picker("Itens", selection: $item){
                    ForEach(ItemKind.allCases){ k in
                        Text(k.label).tag(k)
                    }
                }
                Picker("Pritority", selection: $priority){
                    ForEach(Priority.allCases){ p in
                        Text(p.label).tag(p)
                    }
                }
            } header: {
                Label("Classification", systemImage: "list.bullet")
            }
            Section{
                Button {
                    preview = Ticket(
                        service: service,
                        requestType: requestType,
                        title: title,
                        detail: detail,
                        item: item,
                        priority: priority
                    )
                    showPreview = true
                } label: {Label("Send request", systemImage: "paperplane.fill")
                }
                .disabled(title.isEmpty || detail.isEmpty || requestType == .none || item == .none)
            }
        }
            .navigationTitle("Request: \(service.name)")
            .sheet(isPresented: $showPreview){
                if let t = preview {
                    Section{
                        VStack(alignment: .leading, spacing: 6){
                            Text("Ticket preview").font(.headline)
                            Text("Title: \(t.title)")
                            Text("Description: \(t.detail)")
                            Text("Type: \(t.requestType.label)")
                            Text("Item: \(t.item.label)")
                            Text("Priority: \(t.priority.label)")
                            Text("Status \(t.status.rawValue)")
                        }
                    } header: {
                        Label("Préview", systemImage: "sparkles.rectangle.stack")
                            .symbolEffect(.bounce, options: .repeat(1)) // iOS 17+/macOS 14+
                            .imageScale(.medium)
                    }
                    .headerProminence(.increased)
                }
        }
    }
}
struct PreviewCard: View {
    let ticket: Ticket
    let onConfirm: () -> Void
    let onEdit: () -> Void
    
    var body: some View {
        VStack(spacing:16){
            Label("Préview", systemImage: "sparkles.rectangle.stack")
                     .symbolEffect(.bounce, options: .repeat(1)) // iOS 17+/macOS 14+
                   .imageScale(.medium)
            
             .headerProminence(.increased)
             
            Text("Ticket preview").font(.headline)
            Text("Title: \(ticket.title)")
            Text("Description: \(ticket.detail)")
            Text("Type: \(ticket.requestType.label)")
            Text("Item: \(ticket.item.label)")
            Text("Priority: \(ticket.priority.label)")
            Text("Status \(ticket.status.rawValue)")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        HStack {
            Button("Edit"){ onEdit()}
            Spacer()
            Button("Confirm"){
                onConfirm()}
            .buttonStyle(.borderedProminent)
        }
        .padding(24)
        .frame(minWidth: 360)
    }

}

        
    
