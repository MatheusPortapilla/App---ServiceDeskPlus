import SwiftUI

struct RequestFormView: View {
    let service: ServiceItem
    
    @State private var title: String = ""
    @State private var detail: String = ""
    @State private var requestType: RequestType = .none
    @State private var item: ItemKind = .none
    @State private var priority: Priority = .none
    
    @State private var preview: Ticket?
    @State private var showPreview = false
    
    var body: some View {
        Form {
            Section {
                HStack( alignment:.top, spacing: 12) {
                    Image(systemName: "wrench.and.screwdriver")
                        .font(.title2)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.mint, .blue.opacity(0.6))
                        .frame(width: 28)
                    
                    VStack( alignment:.leading, spacing: 4){
                        Text(service.name).font(.headline)
                        Text(service.description).font(.subheadline)
                    }
                }
            } header: {
                HeaderLabel(title: "Service", systemName:"wrench.and.screwdriver")
            }
            
                Section {
                    TextField("Título (por que você precisa do serviço)", text: $title)
                #if os(iOS)
                        .textInputAutocapitalization(.sentences)
                #endif
                    TextField("Descrição detalhada", text: $detail, axis: .vertical)
                        .lineLimit(3...6)
                } header: {
                    HeaderLabel(title:"Ticket info", systemName: "square.and.pencil")
                }
                
                Section {
                    Picker("Request Type", selection: $requestType) {
                        ForEach(RequestType.allCases) { t in Text(t.label).tag(t) }
                    }
                    Picker("Item", selection: $item) {
                        ForEach(ItemKind.allCases) { k in Text(k.label).tag(k) }
                    }
                    Picker("Priority", selection: $priority) {
                        ForEach(Priority.allCases) { p in Text(p.label).tag(p) }
                    }
                } header: {
                    HeaderLabel(title:"Classification", systemName: "list.bullet")
                }
                
                Section {
                    Button {
                        preview = Ticket(
                            service: service,
                            requestType: requestType,
                            title: title,
                            detail: detail,
                            item: item,
                            priority: priority,
                            createdAt: Date()
                        )
                        showPreview = true
                    } label: {
                        Label("Send request", systemImage: "paperplane.fill")
                    }
                    .disabled(title.isEmpty || detail.isEmpty || requestType == .none || item == .none)
                }
            .tint(.mint)
            .navigationTitle("Request: \(service.name)")
            .sheet(isPresented: $showPreview) {
                if let t = preview {
                    PreviewCard(
                        ticket: t,
                        onConfirm: { showPreview = false },   // depois ligamos no TicketStore
                        onEdit:    { showPreview = false }
                    )
                #if os(iOS)
                    .presentationDetents([.medium, .large])
                #endif
                } else {
                    Text("Nothing to preview").padding()
                }
            } // FIM SHEET
        }.tint(.mint) //FIM FORM
    } // FIM BODY
} // FIM REQUEST FORM VIEW
// ---- Preview modal (fora do RequestFormView) ----
struct PreviewCard: View {
    let ticket: Ticket
    let onConfirm: () -> Void
    let onEdit: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            if #available(iOS 17, macOS 14, *) {
                Label("Ticket preview", systemImage: "sparkles.rectangle.stack")
                    .font(.title2.bold())
                    .symbolEffect(.bounce, options: .repeat(1))
                    .imageScale(.medium)
            } else {
                Text("Ticket preview").font(.title2.bold())
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Title: \(ticket.title)")
                Text("Description: \(ticket.detail)")
                Text("Type: \(ticket.requestType.label)")
                Text("Item: \(ticket.item.label)")
                Text("Priority: \(ticket.priority.label)")
                Text("Status: \(ticket.status.rawValue)")
                Text("Created on: \(ticket.createdAt)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Button("Edit") { onEdit() }
                Spacer()
                Button("Confirm") { onConfirm() }
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding(24)
        .frame(minWidth: 360)
    }
}
struct HeaderLabel: View{
    let title: String
    let systemName: String
    
    var body: some View {
        if #available(iOS 16,macOS 13, *) {
            Label(title, systemImage: systemName)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.mint, .secondary) //1 cor no traço, 2 no preenchimento
                .listRowBackground(Color.mint.opacity(0.07))
        } else {
            Label(title, systemImage: systemName)
                .foregroundStyle(.mint)
        }
    }
}

