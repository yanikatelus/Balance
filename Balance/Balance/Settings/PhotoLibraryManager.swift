//
//  PhotoLibraryManager.swift
//  Balance
//
//  Created by Yanika Telus on 11/21/23.
//
//Using corelocationexample as reference
import Foundation
import Photos
import SwiftUI

class PhotoLibraryManager: NSObject, ObservableObject {
    @Published var permissionStatus: PHAuthorizationStatus = .notDetermined
    @Published var permissionError = false

    override init() {
        super.init()
        checkPhotoLibraryPermission()
    }

    func checkPhotoLibraryPermission() {
        permissionStatus = PHPhotoLibrary.authorizationStatus()
        if permissionStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    self.permissionStatus = status
                    self.permissionError = (status == .denied || status == .restricted)
                }
            }
        } else {
            permissionError = (permissionStatus == .denied || permissionStatus == .restricted)
        }
    }
}// PhotoLibraryManager
