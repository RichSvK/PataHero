import SwiftUI

struct CardStep: View {
    let procedure: FractureProcedure
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            if !procedure.imagePath.isEmpty {
                Image(procedure.imagePath)
                    .resizable()
                    .scaledToFit()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                    )
                    .padding(.top, 30)
                    .frame(width: cardWidth, height: cardHeight * 0.8)
            }

            Text(procedure.step)
                .font(.title3)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)

            Spacer()
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(Color.white)
        .cornerRadius(25)
    }
}

#Preview {
    CardStep(procedure: armProcedure[0], cardWidth: UIScreen.main.bounds.width, cardHeight: UIScreen.main.bounds.height * 0.8)
}
