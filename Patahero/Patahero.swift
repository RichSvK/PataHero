import SwiftUI
import SwiftData

@main
struct Patahero: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Fracture.self, FractureProcedure.self])
    }
}
