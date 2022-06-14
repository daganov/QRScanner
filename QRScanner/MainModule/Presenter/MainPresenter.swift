import Foundation
import UIKit

class MainPresenter: MainViewPresenterProtocol {
    let view: MainViewProtocol
    let camera: CameraManager
    
    required init(view: MainViewProtocol, camera: CameraManager) {
        self.view = view
        self.camera = camera
    }
    
    func showVideoFromCamera(frame: CGRect) {
        camera.video.frame = frame
        view.setCamera(video: camera.video)
    }
    
}

extension MainPresenter: UpdateValueProtocol {
    func updateValue(value: String) {
        self.camera.session.stopRunning()
        if let url = URL(string: value) {
            view.showSuccessfulScan(url: url)
        }
    }
}
