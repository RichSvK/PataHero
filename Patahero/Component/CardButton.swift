import SwiftUI

struct CardButton: View {
    let imageName: String
    let title: String
    
    var body: some View {
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

#Preview {
    CardButton(imageName: listFracture[0].imagePath, title: listFracture[0].name)
}
