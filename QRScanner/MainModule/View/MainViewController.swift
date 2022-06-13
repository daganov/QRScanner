import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    let viewBackgroundLabel = UIView().createBackground()
    let label = UILabel().createLabel(text: "Наведите камеру на QR-код")
    let viewBackgroundAlert = UIView().createBackground()
    let imageAlert = UIImageView().createImage(with: "checkmark.circle")

    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupCamera()
    }
    
    private func setupLabel() {
        viewBackgroundLabel.addSubview(label)
        view.addSubview(viewBackgroundLabel)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: viewBackgroundLabel.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: viewBackgroundLabel.centerYAnchor),
            
            viewBackgroundLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            viewBackgroundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewBackgroundLabel.heightAnchor.constraint(equalTo: label.heightAnchor, constant: 10),
            viewBackgroundLabel.widthAnchor.constraint(equalTo: label.widthAnchor, constant: 20)
        ])
    }
    
    private func setupAlert() {
        viewBackgroundAlert.addSubview(imageAlert)
        view.addSubview(viewBackgroundAlert)

        NSLayoutConstraint.activate([
            imageAlert.centerXAnchor.constraint(equalTo: viewBackgroundAlert.centerXAnchor),
            imageAlert.centerYAnchor.constraint(equalTo: viewBackgroundAlert.centerYAnchor),

            viewBackgroundAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewBackgroundAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewBackgroundAlert.heightAnchor.constraint(equalTo: imageAlert.heightAnchor, constant: 40),
            viewBackgroundAlert.widthAnchor.constraint(equalTo: imageAlert.widthAnchor, constant: 40)
        ])
    }
        
    private func setupCamera() {
        presenter.showVideoFromCamera(frame: view.layer.bounds)
    }
}

extension MainViewController: MainViewProtocol {
    func showSuccessfulScan(url: URL) {
        DispatchQueue.main.async {
            self.viewBackgroundLabel.isHidden = true
            
            self.view.addSubview(UIView().createBlurView(frame: self.view.bounds))

            self.setupAlert()
        }
    }
    
    func setCamera(video: CALayer) {
        view.layer.addSublayer(video)
        setupLabel()
    }
    
    
}
