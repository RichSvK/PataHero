import SwiftUI
import MapKit
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published private var locationManager: CLLocationManager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    private var hasSetInitialRegion = false
    
    override init() {
        super.init()
        print("Initialize LocationManager")
        start()
    }
    
    func start() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Cek status otorisasi sebelum meminta izin
        let authStatus = locationManager.authorizationStatus
        switch authStatus {
            case .notDetermined:
                print("Meminta izin lokasi...")
                locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                print("Lokasi diizinkan, memulai pembaruan lokasi")
                locationManager.startUpdatingLocation()
            case .restricted, .denied:
                print("Akses lokasi ditolak")
            default:
                print("Status otorisasi tidak diketahui")
        }
    }
    
    func stop(){
        locationManager.stopUpdatingLocation()
        print("Pembaruan lokasi dihentikan")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                print("Izin diberikan, memulai pembaruan lokasi")
                manager.startUpdatingLocation()
            case .restricted, .denied:
                print("Akses lokasi ditolak")
            case .notDetermined:
                print("Izin belum ditentukan")
            @unknown default:
                break
        }
    }

    private func updateRegion(to coordinate: CLLocationCoordinate2D) {
        DispatchQueue.main.async {
            self.userLocation = coordinate
            self.region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else { return }
        self.userLocation = coordinate
        
        if !hasSetInitialRegion {
            updateRegion(to: coordinate)
            hasSetInitialRegion = true
        }
        print("Lokasi pengguna diperbarui: \(coordinate.latitude), \(coordinate.longitude)")
    }
}
