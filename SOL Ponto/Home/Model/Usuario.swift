//
//  User.swift
//  SOL Ponto
//
//  Created by gutinha on 09/12/23.
//

import Foundation
import UIKit
import CoreData

@objc(Usuario)
public class Usuario: NSManagedObject {
    @NSManaged var username: String
    @NSManaged var password: String
    @NSManaged var email: String
    
    convenience init(username: String, password: String, email: String) {
        let contexto = UIApplication.shared.delegate as! AppDelegate
        self.init (context: contexto.persistentContainer.viewContext)
         self.username = username
         self.password = password
         self.email = email
     }
}

extension Usuario {

    class func fetchRequest() -> NSFetchRequest<Usuario> {
        return NSFetchRequest(entityName: "Usuario")
    }

}
