import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack{
            if viewModel.hasSeededInitialData {
                TabView {
                    ChooseProcedureView(viewModel: ChooseProcedureViewModel())
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
