import SwiftUI
import SwiftData

struct ProcedureView: View {
    @StateObject var viewModel: ProcedureViewModel
    @State private var tutorialPresented: Bool = false
    
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
            .ignoresSafeArea(edges: .bottom)
            .background(Color("ColorBackground"))
            .overlay(
                Rectangle()
                    .fill(Color.black.opacity(0.3))
                    .frame(height: 1),
                alignment: .top
            )
            
            if !tutorialPresented {
                
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                
                SwipeTutorialView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(0)
        .onTapGesture {
            guard !tutorialPresented else { return }
            tutorialPresented.toggle()
        }
    }
}
