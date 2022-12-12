//
//  ImagePickerView.swift
//  QuickShare2
//
//  Created by Martin Heberling on 11/10/22.
//

import UIKit
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Binding var imageUrl: URL?
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator // confirming the delegate
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        if (info[UIImagePickerController.InfoKey.imageURL] == nil) {
            let timestamp = NSDate().timeIntervalSince1970
            let stimestamp = String(timestamp).replacingOccurrences(of: ".", with: "")
            let jpgData = selectedImage.jpegData(compressionQuality: 1)
            let path = documentDirectoryPath()?.appendingPathComponent("\(stimestamp).jpeg")
            self.picker.imageUrl = path
            do {
                try jpgData!.write(to: path!)
                print("Written!")
            } catch {
                print("Error!")
            }
        } else {
            self.picker.imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL
        }
            
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
    
    func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        return path.first
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
