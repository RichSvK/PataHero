import SwiftData
import SwiftUI

class ContentViewModel: ObservableObject {
    @AppStorage("hasSeededInitialData") private(set) var hasSeededInitialData: Bool = false
    
    @MainActor
    func seedInitialData(using context: ModelContext) {
        guard !hasSeededInitialData else { return }
        print("Seeding Data")
        
        var priority = 1
        let allProcedures = [armProcedure, wristProcedure, fingerProcedure, fibulaProcedure, ankleProcedure, toesProcedure]
        
        Task{
            for (index, fracture) in listFracture.enumerated() {
                if index < allProcedures.count {
                    for procedure in allProcedures[index] {
                        fracture.procedure.append(procedure)
                        procedure.fracture = fracture
                        context.insert(procedure)
                    }
                }
                
                fracture.priority = priority
                priority += 1
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
