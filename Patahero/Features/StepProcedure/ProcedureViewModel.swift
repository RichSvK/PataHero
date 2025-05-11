import SwiftUI

class ProcedureViewModel: ObservableObject {
    @Published var fractureName: String = ""
    @Published var procedures: [FractureProcedure] = []
    @Published var currentStep: Int = 1
    var totalStep: Int = 0
    
    init(fracture: Fracture){
        print("Initializing ProcedureViewModel ...")

        print("Loading \(fracture.name)  Procedures ...")
        self.fractureName = fracture.name
        self.procedures = fracture.procedure.sorted { $0.order < $1.order }
        self.totalStep = self.procedures.count
    }

    func handleSwipe(value: DragGesture.Value) {
        let threshold: CGFloat = 50
        if value.translation.width < -threshold {
            goToNextStep()
        } else if value.translation.width > threshold {
            goToPreviousStep()
        }
    }
    
    private func goToNextStep() {
        if currentStep < totalStep {
            currentStep += 1
        }
    }

    private func goToPreviousStep() {
        if currentStep > 1 {
            currentStep -= 1
        }
    }
}
