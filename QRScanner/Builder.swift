import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModelBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let model = CameraManager()
        model.setHandler(QrHandler.shared)
        
        let view = MainViewController()
        let presenter = MainPresenter(view: view, camera: model)
        
        view.presenter = presenter
        
        return view
    }
    
    
}
