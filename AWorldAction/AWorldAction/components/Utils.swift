//
//  Utils.swift
//  AWorldAction
//
//  Created by Andrea Sala on 29/06/23.
//

import Foundation
import SwiftUI

class Utils {
    static func compressImage(_ image: UIImage, maxSizeInBytes: Int) -> Data? {
        var compression: CGFloat = 1.0
        var imageData = image.jpegData(compressionQuality: compression)
        
        while let data = imageData, data.count > maxSizeInBytes && compression > 0 {
            compression -= 0.1
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
