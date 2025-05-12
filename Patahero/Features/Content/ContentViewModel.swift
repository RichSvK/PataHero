import SwiftUI
import SwiftData

class ContentViewModel: ObservableObject {
    @AppStorage("hasSeededInitialData") private(set) var hasSeededInitialData: Bool = false
    
    @MainActor
    func seedInitialData(using context: ModelContext) {
        guard !hasSeededInitialData else { return }
        print("Seeding Data")
        
        let allProcedures = [armProcedure, fingerProcedure, wristProcedure, ankleProcedure, toesProcedure, fibulaProcedure]
        
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
