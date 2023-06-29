//
//  ImagePickerViewCoordinator.swift
//  AWorldAction
//
//  Created by Andrea Sala on 29/06/23.
//

import Foundation
import SwiftUI

public class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    init(image: Binding<UIImage?>, isPresented: Binding<Bool>) {
        self._image = image
        self._isPresented = isPresented
    }
    
    func compressImage(_ image: UIImage, maxSizeInBytes: Int) -> Data? {
        var compression: CGFloat = 1.0
        var imageData = image.jpegData(compressionQuality: compression)
        
        while let data = imageData, data.count > maxSizeInBytes && compression > 0 {
            compression -= 0.1
            imageData = image.jpegData(compressionQuality: compression)
        }
        
        return imageData
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let compressedImage = compressImage(image, maxSizeInBytes: 2 * 1024 * 1024) {
                self.image = UIImage(data: compressedImage)
            }
        }
            
        self.isPresented = false
    }
        
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
}
