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
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.all, 20)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.6)
        .background(.white)
        .cornerRadius(25)
    }
}

#Preview {
    StepCard(procedure: armProcedure[2])
}
