import SwiftUI

struct MultiStepProgressBar: View {
    let numberOfSteps: Int
    @Binding var currentStep: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(1...numberOfSteps, id: \.self) { step in
                StepCircle(isCompleted: step <= currentStep)
                    .onTapGesture {
                        currentStep = step
                }
                
                if step < numberOfSteps {
                    ConnectingLine(isActive: step < currentStep)
                }
            }
        }
    }
}

struct StepCircle: View {
    let isCompleted: Bool
    
    var body: some View {
        Circle()
            .fill(isCompleted ? Color("ColorStepCircle") : .clear)
            .overlay(
                Circle()
                    .stroke(isCompleted ? Color("ColorStepCircle") : .gray, lineWidth: 2)
            )
            .frame(width: 35, height: 35)
    }
}

struct ConnectingLine: View {
    let isActive: Bool
    
    var body: some View {
        Rectangle()
            .fill(isActive ? Color("ColorStepCircle") : Color.gray)
            .frame(height: 2)
            .frame(maxWidth: .infinity)
    }
}

struct ProgressBarPreviews: View {
    @State var step = 1
    var body : some View {
        MultiStepProgressBar(numberOfSteps: 4, currentStep: $step)
    }
}

#Preview {
    ProgressBarPreviews()
}
