import SwiftUI

struct CardButton<Destination: View>: View {
    let imageName: String
    let title: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.4)
                
                Text(title)
                    .font(.title3)
                    .foregroundColor(Color("ColorText"))
                    .multilineTextAlignment(.center)
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .minimumScaleFactor(0.8)
                    .lineLimit(2)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 200)
            .padding()
            .background(Color("ColorCard"))
            .cornerRadius(8)
        }
    }
}

#Preview {
    CardButton(imageName: listFracture[0].imagePath, title: listFracture[0].name, destination: ProcedureView(fracture: listFracture[0]))
}
