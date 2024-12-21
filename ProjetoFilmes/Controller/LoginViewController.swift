//
//  LoginViewController.swift
//  ProjetoFilmes
//
//  Created by Ednaldo Franco on 17/12/24.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUser()
    }
    
    @IBAction func tappedLoginButton(_ sender: UIButton) {
        guard let user = userTextField.text, let password = passwordTextField.text else { return }
        
        if validateLogin(user: user, password: password) {
            performSegue(withIdentifier: "FilmesView", sender: nil)
        } else {
            AlertHelper.showAlert(title: "Erro", message: "Usuário e senha incorretos", on: self)
        }
    }
    
    
    func createUser() {
        // loading context core data
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Login> = Login.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "usuario = %@", "admin")
        
        do {
            let usuarioExists = try context.fetch(fetchRequest)
            if usuarioExists.isEmpty {
                let usuarioDefault = Login(context: context)
                usuarioDefault.id = 1
                usuarioDefault.usuario = "admin"
                usuarioDefault.senha = "admin"
                
                try context.save()
                
            }
        } catch {
            AlertHelper.showAlert(title: "Erro", message: "Error ao verificar usuário existente", on: self)
        }
    }
    
    func validateLogin(user: String, password: String) -> Bool {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Login> = Login.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "usuario = %@ AND senha = %@", user, password)
        
        do {
            let result = try context.fetch(fetchRequest)
            print("Resultado do fetch: \(result)") // Adicione este print para verificar
            return !result.isEmpty
        } catch {
            print("Erro ao validar login: \(error.localizedDescription)")
            AlertHelper.showAlert(title: "Erro", message: "Erro ao validar usuário existente", on: self)
            return false
        }
    }

}
