//
//  AlertHelper.swift
//  ProjetoFilmes
//
//  Created by Ednaldo Franco on 17/12/24.
//
import UIKit

class AlertHelper {
    static func showAlert(title: String, message: String, on viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}


