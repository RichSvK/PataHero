import SwiftUI
import MapKit
import CoreLocation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager?

    var userLocation: CLLocationCoordinate2D?
    var region: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    override init() {
        super.init()
        checkLocationServicesEnabled()
    }

    func checkLocationServicesEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        } else {
            print("Berikan ijin akses lokasi pada Settings")
        }
    }

    private func checkLocationAuthorizationStatus() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {
            // Meminta ijin akses lokasi
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                
            // User sudah memberikan ijin
            case .authorizedAlways, .authorizedWhenInUse:
                if let coordinate = locationManager.location?.coordinate {
                    updateRegion(to: coordinate)
                }
                locationManager.startUpdatingLocation()

            // Permintaan ijin akses ditolak
            case .restricted, .denied:
                print("Akses lokasi ditolak")

            @unknown default:
                break
        }
    }
    
    private func updateRegion(to coordinate: CLLocationCoordinate2D) {
        self.userLocation = coordinate
        self.region = .region(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )
    }


    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            self.userLocation = coordinate
            region = .region(
                MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            )
        }
    }
}

struct MapView: View {
    @State private var locationManager = LocationManager()
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var route: MKRoute?
    
    let hospitalLocation = CLLocationCoordinate2D(latitude: -6.298920889533608, longitude: 106.66991187639381)

    var body: some View {
        Map(position: $locationManager.region) {
            
            // Marker rumah sakit
            Marker("Eka Hospital", systemImage: "plus.square.fill", coordinate: hospitalLocation)
            
            // Tampilkan lokasi pengguna
            UserAnnotation()
            
        }
        .onAppear {
            locationManager.checkLocationServicesEnabled()
        }
        .mapStyle(.standard)
        .ignoresSafeArea()
    }
    
    func requestRoute() {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: locationManager.userLocation!))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: hospitalLocation))
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let route = response?.routes.first {
                self.route = route
                
                // Atur posisi kamera ke langkah pertama dalam rute
                if let firstStep = route.steps.first {
                    self.cameraPosition = .region(
                        MKCoordinateRegion(
                            center: firstStep.polyline.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        )
                    )
                } else {
                    // Fallback: Difokuskan ke lokasi rumah sakit
                    self.cameraPosition = .region(
                        MKCoordinateRegion(
                            center: hospitalLocation,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        )
                    )
                }
            } else if let error = error {
                print("Gagal menghitung rute: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    MapView()
}
