import SwiftUI

struct CardButton<Destination: View>: View {
    let imageName: String
    let title: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: UIScreen.main.bounds.height * 0.15)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1) // Border!
                )
                .overlay(
                    HStack {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.2)
                        
                        Text(title)
                            .font(.system(size: adaptiveFontSize(for: UIScreen.main.bounds.width, baseSize: 20), weight: .bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    .padding()
                )
        }
    }
}

#Preview {
    CardButton(imageName: listFracture[0].imagePath, title: listFracture[0].name, destination: Procedure(fracture: listFracture[0], fractureProcedure: armProcedure))
}
