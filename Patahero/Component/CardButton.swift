import SwiftUI

struct CardButton: View {
    let imageName: String
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 130)
            
            Text(title)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color("ColorText"))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.7)
                .frame(maxWidth: .infinity, alignment: .top)
            
            Spacer()
        }
        .frame(height: 180)
        .padding(20)
        .background(Color("ColorCard"))
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 4)
    }
}

#Preview {
    CardButton(imageName: listFracture[0].imagePath, title: listFracture[0].name)
}
