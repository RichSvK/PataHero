import SwiftUI

struct PataheroLogo: View{
    let geo: GeometryProxy
    
    var body: some View{
        HStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width * 0.25)

            HStack(spacing: 0) {
                Text("PATA")
                    .font(.custom("Optima-ExtraBlack", size: adaptiveFontSize(for: geo.size.width, baseSize: 35)))
                    .foregroundColor(Color(hex: "#fcc697"))

                Text("HERO")
                    .font(.custom("Optima-ExtraBlack", size: adaptiveFontSize(for: geo.size.width, baseSize: 35)))
                    .foregroundColor(Color(red: 241 / 255, green: 76 / 255, blue: 66 / 255))
            }
            Spacer()
        }
        .padding(.horizontal, min(20, geo.size.width * 0.05))
        .background(Color("colorBackground"))
        .overlay(
            Rectangle()
                .frame(height: 1)
                .opacity(0.3)
                .shadow(color: Color.black.opacity(1), radius: 5, x: 0, y: 5)
            , alignment: .bottom
        )
    }
}
