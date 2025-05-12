import SwiftUI

struct SwipeTutorialView: View {
    @State private var offsetX: CGFloat = 30
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "hand.draw.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                .scaleEffect(x: -1, y: 1)
                .offset(x: offsetX)
                .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true), value: offsetX)

            Text("Geser untuk berpindah langkah prosedur.")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)

            Text("Klik layar untuk menutup tutorial.")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding()
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(20)
        .onAppear {
            startAnimation()
        }
        
    }
    
    // Fungsi untuk memulai animasi
    private func startAnimation() {
        withAnimation {
            offsetX = -30
        }
    }
}

#Preview {
    SwipeTutorialView()
}
