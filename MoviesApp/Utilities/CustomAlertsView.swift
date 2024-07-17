//
//  CustomAlertsView.swift
//  MoviesApp
//
//  Created by Ramiro Gutierrez on 14/07/24.
//

import Foundation
import UIKit

class CustomAlertsView: UIViewController {
    
    func alertWithTwOptions(viewController: UIViewController, title: String = "", message: String = "", buttonOneTitle: String = "", buttonTwoTitle: String = "Cancelar", buttonOneActionHandler: (() -> Void)? = nil, buttonTwoActionHandler: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let firstButtonAction = UIAlertAction(title: buttonOneTitle, style: .default) { (_) in
            buttonOneActionHandler?()
        }
        alertController.addAction(firstButtonAction)
        
        let secondButtonAction = UIAlertAction(title: buttonTwoTitle, style: .default) { (_) in
            buttonTwoActionHandler?()
        }
        alertController.addAction(secondButtonAction)
        
        viewController.present(alertController, animated: true)
    }
}
