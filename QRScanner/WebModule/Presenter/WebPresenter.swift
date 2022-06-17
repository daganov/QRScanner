import Foundation

class WebPresenter: WebViewPresenterProtocol {
    weak var view: WebViewProtocol?
    var url: URL
    let share: ShareManager

    required init(view: WebViewProtocol, url: URL, share: ShareManager) {
        self.view = view
        self.url = url
        self.share = share
    }
    
    public func setUrl() {
        self.view?.setUrl(url: url)
    }
    
    func showShareSheet() {
        self.share.showShare(url: url)
    }
}
