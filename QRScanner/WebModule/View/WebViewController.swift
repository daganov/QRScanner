import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    var presenter: WebViewPresenterProtocol!
    weak var delegate: ControlCameraProtocol?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()

        presenter.setUrl()
    }
    
    override func viewDidLayoutSubviews() {
        webView.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.startCamera()
    }
    
    func setupNavigation() {
        let buttonDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneButtonAction))
        let buttonShare = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: nil)

        navigationItem.leftBarButtonItem = buttonDone
        navigationItem.rightBarButtonItem = buttonShare
    }
    
}

extension WebViewController {
    @objc func doneButtonAction(button: UIBarButtonItem) {
        dismiss(animated: true)        
    }
}

extension WebViewController: WebViewProtocol {
    func setUrl(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
