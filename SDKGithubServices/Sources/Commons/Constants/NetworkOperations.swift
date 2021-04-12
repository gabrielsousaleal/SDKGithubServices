//
//  NetworkOperations.swift
//  SDKGithubServices
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation

struct NetworkOperations {
    let repositoriesList = URLComponents(string: "https://api.github.com/search/repositories")
    let user = "https://api.github.com/users/%@"
}
