import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack{
            if viewModel.hasSeededInitialData {
                TabView {
                    ChooseProcedureView()
                        .tabItem {
                            Image(systemName: "list.bullet")
                            Text("Pilih")
                        }
                    
                    HospitalView()
                        .tabItem{
                            Image(systemName: "house.fill")
                            Text("Eka Hospital")
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
