import AVFoundation

class QrHandler: NSObject {
    
    static let shared = QrHandler()
    var delegate: UpdateValueProtocol?
}

extension QrHandler: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard
            !metadataObjects.isEmpty,
            let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
            object.type == AVMetadataObject.ObjectType.qr
        else {
            return
        }
        guard let value = object.stringValue else { return }
        delegate?.updateValue(value: value)
        print(value)
    }
}
