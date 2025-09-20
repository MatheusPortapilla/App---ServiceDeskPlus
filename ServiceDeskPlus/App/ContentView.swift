import SwiftUI

struct ContentView: View{
    var body: some View {
        TabView {
            CatalogView()
                .tabItem { Label("Catálogo", systemImage: "rectangle.and.pencil.and.ellipsis") }
            ApprovalsView()
                .tabItem { Label("Aprovações", systemImage: "checkmark.seal") }
            TriageView()
                .tabItem { Label( "Triagem IA", systemImage: "brain.head.profile") }
        }
    }
}
struct TriageView: View { var body: some View { Text ("Triagem com IA")}}

