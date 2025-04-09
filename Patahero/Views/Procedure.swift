import SwiftUI

struct Procedure: View {
    @State private var currentStep: Int = 1
    @Environment(\.dismiss) var dismiss
    
    let fracture: DataFracture
    let fractureProcedure: [FractureProcedure]
    
    var totalStep: Int { fractureProcedure.count }

    var body: some View {
        VStack {
            // Header
            HStack {
                Text(fracture.name)
                    .font(.custom("Optima-ExtraBlack", size: 14))
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
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
                .padding(.vertical, 10)
                .padding(.horizontal, 20)

            // Card Steps
            TabView(selection: $currentStep) {
                ForEach(1...totalStep, id: \.self) { step in
                    VStack {
                        CardStep(
                            procedure: fractureProcedure[step - 1],
                            cardWidth: UIScreen.main.bounds.width * 0.85,
                            cardHeight: UIScreen.main.bounds.height * 0.55
                        )

                        Spacer(minLength: 30)
                    }
                    .tag(step)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: UIScreen.main.bounds.height * 0.6) // Batasi tinggi swipeable area
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

            Spacer()

            if currentStep == totalStep {
                CallButton()
                    .padding(.bottom, 20) // Jarak tombol ke bawah layar
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EmptyView()
            }
        }
        .background(Color(.systemGray6))
        .ignoresSafeArea(edges: .bottom)
    }

}

#Preview {
    Procedure(fracture: listFracture[0], fractureProcedure: armProcedure)
}
