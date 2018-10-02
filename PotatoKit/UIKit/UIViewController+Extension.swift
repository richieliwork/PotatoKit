import Foundation

extension UIViewController {
    public func showAlertMessage(title: String, message: String, completion:(() -> Void)?, cancelTitle: String? = NSLocalizedString("取消", comment: "cancel"), cancelAction:(() -> Void)? = nil) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: { handle in
            if let cancel = cancelAction {
                cancel()
            }
        }))
        present(alert, animated: true, completion: completion)
        
    }
}
