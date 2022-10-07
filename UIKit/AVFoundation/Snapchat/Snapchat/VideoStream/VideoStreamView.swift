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

class VideoStreamViewController: UIViewController {
    
    var session: AVCaptureSession?
    
    let output = AVCapturePhotoOutput()
    
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    
    let capturePhotoButton: UIButton = {
        let sideSize = 200
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: sideSize, height: sideSize))
        button.layer.cornerRadius = CGFloat(sideSize / 2)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(capturePhoto), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(capturePhotoButton)
        
        checkCameraPersmissions()
        previewLayer.backgroundColor = UIColor.systemRed.cgColor
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.frame
        
        setConstraints()
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
    
    private func setConstraints() {
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            capturePhotoButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20),
            capturePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
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
//        session?.stopRunning()
        
        //TODO: Remove force unwrapping!
        let controllerToPresent = CapturedPhoto(image: image!)
        controllerToPresent.modalPresentationStyle = .fullScreen
        
        present(controllerToPresent, animated: false)
        
        PHPhotoLibrary.shared().performChanges {
            // Add the captured photo's file data as the main resource for the Photos asset.
            let creationRequest = PHAssetCreationRequest.forAsset()
            creationRequest.addResource(with: .photo, data: data, options: nil)
        }
    }
}

// MARK: Captured Photo Controller
class CapturedPhoto: UIViewController {
    
    var image: UIImage
    
    let presentedPhotoView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let dismissButton: UIButton = {
        var buttonConfig = UIButton.Configuration.plain()
        let button = UIButton()
        buttonConfig.title = "Dismiss"
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(dismissView), for: .touchUpInside)
        
        return button
    }()
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
     
    required init?(coder: NSCoder) {
        fatalError("Oh nooo!!!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentedPhotoView.image = image
        view.addSubview(presentedPhotoView)
        view.addSubview(dismissButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        presentedPhotoView.frame = view.frame
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    @objc func dismissView() {
        self.dismiss(animated: true)
    }
}
