import AVFoundation

class CameraManager {
    
    enum Status {
        case ready
        case notready
    }
    
    var statusCamera = Status.notready
    
    let session = AVCaptureSession()
    let videoOutput = AVCaptureMetadataOutput()
    var video = AVCaptureVideoPreviewLayer()
    
    private let sessionQueue = DispatchQueue(label: "qrscanner.session")
    weak var delegate: ControlCameraProtocol?
    
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
            statusCamera = .notready
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if session.canAddInput(input) {
                session.addInput(input)
            } else {
                print("Cannot add input")
                statusCamera = .notready
                return
            }
        } catch {
            print(error.localizedDescription)
            statusCamera = .notready
            return
        }
        
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
            videoOutput.metadataObjectTypes = [.qr]
        }
        
        video = AVCaptureVideoPreviewLayer(session: session)
    }
    
    private func configureCamera() {
        configureSession()
        session.startRunning()
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [unowned self] authorized in
                self.statusCamera = authorized ? .ready : .notready
                self.delegate?.showCameraStatus()
            }
        case .authorized:
            statusCamera = .ready
        default:
            statusCamera = .notready
            return
        }
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
