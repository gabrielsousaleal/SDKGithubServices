//
//  ViewController.swift
//  SDKGithubServicesSample
//
//  Created by Gabriel Sousa on 10/04/21.
//

import UIKit
import SDKGithubServices

class ViewController: UIViewController {

    @IBAction func listRepositories(_ sender: Any) {
        Services.shared.getRepositories(
            language: .swift,
            page: 1,
            success: { data in
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    print(json)
                } catch {
                    print("erroMsg")
                    
                }
            }, failure: { error in
                print(error)
            })
    }
}

