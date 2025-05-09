import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State private var locationManager = LocationManager()
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var route: MKRoute?
    
    let hospitalLocation = CLLocationCoordinate2D(latitude: -6.298920889533608, longitude: 106.66991187639381)

    var body: some View {
        Map(position: $locationManager.region) {
            
            // Marker rumah sakit
            Marker("Eka Hospital", systemImage: "plus.square.fill", coordinate: hospitalLocation)
            
            UserAnnotation()
            
            if let route = route {
                MapPolyline(route.polyline)
                    .stroke(.blue, lineWidth: 5)
            }
            
        }
        .onAppear {
            locationManager.start()
        }
        .mapStyle(.standard)
        .ignoresSafeArea()
    }
    
    func requestRoute() {
        guard let userCoordinate = locationManager.userLocation,
              userCoordinate.latitude != 0,
              userCoordinate.longitude != 0 else {
            print("Lokasi pengguna belum tersedia atau tidak valid")
            return
        }

        print("Menghitung rute dari \(userCoordinate) ke \(hospitalLocation)")

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: hospitalLocation))
        request.transportType = .automobile

        let directions = MKDirections(request: request)

        directions.calculate { response, error in
            if let route = response?.routes.first {
                self.route = route
                print("Rute ditemukan. Jarak: \(route.distance) meter")

                if let firstStep = route.steps.first {
                    self.cameraPosition = .region(
                        MKCoordinateRegion(
                            center: firstStep.polyline.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        )
                    )
                }
            } else if let error = error {
                print("Gagal menghitung rute: \(error.localizedDescription)")
            } else {
                print("Tidak ada rute ditemukan dan tidak ada error")
            }
        }
    }

}

#Preview {
    MapView()
}
