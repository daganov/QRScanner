import Foundation

protocol WebViewPresenterProtocol: AnyObject {
    init(view: WebViewProtocol, url: URL, share: ShareManager)
    func setUrl()
    func showShareSheet()
}
