import UIKit

protocol ControlCameraProtocol: AnyObject {
    func startCamera()
    func showCameraStatus()
}

class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    let viewBackgroundLabel = UIView().createBackground()
    let label = UILabel().createLabel(text: "")
    let viewBackgroundAlert = UIView().createBackground()
    let imageAlert = UIImageView().createImage(with: "checkmark.circle")
    let blurView = UIView().createBlurView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
        setupLabel()
        setupAlert()
        
        toggleStateView(isCameraOn: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showCameraStatus()
    }
    override func viewDidLayoutSubviews() {
        blurView.frame = view.bounds
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
        view.addSubview(blurView)
        view.addSubview(viewBackgroundAlert)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            imageAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            viewBackgroundAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewBackgroundAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewBackgroundAlert.heightAnchor.constraint(equalTo: imageAlert.heightAnchor, constant: 40),
            viewBackgroundAlert.widthAnchor.constraint(equalTo: imageAlert.widthAnchor, constant: 40)
        ])
    }
    
    private func setupCamera() {
        presenter.showVideoFromCamera(frame: view.layer.bounds)
    }
    
    func toggleStateView(isCameraOn: Bool) {
        blurView.isHidden = isCameraOn
        viewBackgroundAlert.isHidden = isCameraOn
        viewBackgroundLabel.isHidden = !isCameraOn
    }
}

extension MainViewController: MainViewProtocol {
    func showSuccessfulScan(url: URL) {
        DispatchQueue.main.async { [unowned self] in
            toggleStateView(isCameraOn: false)
            
            guard let webViewController = ModelBuilder.createWebModule(url: url) as? WebViewController else { return }
            let navigationController = UINavigationController(rootViewController: webViewController)
            webViewController.delegate = self
            
            self.present(navigationController, animated: true)
        }
    }
    
    func setCamera(video: CALayer) {
        view.layer.addSublayer(video)
    }
}

extension MainViewController: ControlCameraProtocol {
    func startCamera() {
        toggleStateView(isCameraOn: true)
        self.presenter.startCamera()
    }
    
    func showCameraStatus() {
        DispatchQueue.main.async { [unowned self] in
            self.label.text = self.presenter.cameraState() ? "Наведите камеру на QR-код" : "Нет доступа к камере"
        }
    }
}
