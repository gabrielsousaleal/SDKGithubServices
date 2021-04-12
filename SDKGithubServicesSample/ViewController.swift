//
//  ViewController.swift
//  SDKGithubServicesSample
//
//  Created by Gabriel Sousa on 10/04/21.
//

import UIKit
import SDKGithubServices

enum CodeLanguage: String {
    case swift = "swift"
}

class ViewController: UIViewController {

    // MARK: - Constants

    private let kServiceTypeAlertTitle = "Tipo de serviço"
    private let kServiceTypeAlertMessage = "Escolha o tipo de serviço"
    private let kMockServiceTitle = "Mock"
    private let kRealServiceTitle = "Api"

    // MARK: - Private Properties

    private var service: ServicesProtocol?

    // MARK: - Private Methods

    private func openServiceTypeAlert(completion: @escaping() -> Void) {
        let alert = UIAlertController(title: kServiceTypeAlertTitle, message: kServiceTypeAlertMessage, preferredStyle: .actionSheet)
        let mockAction = UIAlertAction(title: kMockServiceTitle, style: .default) { _ in
            self.service = MockServices.shared
            completion()
        }
        let realServiceAction = UIAlertAction(title: kRealServiceTitle, style: .default) { _ in
            self.service = Services.shared
            completion()
        }
        alert.addAction(mockAction)
        alert.addAction(realServiceAction)
        present(alert, animated: true)
    }

    private func printJson(data: Data) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            
            print(json)
        } catch {
            print("erroMsg")
        }
    }

    private func getUserByUsername(username: String) {
        openServiceTypeAlert {
            self.service?.getUser(
                username: username,
                success: { data in
                    self.printJson(data: data)
                },
                failure: { error in
                    print(error)
                })
        }
    }

    // MARK: - Storyboard Actions

    @IBAction func getUser(_ sender: Any) {
        let alert = UIAlertController(title: "Usuario", message: "Digite o username/login", preferredStyle: .alert)
        alert.addTextField { (textField) in
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields?[0]
            self.getUserByUsername(username: textField?.text ?? "")
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func listRepositories(_ sender: Any) {
        openServiceTypeAlert {
            self.service?.getRepositories(
                language: CodeLanguage.swift.rawValue,
                page: 1,
                sortBy: "stars",
                success: { data in
                    self.printJson(data: data)
                 }, failure: { error in
                    print(error)
                 })
        }
    }
}
