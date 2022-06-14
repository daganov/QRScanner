import UIKit

extension UIImageView {
    func createImage(with name: String) -> UIImageView {
        let configuration = UIImage.SymbolConfiguration(pointSize: 48, weight: .thin)
        let image = UIImageView(image: UIImage(systemName: name, withConfiguration: configuration))
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
}
