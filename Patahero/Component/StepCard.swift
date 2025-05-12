import SwiftUI

struct StepCard: View {
    let procedure: FractureProcedure
    
    var body: some View {
        VStack(spacing: 0) {
            Image(procedure.imagePath)
                .resizable()
                .scaledToFit()
                .cornerRadius(25)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.8, maxHeight: UIScreen.main.bounds.height * 0.5)
                .padding(.all, 20)
                        
            Text(procedure.step)
                .font(.title2)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.all, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.6)
        .background(Color("ColorCard"))
        .cornerRadius(25)
    }
}

#Preview {
    StepCard(procedure: armProcedure[2])
}
