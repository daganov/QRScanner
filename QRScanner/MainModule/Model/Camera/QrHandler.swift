import AVFoundation

class QrHandler: NSObject {
    
    static let shared = QrHandler()
    var value: String?
    
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
        value = object.stringValue
        print(object.stringValue ?? "")
    }
}
