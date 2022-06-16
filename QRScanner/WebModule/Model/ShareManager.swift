import Foundation
import UIKit

class ShareManager {
    
    weak var delegate: PresentViewProtocol?
    
    func showShare(url: URL) {
        guard let pdfData = NSMutableData(contentsOf: url) else { return }
        
        let filename = url.lastPathComponent == "/" ? "index.html" : url.lastPathComponent
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let pdfPath = paths.first?.appendingPathComponent(filename) else { return }
        pdfData.write(to: pdfPath, atomically: true)
        
        let shareSheet = UIActivityViewController(activityItems: [pdfPath], applicationActivities: nil)
        shareSheet.completionWithItemsHandler = { [unowned self] (activity, success, _, error) in
            if let activity = activity, activity.rawValue.contains("SaveToFiles") {
                let alert = UIAlertController(title: success ? "Успешно сохранено" : "Ошибка",
                                              message: error?.localizedDescription,
                                              preferredStyle: .alert)
                let alertButton = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(alertButton)
                
                self.delegate?.showPresent(view: alert)
            }
        }
        delegate?.showPresent(view: shareSheet)
    }
}
