//
//  ProjetoFilmesTestss.swift
//  ProjetoFilmesTestss
//
//  Created by Ednaldo Franco on 26/12/24.
//

import XCTest
import CoreData
@testable import ProjetoFilmes

final class ProjetoFilmesTestss: XCTestCase {

    var context: NSManagedObjectContext!

       override func setUp() {
           super.setUp()
           context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       }

       func testLoginSenhaCorreta() {
           let loginVC = LoginViewController()
           let loginResultado = loginVC.validateLogin(user: "aluno", password: "1234")
           XCTAssertTrue(loginResultado, "O login com a senha correta deveria retornar verdadeiro.")
       }

       func testLoginSenhaIncorreta() {
           let loginVC = LoginViewController()
           let loginResultado = loginVC.validateLogin(user: "aluno", password: "1111")
           XCTAssertFalse(loginResultado, "O login com a senha incorreta deveria retornar falso.")
       }

}
