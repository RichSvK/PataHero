import SwiftUI
import SwiftData

struct ProcedureView: View {
    @StateObject var viewModel: ProcedureViewModel

    var body: some View {
        ZStack {
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
                
                CallButton()
                    .padding(20)
            }
            .background(Color("ColorBackground"))
            .overlay(
                Rectangle()
                    .fill(Color.black.opacity(0.2))
                    .frame(height: 1),
                alignment: .top
            )
            
            if !viewModel.hasSeenSwipeTutorial {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                
                SwipeTutorialView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(0)
        .onTapGesture {
            viewModel.setSwipeTutorial()
        }
    }
}
