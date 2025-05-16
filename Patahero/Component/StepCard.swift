import SwiftUI

struct StepCard: View {
    let procedure: FractureProcedure
    
    var body: some View {
        VStack(spacing: 0) {
            Image(procedure.imagePath)
                .resizable()
                .scaledToFit()
                .cornerRadius(25)
                .frame(height: 300)
                .padding(.vertical, 20)
            
            Text("Step \(procedure.order)")
                .font(.system(size: 20, weight: .semibold))
                .multilineTextAlignment(.center)
                
            Text(procedure.step)
                .font(.system(size: 16, weight: .regular))
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            Spacer()
        }
        .padding(.horizontal, 25)
        .frame(maxWidth: .infinity, maxHeight: 440)
        .background(Color("ColorCard"))
        .cornerRadius(25)
    }
}

#Preview {
    StepCard(procedure: ankleProcedure[0])
}
