import SwiftUI
import SwiftData

struct ProcedureView: View {
    @StateObject var viewModel: ProcedureViewModel
    @Environment(\.dismiss) var dismiss

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
        .onDisappear{
            viewModel.setSwipeTutorial()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {

                Button(action: {
                    if viewModel.hasSeenSwipeTutorial {
                        dismiss()
                    }
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Prosedur")
                    }
                    .foregroundColor(viewModel.hasSeenSwipeTutorial ? Color(red: 8 / 255, green: 110 / 255, blue: 221 / 255) : Color(red: 30 / 255, green: 78 / 255, blue: 134 / 255))
                }

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(0)
        .onTapGesture {
            viewModel.setSwipeTutorial()
        }
    }
}
