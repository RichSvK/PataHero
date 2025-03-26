import SwiftUI

struct CardButton<Destination: View>: View {
    let imageName: String
    let title: String
    let destination: Destination
    let geo: GeometryProxy
    
    var body: some View {
        NavigationLink(destination: destination) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: geo.size.height * 0.15)
                .overlay(
                    HStack {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.2)
                        
                        Text(title)
                            .font(.system(size: adaptiveFontSize(for: geo.size.width, baseSize: 20), weight: .bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    .padding()
                )
        }
    }
}
