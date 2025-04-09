import SwiftUI

struct Procedure: View {
    @State private var currentStep: Int = 1
    @Environment(\.dismiss) var dismiss

    let fracture: DataFracture
    let fractureProcedure: [FractureProcedure]

    var totalStep: Int { fractureProcedure.count }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text(fracture.name)
                    .font(.custom("Optima-ExtraBlack", size: 14))
                    .padding(.horizontal, 20)
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .minimumScaleFactor(0.8)

                Spacer()

                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .bold(true)
                }
                .padding(.horizontal, 20)
            }
            .frame(height: 70)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .opacity(0.3),
                alignment: .bottom
            )

            // Progress Bar
            MultiStepProgressBar(numberOfSteps: totalStep, currentStep: $currentStep)
                .padding(.vertical, 20)
                .padding(.horizontal, 20)

            // TabView Area
            TabView(selection: $currentStep) {
                ForEach(1...totalStep, id: \.self) { step in
                    VStack {
                        StepCard(procedure: fractureProcedure[step - 1])

                        Spacer()
                    
                        if currentStep == totalStep {
                            CallButton()
                                .padding(.bottom, 20)
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    .tag(step)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: UIScreen.main.bounds.height * 0.7) // Jaga posisi kartu tetap
            .gesture(DragGesture()
                .onEnded { value in
                    let threshold: CGFloat = 50
                    if value.translation.width < -threshold, currentStep < totalStep {
                        currentStep += 1
                    } else if value.translation.width > threshold, currentStep > 1 {
                        currentStep -= 1
                    }
                }
            )
        }
        .frame(maxHeight: .infinity, alignment: .top) // Pastikan seluruh layout dari atas
        .background(Color(.systemGray6))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EmptyView()
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    Procedure(fracture: listFracture[0], fractureProcedure: armProcedure)
}
