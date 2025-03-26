import SwiftUI

struct MultiStepProgressBar: View {
    let numberOfSteps: Int
    @Binding var currentStep: Int
    
    
    init(numberOfSteps: Int = 4, currentStep: Int = 1, currentStepBinding: Binding<Int>) {
        self.numberOfSteps = numberOfSteps
        self._currentStep = currentStepBinding
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(1...numberOfSteps, id: \.self) { step in
                StepCircle(number: step, isCompleted: step <= currentStep)
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
    let number: Int
    let isCompleted: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(isCompleted ? Color(hex: "0043CE") : .clear)
                .overlay(
                    Circle()
                        .stroke(isCompleted ? Color(hex: "0043CE") : .gray, lineWidth: 2)
                )
                .frame(width: 35, height: 35)
            
            Text("\(number)")
                .font(.headline)
                .foregroundColor(isCompleted ? .white : .gray)
        }
    }
}

struct ConnectingLine: View {
    let isActive: Bool
    
    var body: some View {
        Rectangle()
            .fill(isActive ? Color(hex: "0043CE") : Color.gray)
            .frame(height: 2)
            .frame(maxWidth: .infinity)
    }
}

struct ProgressBar: View {
    @State private var currentStep: Int = 1
    
    var body: some View {
        VStack(spacing: 30) {
            MultiStepProgressBar(numberOfSteps: 4, currentStep: currentStep, currentStepBinding: $currentStep)
            Text("Current Step: \(currentStep) of 4")
                .font(.headline)
            
            HStack(spacing: 20) {
                Button("Previous") {
                    if currentStep > 1 {
                        currentStep -= 1
                    }
                }
                .disabled(currentStep <= 1)
                .buttonStyle(.borderedProminent)
                
                Button("Next") {
                    if currentStep < 4 {
                        currentStep += 1
                    }
                }
                .disabled(currentStep >= 4)
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

#Preview {
    ProgressBar()
}
