import Foundation

protocol WebViewProtocol: AnyObject {
    func setUrl(url: URL)
}

protocol WebViewPresenterProtocol: AnyObject {
    init(view: WebViewProtocol, url: URL)
    func setUrl()
}

class WebPresenter: WebViewPresenterProtocol {
    weak var view: WebViewProtocol?
    var url: URL

    required init(view: WebViewProtocol, url: URL) {
        self.view = view
        self.url = url
    }
    
    public func setUrl() {
        self.view?.setUrl(url: url)
    }
}
