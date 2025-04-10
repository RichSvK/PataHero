import SwiftUI

struct CardStep: View {
    let procedure: FractureProcedure
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            Image(procedure.imagePath)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(25)
                .frame(width: cardWidth)
                .padding(.all, 20)
            
            Spacer()
            
            Text(procedure.step)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .padding(.all, 20)
                .frame(maxWidth: .infinity, alignment: .center)

        }
        .frame(width: cardWidth, height: cardHeight)
        .background(.white)
        .cornerRadius(25)
    }
}

#Preview {
    CardStep(procedure: armProcedure[0], cardWidth: UIScreen.main.bounds.width, cardHeight: UIScreen.main.bounds.height * 0.8)
}
