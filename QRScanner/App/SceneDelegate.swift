import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let mainVC = ModelBuilder.createMainModule()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }


}

