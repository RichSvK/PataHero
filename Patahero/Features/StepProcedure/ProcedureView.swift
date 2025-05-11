import SwiftUI
import SwiftData

struct ProcedureView: View {
    @StateObject var viewModel: ProcedureViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            // Progress Bar
            MultiStepProgressBar(numberOfSteps: viewModel.totalStep, currentStep: $viewModel.currentStep)
                .padding(.vertical, 20)
                .padding(.horizontal, 20)

            // TabView Area
            TabView(selection: $viewModel.currentStep) {
                ForEach(Array(viewModel.procedures.enumerated()), id: \.element.id) { index, procedure in
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
                    viewModel.handleSwipe(value: value)
                }
            )
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    Spacer()
                    Text(viewModel.fractureName)
                        .font(.system(size: 16, weight: .semibold))
                        .dynamicTypeSize(.medium ... .large)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
