import SwiftUI
import SwiftData

struct ProcedureView: View {
    @State private var currentStep: Int = 1
    @Environment(\.dismiss) var dismiss

    let fracture: Fracture
    var totalStep: Int { fracture.procedure.count }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text(fracture.name)
                    .font(.title)
                    .padding(.horizontal, 20)
                    .dynamicTypeSize(.medium ... .large)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)

                Spacer()

                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .bold(true)
                }
                .dynamicTypeSize(.small ... .medium)
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
                let orderedProcedures = fracture.procedure.sorted { $0.order < $1.order }

                ForEach(Array(orderedProcedures.enumerated()), id: \.element.id) { index, procedure in
                    VStack {
                        StepCard(procedure: procedure)

                        Spacer()

                        CallButton()
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 20)
                    .tag(index + 1)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
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
        .frame(maxHeight: .infinity, alignment: .top)
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
    ProcedureView(fracture: listFracture[2])
}
