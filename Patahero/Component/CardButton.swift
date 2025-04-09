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
                            .font(.title3)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .dynamicTypeSize(.medium ... .xxLarge)
                            .minimumScaleFactor(0.8)
                            .lineLimit(2)
                        
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
