import SwiftUI
import MapKit

struct HospitalView: View {
    @StateObject private var viewModel = HospitalViewModel()
    @State private var showCallAlert = false
    
    private let phoneNumber = "081360986278"  // Nomor telepon rumah sakit
    
    var body: some View {
        VStack {
            if viewModel.userLocationReady {
                // Peta dengan marker dan rute
                ZStack {
                    Map(position: $viewModel.cameraPosition) {
                        // Marker rumah sakit
                        Marker("Eka Hospital", systemImage: "plus.square.fill", coordinate: viewModel.hospitalLocation)

                        UserAnnotation()
                        
                        // Garis biru rute
                        if let route = viewModel.route {
                            MapPolyline(route.polyline)
                                .stroke(Color.blue, lineWidth: 5)
                        }
                    }
                    .mapStyle(.standard)
                    .safeAreaInset(edge: .top) {
                        Spacer().frame(height: 40)
                    }
                    .ignoresSafeArea()
                    
                    .mapControls{
                        MapCompass()
                        MapScaleView()
                        MapUserLocationButton()
                    }

                    VStack {
                        Spacer()
                        
                        VStack {
                            Spacer()
                            Button(action: makePhoneCall) {
                                Label("Hubungi Rumah Sakit", systemImage: "phone.fill")
                                    .font(.title2)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                            .padding()
                            .alert("Tidak dapat melakukan panggilan", isPresented: $showCallAlert) {
                                Button("OK", role: .cancel) {}
                            } message: {
                                Text("Perangkat Anda tidak mendukung panggilan telepon atau nomor tidak valid.")
                            }
                        }
                    }
                }
            } else {
                ProgressView("Menunggu Lokasi Pengguna...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
        }
        .onAppear {            
            if viewModel.userLocation.latitude != 0 && viewModel.userLocation.longitude != 0 {
                print("Lokasi Pengguna Tersedia 1")
                viewModel.requestRoute()
            } else {
                print("Lokasi Pengguna Belum Tersedia 1")
            }
        }
    }

    private func makePhoneCall() {
        if let phoneURL = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL)
            showCallAlert = false
        } else {
            showCallAlert = true
        }
    }
}
