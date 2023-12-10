//
//  LoginViewController.swift
//  SOL Ponto
//
//  Created by gutinha on 09/12/23.
//

import Foundation
import UIKit
import CoreData

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginAction(_ sender: UIButton){
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        let autenticated = validateUser(username: username, password: password)
        
        if autenticated {
            let homeVC =  HomeViewController(nibName: "HomeViewController", bundle: nil)
            present(homeVC, animated: true, completion: nil)
        } else{
            let alert = UIAlertController(title: "Erro de autenticacao", message: "Nome de usuario ou senha incorretos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            
        }
    }
    
    @IBAction func cadastroAction(_ sender: UIButton){
        let cadastroVC = CadastroViewController(nibName: "CadastroViewController", bundle: nil)
        //self.navigationController?.pushViewController(cadastroVC, animated: true)
        self.present(cadastroVC, animated: true, completion: nil)
    }
    
    func validateUser(username: String, password: String) -> Bool{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@ AND password == %@", username, password)
        
        do {
            let users = try context.fetch(request)
            if users.count > 0 {
                return true
            } else{
                return false
            }
        } catch{
            print("Algo deu errado")
            return false
        }
    }
}
