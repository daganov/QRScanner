import UIKit

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, camera: CameraManager)
    func showVideoFromCamera(frame: CGRect)
}
