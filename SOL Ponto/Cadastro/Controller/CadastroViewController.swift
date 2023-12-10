//
//  CadastroControllerView.swift
//  SOL Ponto
//
//  Created by gutinha on 09/12/23.
//

import Foundation
import UIKit
import CoreData

class CadastroViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func cadastroButtonTapped(_ sender: UIButton){
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let email = emailTextField.text, !email.isEmpty, isValidEmail(email) else
        {
            let alert = UIAlertController(title: "Erro ao cadastrar", message: "Padrao de email incorreto.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        registerUser(username: username, password: password, email: email)
                
    }
    
    func isValidEmail(_ email: String) -> Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    func registerUser(username: String, password: String, email: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = Usuario(context: context)
        newUser.username = username
        newUser.password = password
        newUser.email = email
        
        do{
            try context.save()
            let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
            present(homeVC, animated: true, completion: nil)
        } catch {
            let alert = UIAlertController(title: "Erro ao cadastrar", message: "Nao foi possivel cadastrar.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
