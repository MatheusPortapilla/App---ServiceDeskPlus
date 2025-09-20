import SwiftUI

struct ContentView: View{
    var body: some View {
        TabView {
            CatalogView()
                .tabItem { Label("Catálogo", systemImage: "rectangle.and.pencil.and.ellipsis") }
            ApprovalView()
                .tabItem { Label("Aprovações", systemImage: "checkmark.seal") }
            TriageView()
                .tabItem { Label( "Triagem IA", systemImage: "brain.head.profile") }
        }
    }
}
struct ApprovalView: View { var body: some View { Text("Aprovações Pendentes") } }
struct TriageView: View { var body: some View { Text ("Triagem com IA")}}

