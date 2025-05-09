import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("hasSeededInitialData") private var hasSeededInitialData: Bool = false
    @Environment(\.modelContext) private var context

    
    var body: some View {
        TabView{
            ChooseProcedureView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Pilih")
                }
            
            MapView()
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("Eka Hospital")
                }
        }
        .onAppear {
            if !hasSeededInitialData {
                seedAppData(using: context)
            }
        }
    }
    
    private func seedAppData(using context: ModelContext) {
        let allProcedures = [armProcedure, fingerProcedure, wristProcedure, footProcedure]

        Task{
            for (index, fracture) in listFracture.enumerated() {
                if index < allProcedures.count {
                    for procedure in allProcedures[index] {
                        fracture.procedure.append(procedure)
                        procedure.fracture = fracture
                        context.insert(procedure)
                    }
                }
                context.insert(fracture)
            }
            
            do {
                try context.save()
                self.hasSeededInitialData = true
            } catch {
                print("Gagal menyimpan data awal: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
}
