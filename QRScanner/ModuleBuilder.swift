import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createWebModule(url: URL) -> UIViewController
}

class ModelBuilder: Builder {
    
    static func createMainModule() -> UIViewController {
        let model = CameraManager()
        model.setHandler(QrHandler.shared)
        
        let view = MainViewController()
        let presenter = MainPresenter(view: view, camera: model)

        QrHandler.shared.delegate = presenter
        view.presenter = presenter
        
        return view
    }
    
    static func createWebModule(url: URL) -> UIViewController {
        let view = WebViewController()
        let presenter = WebPresenter(view: view, url: url)
        view.presenter = presenter
        return view
    }

}