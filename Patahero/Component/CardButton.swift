import SwiftUI

struct CardButton: View {
    let imageName: String
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 130)
                .frame(height: 130)
            
            Text(title)
                .font(.body)
                .foregroundColor(Color("ColorText"))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .dynamicTypeSize(.medium ... .xxLarge)
                .minimumScaleFactor(0.8)
                .frame(maxHeight: .infinity, alignment: .top)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 160, alignment: .top)
        .padding(20)
        .background(Color("ColorCard"))
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 4)

    }
}

#Preview {
    CardButton(imageName: listFracture[0].imagePath, title: listFracture[0].name)
}
