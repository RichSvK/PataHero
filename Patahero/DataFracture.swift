import SwiftUI
import Foundation

// Model
struct DataFracture: Identifiable {
    var id: Int
    var name: String
    var imagePath: String
    var description: String
}

struct FractureProcedure: Identifiable {
    var id: UUID = UUID()
    var step: String
    var imagePath: String
}

// Data
let listFracture = [
    DataFracture(id: 1, name: "Patah Tulang Lengan", imagePath: "lengan", description: "Sebuah deskripsi patah tulang lengan"),
    DataFracture(id: 2, name: "Patah Tulang Jari", imagePath: "jari", description: "Sebuah deskripsi patah tulang jari"),
    DataFracture(id: 3, name: "Patah Tulang Pergelangan Tangan", imagePath: "pergelangan", description: "Sebuah deskripsi patah tulang pergelangna tangan"),
]

let armProcedure = [
    FractureProcedure(step: "Lilitkan perban untuk membalut lengan sebagai penyangga awal", imagePath: "lengan-step1"),
    FractureProcedure(step: "Gunakan kain segitiga untuk menopang lengan ke dada", imagePath: "lengan-step2"),
    FractureProcedure(step: "Periksa secara berkala bila ada pembengkakan lain, kesemutan, atau pucat", imagePath: "lengan-step3"),
    FractureProcedure(step: "Hubungi kontak darurat Eka Hospital", imagePath: "lengan-step4"),
]

let fingerProcedure = [
    FractureProcedure(step: "Balut jari yang patah dengan jari sebelahnya sebagai penyangga", imagePath: "jari-step1"),
    FractureProcedure(step: "Kompres es yang terbungkus dengan kain untuk mengurangi bengkak", imagePath: "jari-step2"),
    FractureProcedure(step: "Periksa secara berkala bila ada pembengkakan lain, kesemutan, atau pucat", imagePath: "jari-step3"),
    FractureProcedure(step: "Hubungi kontak darurat Eka Hospital", imagePath: "jari-step4"),
]

let wristProcedure = [
    FractureProcedure(step: "Gunakan kain atau perban untuk menopang pergelangan tangan", imagePath: "pergelangan-step1"),
    FractureProcedure(step: "Kompres es yang terbungkus dengan kain untuk mengurangi bengkak", imagePath: "pergelangan-step2"),
    FractureProcedure(step: "Periksa secara berkala bila ada pembengkakan lain, kesemutan, atau pucat", imagePath: "pergelangan-step3"),
    FractureProcedure(step: "Hubungi kontak darurat Eka Hospital", imagePath: "pergelangan-step4"),
]
