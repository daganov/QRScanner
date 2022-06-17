import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createWebModule(url: URL) -> UIViewController
}

class ModelBuilder: Builder {
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()

        let model = CameraManager()
        model.delegate = view
        model.setHandler(QrHandler.shared)
        
        let presenter = MainPresenter(view: view, camera: model)

        QrHandler.shared.delegate = presenter
        view.presenter = presenter
        
        return view
    }
    
    static func createWebModule(url: URL) -> UIViewController {
        let view = WebViewController()
        
        let model = ShareManager()
        model.delegate = view
        
        let presenter = WebPresenter(view: view, url: url, share: model)
        view.presenter = presenter
        return view
    }

}
