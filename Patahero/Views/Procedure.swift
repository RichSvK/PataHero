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
            HStack{
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
                        .font(.system(size: 20, weight: .bold))
                }
                .padding(.horizontal, 20)
            }
            .frame(height: 70)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .opacity(0.3)
                    .shadow(color: Color.black.opacity(1), radius: 5, x: 0, y: 5)
                , alignment: .bottom
            )

            // Progress Bar
            MultiStepProgressBar(numberOfSteps: totalStep, currentStep: $currentStep)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
            
            // Swipeable Steps
            TabView(selection: $currentStep) {
                ForEach(1...totalStep, id: \.self) { step in
                    VStack {
                        Image(fractureProcedure[step - 1].imagePath)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
                            .padding(.vertical, 10)
                            .background(Color("colorBackground"))
                        
                        VStack(alignment: .leading) {
                            Text(fractureProcedure[step - 1].step)
                        }
                        .font(.system(size: 20, weight: .regular))
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .foregroundColor(.black)
                        
                        Spacer()
                        
                        if currentStep == totalStep {
                            CallButton()
                        }
                    }
                    .padding(.vertical, 10)
                    .background(.white)
                    .tag(step)
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EmptyView()
            }
        }
        .background(Color(.white))
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    Procedure(fracture: listFracture[0], fractureProcedure: armProcedure)
}
