import UIKit

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let camera: CameraManager
    
    required init(view: MainViewProtocol, camera: CameraManager) {
        self.view = view
        self.camera = camera
    }
    
    func showVideoFromCamera(frame: CGRect) {
        camera.video.frame = frame
        view?.setCamera(video: camera.video)
    }
    
    func startCamera() {
        camera.session.startRunning()
    }
    
    func cameraState() -> Bool {
        camera.statusCamera == .ready
    }
}

extension MainPresenter: UpdateValueProtocol {
    func updateValue(value: String) {
        self.camera.session.stopRunning()
        if let url = URL(string: value) {
            view?.showSuccessfulScan(url: url)
        }
    }
}
