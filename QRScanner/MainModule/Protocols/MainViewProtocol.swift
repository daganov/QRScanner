import UIKit

protocol MainViewProtocol: AnyObject {
    func setCamera(video: CALayer)
    func showSuccessfulScan(url: URL)
}
