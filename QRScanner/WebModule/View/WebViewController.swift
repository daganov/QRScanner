import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView = WKWebView()
    var progressBar = UIProgressView()
    
    var presenter: WebViewPresenterProtocol!
    weak var delegate: ControlCameraProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupWebView()
        setupProgressBar()
        
        presenter.setUrl()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.startCamera()
    }
    
    // MARK: - Setup controls
    fileprivate func setupNavigation() {
        let buttonDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneButtonAction))
        let buttonShare = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(shareButtonAction))
        buttonShare.isEnabled = false
        
        navigationItem.leftBarButtonItem = buttonDone
        navigationItem.rightBarButtonItem = buttonShare
        
        view.backgroundColor = .systemBackground
    }
    
    fileprivate func setupWebView() {
        view.addSubview(webView)
        webView.navigationDelegate = self
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    fileprivate func setupProgressBar() {
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addSubview(progressBar)
        
        progressBar.progress = 0.1
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: webView.topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: webView.trailingAnchor),
        ])
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            print("Current progress: \(Int(webView.estimatedProgress * 100))%")
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.progressBar.alpha = 0.0
                }, completion: { _ in
                    self.progressBar.setProgress(0.0, animated: false)
                })
            } else {
                progressBar.alpha = 1.0
                progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
            }
        }
    }
}

extension WebViewController {
    @objc func doneButtonAction() {
        dismiss(animated: true)
    }
    
    @objc func shareButtonAction() {
        presenter.showShareSheet()
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}

extension WebViewController: PresentViewProtocol {
    func showPresent(view: UIViewController) {
        self.present(view, animated: true)
    }
}

extension WebViewController: WebViewProtocol {
    func setUrl(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
