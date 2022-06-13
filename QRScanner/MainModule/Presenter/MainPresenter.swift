import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
    func setCamera(video: CALayer)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, camera: CameraManager)
    func showVideoFromCamera(frame: CGRect)
}

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
