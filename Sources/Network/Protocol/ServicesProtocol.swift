//
//  ServicesProtocol.swift
//  SDKGithubServices
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation

public enum CodeLanguage: String {
    case swift = "Swift"
    case java = "Java"
    case kotlin = "Kotlin"
}

enum HTTPMethod: String {
    case get = "GET"
}

struct Params {

    // MARK: - Constants

    private let kDefaultQueryKey = "q="

    // MARK: - Public Properties

    var method: HTTPMethod = .get
    var header: [String: Any] = [:]
    var body: [String: Any] = [:]
    var query: [String: Any] = [:]

    var queryString: String {
        var queryItemList: [URLQueryItem] = []
        query.forEach { item in
            queryItemList.append(URLQueryItem(name: item.key, value: item.value as? String))
        }
        let query = "\(kDefaultQueryKey)\(queryItemList)"
        return query
    }
}

public protocol ServicesProtocol: AnyObject {
    func getRepositories(language: CodeLanguage, page: Int, success: @escaping(Data) -> Void, failure: @escaping(Error) -> Void)
}
