import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    @Environment(\.modelContext) var context
    @State private var selectedTab: Int = 0

    var body: some View {
        NavigationStack{
            if viewModel.hasSeededInitialData {
                TabView (selection: $selectedTab){
                    ChooseProcedureView()
                        .tabItem {
                            Image(systemName: "list.bullet")
                            Text("Prosedur")
                        }
                        .tag(0)
                    
                    HospitalView()
                        .tabItem{
                            Image(systemName: "house.fill")
                            Text("Eka Hospital")
                        }
                        .tag(1)
                }
                .onOpenURL{ url in
                    if url == URL(string: "Patahero://hospital")! {
                        selectedTab = 1
                    }
                    
                    if url == URL(string: "Patahero://call")! {
                        selectedTab = 1
                        
                        let phone = "tel://081360986278"
                        if let phoneUrl = URL(string: phone) {
                            UIApplication.shared.open(phoneUrl)
                        }
                    }
                }
                .onAppear{
                    let tabColor = UIColor(Color("ColorTabView"))
                    let tabBarAppearance = UITabBarAppearance()
                    tabBarAppearance.configureWithOpaqueBackground()
                    tabBarAppearance.backgroundColor = tabColor
                    
                    UITabBar.appearance().standardAppearance = tabBarAppearance
                    if #available(iOS 15.0, *) {
                        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                    }
                }
                .navigationTitle("Prosedur")
                .toolbar(.hidden, for: .navigationBar)
            } else {
                ProgressView("Menunggu data...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
        }
        .onAppear {
            viewModel.seedInitialData(using: context)
        }
    }
}

#Preview {
    ContentView()
}
