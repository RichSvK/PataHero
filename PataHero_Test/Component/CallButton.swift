import SwiftUI

struct CallButton: View{
    let geo: GeometryProxy
    
    var body: some View {
        Button(action: {
            if let phoneURL = URL(string: "tel://08998106352") {
                UIApplication.shared.open(phoneURL)
            }
        }) {
            HStack {
                Image(systemName: "phone.fill")
                    .font(.system(size: adaptiveFontSize(for: geo.size.width, baseSize: 25)))
                
                Text("Call Eka Hospital")
                    .fontWeight(.semibold)
                    .font(.system(size: adaptiveFontSize(for: geo.size.width, baseSize: 25)))
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color(red: 241 / 255, green: 76 / 255, blue: 66 / 255))
        .cornerRadius(40)
        .padding(.horizontal, min(20, geo.size.width * 0.05))
        .shadow(radius: 20)
        .padding(.top)
    }
}
