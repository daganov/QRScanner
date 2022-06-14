import AVFoundation

class CameraManager {
    
    let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "qrscanner.session")
    
    let videoOutput = AVCaptureMetadataOutput()
    
    var video = AVCaptureVideoPreviewLayer()
    
    init() {
        configureCamera()
    }
    
    private func configureSession() {
        session.beginConfiguration()
        
        defer {
            session.commitConfiguration()
        }
        
        let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        guard let captureDevice = captureDevice else {
            print("No camera")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if session.canAddInput(input) {
                session.addInput(input)
            } else {
                fatalError("Cannot add input")
            }
        } catch {
            fatalError(error.localizedDescription)
        }
        
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
            videoOutput.metadataObjectTypes = [.qr]
        }
        
        video = AVCaptureVideoPreviewLayer(session: session)
    }
    
    private func configureCamera() {
        // 1. Проверить права доступа
        // 2. Сконфигурировать камеру
        //        sessionQueue.async {
        self.configureSession()
        self.session.startRunning()
        //        }
    }
    
    func setHandler(_ delegate: AVCaptureMetadataOutputObjectsDelegate) {
        let queue = DispatchQueue(label: "qrscanner.videooutput",
                                  qos: .userInitiated,
                                  attributes: [],
                                  autoreleaseFrequency: .workItem)
        sessionQueue.async {
            self.videoOutput.setMetadataObjectsDelegate(delegate, queue: queue)
        }
    }
}
