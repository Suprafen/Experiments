//
//  VideoStreamView.swift
//  Snapchat
//
//  Created by Ivan Pryhara on 5.10.22.
//

import Foundation
import UIKit
import AVFoundation
import Photos

// MARK: Important goals at this moment.
// TODO: Make it's possible to scroll through all photos you've done in the app. On camera view or on main one. (You can use either scroll view with horizontal alignement or collection view)


// MARK: Long term goals
// TODO: Make custom image picker.
// TODO: Make live camera stream a part of collection view with images from your custom picker.


class VideoStreamViewController: UIViewController, CapturedPhotoDelegate {
    
    var session: AVCaptureSession?
    
    let output = AVCapturePhotoOutput()
    
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    
    let capturePhotoButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.layer.cornerRadius =  button.frame.width/2
        button.backgroundColor = .white
        
        button.addTarget(nil, action: #selector(capturePhoto), for: .touchUpInside)
        
        return button
    }()
    
    let capturePhotoButtonBorder: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        view.layer.cornerRadius = view.frame.width/2
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.white.cgColor
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(capturePhotoButtonBorder)
        view.addSubview(capturePhotoButton)
        
        checkCameraPersmissions()
        checkPHPhotoLibraryPermissions()
        previewLayer.backgroundColor = UIColor.systemRed.cgColor
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        
        capturePhotoButtonBorder.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 100)
        capturePhotoButton.center = capturePhotoButtonBorder.center
    }
    
    private func checkPHPhotoLibraryPermissions() {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .authorized:
            print()
            // do saving
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                guard status == .authorized else { return }
                
            }
            
        case .restricted:
            break
            
        case .denied:
            break
            
        case .limited:
            break
            
        @unknown default:
            break
        }
    }
    
    private func checkCameraPersmissions() {
        //MARK: Switch through authirization status
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        // The user has previously granted access to the camera.
        case .authorized:
            
            setupCamera()
            
        // The user has not yet been asked for camera access.
        case .notDetermined:
            //MARK: Request an access from the user.
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else { return }
                
                DispatchQueue.main.async {
                    self?.setupCamera()
                }
            }
        // The user can't grant access due to restrictions.
        case .restricted:
            
            break
        // The user has previously denied access.
        case .denied:
            
            break
        // Just for shutting the swift error that switch is not exhaustive.
        @unknown default:
            
            break
            
        }
    }
    
    func setupCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                session.startRunning()
                self.session = session
                
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func getPhoto(_ image: UIImage) {
        session?.startRunning()
    }
}
//MARK: Selectors
extension VideoStreamViewController {
    @objc func capturePhoto() {
        output.capturePhoto(with: AVCapturePhotoSettings(),
                            delegate: self)
    }
}

// MARK: AVCapturePhotoCaptureDelegate
extension VideoStreamViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else { return }
        
        let image = UIImage(data: data)
        
        // How to come up with this to stop the session while user decides about the photo.
        // But continue the session when they dismissed the view that contains the photo itself.
        session?.stopRunning()
        
        //TODO: Remove force unwrapping!
        let controllerToPresent = CapturedPhotoController(image: image!)
        controllerToPresent.delegate = self
        controllerToPresent.modalPresentationStyle = .fullScreen
        
        present(controllerToPresent, animated: false)
        
        PHPhotoLibrary.shared().performChanges {
            // Add the captured photo's file data as the main resource for the Photos asset.
            let creationRequest = PHAssetCreationRequest.forAsset()
            creationRequest.addResource(with: .photo, data: data, options: nil)
        }
    }
}
