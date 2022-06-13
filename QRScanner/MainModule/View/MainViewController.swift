import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    var videoLayer: CALayer?
    
    let viewBackgroundLabel: UIView = {
        let background = UIView()
        background.backgroundColor = .black.withAlphaComponent(0.6)
        background.layer.cornerRadius = 6
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Наведите камеру на QR-код"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
    
    private func setupCamera() {
        presenter.showVideoFromCamera(frame: view.layer.bounds)
    }
}

extension MainViewController: MainViewProtocol {
    func setCamera(video: CALayer) {
        view.layer.addSublayer(video)
        setupLabel()
    }
    
    
}
