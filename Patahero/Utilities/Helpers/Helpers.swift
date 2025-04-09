import SwiftUI

// Fungsi untuk ukuran teks responsif
func adaptiveFontSize(for width: CGFloat, baseSize: CGFloat) -> CGFloat {
    return max(baseSize * (width / 390), baseSize * 0.8)
}
