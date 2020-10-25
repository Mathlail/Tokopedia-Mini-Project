//
//  Extensions.swift
//  Gojek-Test
//
//  Created by FDN-Fajri Ramadhan on 02/11/19.
//  Copyright © 2019 FDN-Fajri Ramadhan. All rights reserved.
//

import UIKit

extension UIColor {
	public static func hexStringToUIColor (hex:String) -> UIColor {
		var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

		if (cString.hasPrefix("#")) {
			cString.remove(at: cString.startIndex)
		}

		if ((cString.count) != 6) {
			return UIColor.gray
		}

		var rgbValue:UInt64 = 0
		Scanner(string: cString).scanHexInt64(&rgbValue)

		return UIColor(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}
	
	public static let greenForTest: UIColor = {
		return UIColor.hexStringToUIColor(hex: "#50E3C2")
	}()
	
	public static let grayTextField: UIColor = {
		return UIColor.hexStringToUIColor(hex: "#4A4A4A")
	}()
}

extension UIView {
	var layoutGuide: UILayoutGuide {
		if #available(iOS 11, *) {
			return self.safeAreaLayoutGuide
		} else {
			self.layoutMargins = .zero
			return self.layoutMarginsGuide
		}
	}
	
	func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
		let backgroundView = UIView()
		backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
		backgroundView.backgroundColor = backgroundColor
		backgroundView.tag = 475647

		var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
		activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
		activityIndicator.center = self.center
		activityIndicator.hidesWhenStopped = true
		activityIndicator.style = UIActivityIndicatorView.Style.large
		activityIndicator.color = activityColor
		activityIndicator.startAnimating()
		self.isUserInteractionEnabled = false

		backgroundView.addSubview(activityIndicator)
		backgroundView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
		self.addSubview(backgroundView)
	}

	func activityStopAnimating() {
		if let background = viewWithTag(475647){
			background.removeFromSuperview()
		}
		self.isUserInteractionEnabled = true
	}
}

extension UIScreen {
	
	static var screenHeight: CGFloat {
		return UIScreen.main.bounds.height
	}
	
	static var screenWidth: CGFloat {
		return UIScreen.main.bounds.width
	}
	
	static var screenSize: CGSize {
		return UIScreen.main.bounds.size
	}
	
	static var screenBounds: CGRect {
		return UIScreen.main.bounds
	}
    
    static func getStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
	
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

extension UIViewController {
	func showAlert(withTitle title: String? = nil, message: String, cancelButtonTitle: String = "OK", confirmButtonTitle: String? = nil, tapHandler: ((UIAlertAction) -> Void)? = nil) {
		if message.lowercased() != "cancelled" && !message.contains("502") && !message.contains("WebAuthenticationSession") {
			let action = UIAlertAction(title: cancelButtonTitle,
									   style: .cancel,
									   handler: (confirmButtonTitle == nil) ? tapHandler : nil)
			let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
			
			if let confirmButtonTitle = confirmButtonTitle {
				let action = UIAlertAction(title: confirmButtonTitle,
										   style: .default,
										   handler: tapHandler)
				alertController.addAction(action)
			}
			
			alertController.addAction(action)
			
			DispatchQueue.main.async { [weak self] in
				self?.present(alertController, animated: true, completion: nil)
			}
		}
	}
}


extension UIColor {
    static let tokopediaGreen = UIColor(red: 77.0/255.0, green: 169.0/255.0, blue: 52.0/255.0, alpha: 1)
}
