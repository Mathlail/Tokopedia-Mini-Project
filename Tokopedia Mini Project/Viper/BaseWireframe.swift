import UIKit

enum ErrorViewType {
	case alert
	case toast
	case view
}

protocol WireframeInterface: class {
	func showHUDLoading(_ show: Bool)
	func showAlert(withTitle title: String?, message: String, cancelButtonTitle: String, confirmButtonTitle: String?, tapHandler: ((UIAlertAction) -> Void)?)
    func close()
}

class BaseWireframe {

    private unowned var _viewController: UIViewController
    
    //to retain view controller reference upon first access
    private var _temporaryStoredViewController: UIViewController?

    init(viewController: UIViewController) {
        _temporaryStoredViewController = viewController
        _viewController = viewController
    }

}

extension BaseWireframe: WireframeInterface {
	func showHUDLoading(_ show: Bool) {
		DispatchQueue.main.async {
			if show {
				self._viewController.view.activityStartAnimating(activityColor: .darkGray, backgroundColor: .clear)
			} else {
				self._viewController.view.activityStopAnimating()
				
			}
		}
    }

	func showAlert(withTitle title: String?, message: String, cancelButtonTitle: String, confirmButtonTitle: String?, tapHandler: ((UIAlertAction) -> Void)?) {
		viewController.showAlert(withTitle: title, message: message, cancelButtonTitle: cancelButtonTitle, confirmButtonTitle: confirmButtonTitle, tapHandler: tapHandler)
	}

    
    func close() {
        if (navigationController?.viewControllers.count ?? 0) > 1 {
            navigationController?.popViewController(animated: true)
        } else {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}

extension BaseWireframe {
    
    var viewController: UIViewController {
        defer { _temporaryStoredViewController = nil }
        return _viewController
    }
    
    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
}

extension UIViewController {
    
    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
    
}

extension UINavigationController {
    
    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }
    
    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
    
}
