import SwiftUI


    
struct RequestFormView: View {
    let service: ServiceItem
    
    @State private var title: String = ""
    @State private var detail: String = ""
    @State private var requestType: RequestType = .none
    @State private var item: ItemKind = .none
    @State private var priority: TicketPriority = .none
    
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
                #if os(iOS)
                        .textInputAutocapitalization(.sentences)
                #endif
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
                        ForEach(TicketPriority.allCases) { p in Text(p.label).tag(p) }
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

