import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    var presenter: WebViewPresenterProtocol!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setUrl()
    }
}

extension WebViewController: WebViewProtocol {
    func setUrl(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    
}
