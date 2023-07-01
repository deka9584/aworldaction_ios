//
//  Utils.swift
//  AWorldAction
//
//  Created by Andrea Sala on 29/06/23.
//

import Foundation
import SwiftUI

class Utils {
    static func compressImage(_ image: UIImage, maxSizeInMB: CGFloat) -> Data? {
        let maxFileSize = Int(maxSizeInMB * 1024 * 1024) // Converti la dimensione massima in byte
        var compression: CGFloat = 1.0 // Inizia con la massima qualità
        var imageData = image.jpegData(compressionQuality: compression)

        while (imageData?.count ?? 0) > maxFileSize && compression > 0.1 {
            compression -= 0.1 // Riduci la qualità del 10% ad ogni iterazione
            imageData = image.jpegData(compressionQuality: compression)
        }

        return imageData
    }
    
    static func openMaps(lat: Double, lng: Double) {
        let urlString = "http://maps.apple.com/?ll=\(lat),\(lng)"
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}
