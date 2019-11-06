//
//  ViewController.swift
//  CustomCamera
//
//  Created by Ronald Arias on 11/5/19.
//  Copyright © 2019 Ronald Arias. All rights reserved.
//

import UIKit

//1. importamos AVFoundation
import AVFoundation

class ViewController: UIViewController {
    
    //2. creamos las variables y constantes para usar en la camara
    let captureSession = AVCaptureSession()
    var previewLayer: CALayer!
    var captureDevice: AVCaptureDevice!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //3. llamamos a la funcion prepareCamera()
        prepareCamera()
    }
    
    
    func prepareCamera() {
        
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
        captureDevice = availableDevices.first
        
        //4. llamamos a la funcion beginSession()
        beginSession()
    }
    
    func beginSession() {
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession.addInput(captureDeviceInput)
            
        } catch {
            print(error.localizedDescription)
        }
        
        
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer = previewLayer
        self.view.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.view.layer.frame
        captureSession.startRunning()
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [((kCVPixelBufferPixelFormatTypeKey as NSString) as String):NSNumber(value:kCVPixelFormatType_32BGRA)]
        
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        
        captureSession.commitConfiguration()
        
        
        let queue = DispatchQueue(label: "com.brianadvent.captureQueue")
        dataOutput.setSampleBufferDelegate((self as! AVCaptureVideoDataOutputSampleBufferDelegate), queue: queue)
    }
}

