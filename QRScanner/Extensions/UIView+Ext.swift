import UIKit

extension UIView {
    func createBackground() -> UIView {
        let background = UIView()
        background.backgroundColor = .black.withAlphaComponent(0.6)
        background.layer.cornerRadius = 8
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }
    
    func createBlurView(frame: CGRect) -> UIView {
        let blur = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurView
    }
}
